#!/usr/bin/env python3
#
# Copyright (c) 2017-2018 Michael Palimaka <kensington@gentoo.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import argparse
import os
import sys
import subprocess
import cmake_dep_check as cdc
import portage


def qatom(atom):
	output = subprocess.check_output(['qatom', '--format', '%{CATEGORY}|%{PN}|%{PV}|%[PR]|%[SLOT]|%[pfx]|%[sfx]', atom])
	return output.decode('utf-8').split('|')


def get_cmake_deps(ebuild, repo):
	cpv = qatom(ebuild)
	settings = portage.config(config_root='/')

	tmpdir = os.path.join(settings.get('PORTAGE_TMPDIR'), 'portage')
	tmp_path = os.path.join(tmpdir, cpv[0], cpv[1] + '-' + cpv[2])
	repo_path = portage.db['/']["vartree"].settings.repositories.treemap.get(repo)
	ebuild_path = os.path.join(repo_path, cpv[0], cpv[1], cpv[1] + '-' + cpv[2] + '.ebuild')

	subprocess.call(['ebuild', ebuild_path, 'clean', 'prepare'], stdout=subprocess.DEVNULL)

	deps = cdc.getDeps(os.path.join(tmp_path))

	subprocess.call(['ebuild', ebuild_path, 'clean'])

	return deps


def get_ebuild_deps(ebuild):
	porttree = portage.db[portage.root]['porttree']
	depstr = porttree.dbapi.aux_get(ebuild, ['DEPEND', 'RDEPEND', 'PDEPEND'])

	depend = portage.dep.use_reduce(depstr[0], matchall=True, flat=True)
	rdepend = portage.dep.use_reduce(depstr[1], matchall=True, flat=True)
	pdepend = portage.dep.use_reduce(depstr[2], matchall=True, flat=True)

	all_depend = set(depend + rdepend + pdepend)

	return(all_depend)


def get_ebuild_repo(ebuild):
	porttree = portage.db[portage.root]['porttree']
	repo = porttree.dbapi.aux_get(ebuild, ['repository'])

	return repo[0]


def clean_dep(dep):
	if dep.startswith('!') or dep == '||':
		return False

	parts = qatom(dep)
	cp = parts[0] + '/' + parts[1]

	return cp


def main():
	parser = argparse.ArgumentParser(description='Compare CMakeLists.txt and ebuild dependencies')
	parser.add_argument('ebuild', help='app-foo/bar-1.2.3', nargs=1)
	parser.add_argument('--possible-bogus-ebuild', dest='bogusebuild', action='store_const', const=True, help='Show dependencies that appear in CMakeLists.txt but not the ebuild')

	args = parser.parse_args()

	ebuild = args.ebuild[0]

	ebuild_deps = get_ebuild_deps(ebuild)
	cmake_deps = get_cmake_deps(ebuild, get_ebuild_repo(ebuild))

	cmake_deps_merged = []

	for cmake, deps in cmake_deps.items():
		for dep in deps:
			if dep.startswith('ERROR'):
				print(dep)
				continue
			if len(dep) == 0:
				continue
			clean = clean_dep(dep)
			if clean:
				cmake_deps_merged.append(clean)

	ebuild_deps_clean = []

	for dep in ebuild_deps:
		clean = clean_dep(dep)
		if clean:
			ebuild_deps_clean.append(clean)

	missing_cmake = []
	missing_ebuild = []

	for dep in cmake_deps_merged:
		if dep not in ebuild_deps_clean:
			missing_ebuild.append(dep)

	for dep in ebuild_deps_clean:
		if dep not in cmake_deps_merged:
			missing_cmake.append(dep)

	missing_cmake = sorted(set(missing_cmake))
	missing_ebuild = sorted(set(missing_ebuild))

	if len(missing_ebuild) > 0:
		print('DEPENDENCIES IN CMAKELISTS BUT NOT EBUILD:')
		print('==========================================')
		for dep in missing_ebuild:
			print(dep)
	else:
		print('Did not find any dependencies in CMakeLists that do not appear in the ebuild')

	if len(missing_cmake) > 0 and args.bogusebuild is True:
		print('DEPENDENCIES IN EBUILD BUT NOT IN CMAKELISTS:')
		print('=============================================')
		for dep in missing_cmake:
			print(dep)


if __name__ == '__main__':
	sys.exit(main())
