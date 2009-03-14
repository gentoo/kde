#!/bin/bash

run_scanelf()
{
	KEY=
	for dep in `scanelf -yBF '%f %n' "${1}"`; do
		if [[ -z ${KEY} ]]; then
			KEY="${dep}"
			continue
		fi
		echo ${dep}
	done
}

if [[ "${1}" = --internal ]]; then
	if [[ -f "${2}" && -x "${2}" && ! -L "${2}" ]]; then
		LINK=`run_scanelf "${2}"`
		[[ -n ${LINK} ]] && echo -e ${LINK//,/\\n}
		exit 0
	fi
	exit 1
fi

[[ -z $* ]] && echo "usage: `basename $0` <package>" && exit 0

if ! portageq has_version ${ROOT}/ ${1}; then
	echo "${1} is not installed"
	exit 1
fi

TMPFILE=`mktemp`
LDLIBS=`/sbin/ldconfig -p`

for cpv in `portageq match ${ROOT}/ ${1}`; do
	echo "Processing ${cpv}"
	qfile -eR ${ROOT} `portageq contents ${ROOT}/ ${cpv} | xargs -r -L 1 "${0}" --internal | sort -u` | cut -f1 -d' ' | sort -u
done
rm -f ${TMPFILE}
