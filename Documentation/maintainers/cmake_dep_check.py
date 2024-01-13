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

import os
import sys

import parse_cmake.parsing as cmp

IGNORE_ARGS = ['COMPONENTS', 'CONFIG', 'MODULE', 'NO_MODULE', 'OPTIONAL_COMPONENTS', 'REQUIRED', 'QUIET']
COMPONENT_PACKAGES = ['KF5', 'Poppler', 'Qt5', 'XCB']
PACKAGE_MAP = {
	'AccountsQt5': 'net-libs/accounts-qt',
	'ACL': 'virtual/acl',
	'Analitza5': 'kde-apps/analitza',
	'AppStreamQt': 'dev-libs/appstream[qt5]',
	'AvogadroLibs': 'sci-chemistry/avogadro',
	'Boost': 'dev-libs/boost',
	'Breeze': 'kde-plasma/breeze',
	'Canberra': 'media-libs/libcanberra',
	'CatDoc': 'app-text/catdoc',
	'DBus': 'sys-apps/dbus',
	'DBusGLib': 'dev-libs/dbus-glib',
	'dbusmenu-qt5': 'dev-libs/libdbusmenu-qt',
	'DDCUtil': 'app-misc/ddcutil',
	'Doxygen': 'app-text/doxygen',
	'DvdRead': 'media-libs/libdvdread',
	'ECM': 'kde-frameworks/extra-cmake-modules',
	'EGL': 'media-libs/mesa[egl]',
	'Eigen3': 'dev-cpp/eigen:3',
	'epoxy': 'media-libs/libepoxy',
	'EPub': 'app-text/ebook-tools',
	'Exiv2': 'media-gfx/exiv2',
	'FFmpeg': 'media-video/ffmpeg',
	'Flac': 'media-libs/flac',
	'Flac++': 'media-libs/flac[cxx]',
	'Fontconfig': 'media-libs/fontconfig',
	'FontHack': 'media-fonts/hack',
	'FontNotoSans': 'media-fonts/noto',
	'Freetype': 'media-libs/freetype',
	'GIO': 'dev-libs/glib',
	'GLEW': 'media-libs/glew:0',
	'GLIB2': 'dev-libs/glib',
	'GObject': 'dev-libs/glib',
	'Gpgmepp': 'app-crypt/gpgme[cxx]',
	'GSL': 'sci-libs/gsl',
	'GSSAPI': 'virtual/krb5',
	'IBus': 'app-i18n/ibus',
	'Iconv': 'virtual/libiconv',
	'IsoCodes': 'app-text/iso-codes',
	'Julia': 'dev-lang/julia',
	'KDb': 'dev-db/kdb',
	'KDecoration2': 'kde-plasma/kdecoration',
	'KDED': 'kde-frameworks/kded',
	'KDEExperimentalPurpose': 'kde-frameworks/purpose',
	'KF5Akonadi': 'kde-apps/akonadi',
	'KF5AkonadiMime': 'kde-apps/akonadi-mime',
	'KF5Attica': 'kde-frameworks/attica',
	'KF5Baloo': 'kde-frameworks/baloo',
	'KF5BluezQt': 'kde-frameworks/bluez-qt',
	'KF5Cddb': 'kde-apps/libkcddb',
	'KF5Contacts': 'kde-apps/kcontacts',
	'KF5FrameworkIntegration': 'kde-frameworks/frameworkintegration',
	'KF5Activities': 'kde-frameworks/kactivities',
	'KF5ActivitiesStats': 'kde-frameworks/kactivities-stats',
	'KF5Archive': 'kde-frameworks/karchive',
	'KF5Auth': 'kde-frameworks/kauth',
	'KF5Bookmarks': 'kde-frameworks/kbookmarks',
	'KF5KCMUtils': 'kde-frameworks/kcmutils',
	'KF5Codecs': 'kde-frameworks/kcodecs',
	'KF5Completion': 'kde-frameworks/kcompletion',
	'KF5Config': 'kde-frameworks/kconfig',
	'KF5ConfigWidgets': 'kde-frameworks/kconfigwidgets',
	'KF5CoreAddons': 'kde-frameworks/kcoreaddons',
	'KF5Crash': 'kde-frameworks/kcrash',
	'KF5DBusAddons': 'kde-frameworks/kdbusaddons',
	'KF5Declarative': 'kde-frameworks/kdeclarative',
	'KF5KDE4Support': 'kde-frameworks/kdelibs4support',
	'KF5KDELibs4Support': 'kde-frameworks/kdelibs4support',
	'KF5DesignerPlugin': 'kde-frameworks/kdesignerplugin',
	'KF5Su': 'kde-frameworks/kdesu',
	'KF5WebKit': 'kde-frameworks/kdewebkit',
	'KF5DNSSD': 'kde-frameworks/kdnssd',
	'KF5DocTools': 'kde-frameworks/kdoctools',
	'KF5Emoticons': 'kde-frameworks/kemoticons',
	'KF5FileMetaData': 'kde-frameworks/kfilemetadata',
	'KF5GlobalAccel': 'kde-frameworks/kglobalaccel',
	'KF5GuiAddons': 'kde-frameworks/kguiaddons',
	'KF5KHtml': 'kde-frameworks/khtml',
	'KF5Holidays': 'kde-frameworks/kholidays',
	'KF5I18n': 'kde-frameworks/ki18n',
	'KF5IconThemes': 'kde-frameworks/kiconthemes',
	'KF5IdleTime': 'kde-frameworks/kidletime',
	'KF5Init': 'kde-frameworks/kinit',
	'KF5KDEGames': 'kde-apps/libkdegames',
	'KF5KIO': 'kde-frameworks/kio',
	'KF5Kirigami2': 'kde-frameworks/kirigami',
	'KF5ItemModels': 'kde-frameworks/kitemmodels',
	'KF5ItemViews': 'kde-frameworks/kitemviews',
	'KF5JobWidgets': 'kde-frameworks/kjobwidgets',
	'KF5JS': 'kde-frameworks/kjs',
	'KF5JsEmbed': 'kde-frameworks/kjsembed',
	'KF5MediaWiki': 'net-libs/libmediawiki',
	'KF5Mime': 'kde-apps/kmime',
	'KF5ModemManagerQt': 'kde-frameworks/modemmanager-qt',
	'KF5NewStuff': 'kde-frameworks/knewstuff',
	'KF5NewStuffCore': 'kde-frameworks/knewstuff',
	'KF5NewStuffQuick': 'kde-frameworks/knewstuff',
	'KF5Notifications': 'kde-frameworks/knotifications',
	'KF5NotifyConfig': 'kde-frameworks/knotifyconfig',
	'KF5Package': 'kde-frameworks/kpackage',
	'KF5Parts': 'kde-frameworks/kparts',
	'KF5People': 'kde-frameworks/kpeople',
	'KF5Plotting': 'kde-frameworks/kplotting',
	'KF5Prison': 'kde-frameworks/prison',
	'KF5Pty': 'kde-frameworks/kpty',
	'KF5Purpose': 'kde-frameworks/purpose',
	'KF5Kross': 'kde-frameworks/kross',
	'KF5Runner': 'kde-frameworks/krunner',
	'KF5Service': 'kde-frameworks/kservice',
	'KF5SysGuard': 'kde-plasma/libksysguard',
	'KF5TextEditor': 'kde-frameworks/ktexteditor',
	'KF5TextWidgets': 'kde-frameworks/ktextwidgets',
	'KF5Torrent': 'net-libs/libktorrent',
	'KF5UnitConversion': 'kde-frameworks/kunitconversion',
	'KF5Wallet': 'kde-frameworks/kwallet',
	'KF5Wayland': 'kde-frameworks/kwayland',
	'KF5WidgetsAddons': 'kde-frameworks/kwidgetsaddons',
	'KF5WindowSystem': 'kde-frameworks/kwindowsystem',
	'KF5XmlGui': 'kde-frameworks/kxmlgui',
	'KF5XmlRpcClient': 'kde-frameworks/kxmlrpcclient',
	'KF5NetworkManagerQt': 'kde-frameworks/networkmanager-qt',
	'KF5Plasma': 'kde-frameworks/plasma',
	'KF5PlasmaQuick': 'kde-frameworks/plasma',
	'KF5Screen': 'kde-plasma/libkscreen',
	'KF5Solid': 'kde-frameworks/solid',
	'KF5Sonnet': 'kde-frameworks/sonnet',
	'KF5SyntaxHighlighting': 'kde-frameworks/syntax-highlighting',
	'KF5ThreadWeaver': 'kde-frameworks/threadweaver',
	'KPropertyCore': 'dev-libs/kproperty',
	'KPropertyWidgets': 'dev-libs/kproperty',
	'KReport': 'dev-libs/kreport',
	'KScreenLocker': 'kde-plasma/kscreenlocker',
	'KWinDBusInterface': 'kde-plasma/kwin',
	'Lame': 'media-sound/lame',
	'LibAccountsGlib': 'net-libs/libaccounts-glib',
	'Libcap': 'sys-libs/libcap',
	'Libdrm': 'x11-libs/libdrm',
	'Libfacile': 'dev-ml/facile',
	'LibGcrypt': 'dev-libs/libgcrypt:0=',
	'libgps': 'sci-geosciences/gpsd',
	'Libinput': 'dev-libs/libinput',
	'LibKWorkspace': 'kde-plasma/plasma-workspace',
	'LibSpectre': 'app-text/libspectre',
	'LibTaskManager': 'kde-plasma/plasma-workspace',
	'LibTidy': 'app-text/htmltidy',
	'LibXml2': 'dev-libs/libxml2',
	'LibXslt': 'dev-libs/libxslt',
	'loginctl': '|| ( sys-auth/elogind sys-apps/systemd )',
	'LuaJIT': 'dev-lang/luajit',
	'Mad': 'media-libs/libmad',
	'MobileBroadbandProviderInfo': 'net-misc/mobile-broadband-provider-info',
	'MusicBrainz': 'media-libs/musicbrainz',
	'MySQL': 'dev-db/mysql',
	'NetworkManager': 'net-misc/networkmanager',
	'OpenBabel2': 'sci-chemistry/openbabel',
	'OpenConnect': 'net-vpn/openconnect:=',
	'OpenGL': 'virtual/opengl',
	'OpenSSL': 'dev-libs/openssl:0=',
	'Phonon4Qt5': 'media-libs/phonon',
	'PkgConfig': 'virtual/pkgconfig',
	'Polkit': 'sys-auth/polkit',
	'PopplerQt5': 'app-text/poppler[qt5]',
	'PostgreSQL': 'dev-db/postgresql',
	'PulseAudio': 'media-sound/pulseaudio',
	'PWQuality': 'dev-libs/libpwquality',
	'PythonInterp': 'dev-lang/python',
	'PythonLibrary': 'dev-lang/python',
	'PythonLibs': 'dev-lang/python',
	'PythonLibs3': 'dev-lang/python',
	'R': 'dev-lang/R',
	'Ruby': 'dev-lang/ruby',
	'SharedMimeInfo': 'x11-misc/shared-mime-info',
	'Samplerate': 'media-libs/libsamplerate',
	'SCIM': 'app-i18n/scim',
	'ScreenSaverDBusInterface': 'kde-plasma/kscreenlocker',
	'Seccomp': 'sys-libs/libseccomp',
	'SignOnQt5': 'net-libs/signond',
	'Sndfile': 'media-libs/libsndfile',
	'Synaptics': 'x11-drivers/xf86-input-synaptics',
	'Taglib': 'media-libs/taglib',
	'TelepathyGlib': 'net-libs/telepathy-glib',
	'TelepathyLogger': 'net-im/telepathy-logger',
	'TelepathyQt5': 'net-libs/telepathy-qt',
	'Threads': '',
	'Qalculate': 'sci-libs/libqalculate',
	'Qca-qt5': 'app-crypt/qca[qt5]',
	'Qt5Bluetooth': 'dev-qt/qtbluetooth',
	'Qt5Concurrent': 'dev-qt/qtconcurrent',
	'Qt5Core': 'dev-qt/qtcore',
	'Qt5DBus': 'dev-qt/qtdbus',
	'Qt5Designer': 'dev-qt/designer',
	'Qt5GStreamer': 'media-libs/qt-gstreamer',
	'Qt5Gui': 'dev-qt/qtgui',
	'Qt5Help': 'dev-qt/qthelp',
	'Qt5LinguistTools': 'dev-qt/linguist-tools',
	'Qt5Location': 'dev-qt/qtlocation',
	'Qt5Multimedia': 'dev-qt/qtmultimedia',
	'Qt5MultimediaWidgets': 'dev-qt/qtmultimedia',
	'Qt5Network': 'dev-qt/qtnetwork',
	'Qt5OpenGL': 'dev-qt/qtopengl',
	'Qt5OpenGLExtensions': 'dev-qt/qtgui',
	'Qt5Positioning': 'dev-qt/qtpositioning',
	'Qt5PrintSupport': 'dev-qt/qtprintsupport',
	'Qt5Qml': 'dev-qt/qtdeclarative',
	'Qt5QuickControls2': 'dev-qt/qtquickcontrols2',
	'Qt5QuickControls': 'dev-qt/qtquickcontrols',
	'Qt5Quick': 'dev-qt/qtdeclarative',
	'Qt5QuickTest': 'dev-qt/qtdeclarative',
	'Qt5QuickWidgets': 'dev-qt/qtdeclarative',
	'Qt5Script': 'dev-qt/qtscript',
	'Qt5ScriptTools': 'dev-qt/qtscript',
	'Qt5Scxml': 'dev-qt/qtscxml',
	'Qt5Sensors': 'dev-qt/qtsensors',
	'Qt5SerialPort': 'dev-qt/qtserialport',
	'Qt5Sql': 'dev-qt/qtsql',
	'Qt5Svg': 'dev-qt/qtsvg',
	'Qt5Test': 'dev-qt/qttest',
	'Qt5TextToSpeech': 'dev-qt/qtspeech',
	'Qt5UiPlugin': 'dev-qt/designer',
	'Qt5UiTools': 'dev-qt/designer',
	'Qt5WaylandClient': 'dev-qt/qtwayland',
	'Qt5WaylandCompositor': 'dev-qt/qtwayland',
	'Qt5WebChannel': 'dev-qt/qtwebchannel',
	'Qt5WebEngineCore': 'dev-qt/qtwebengine',
	'Qt5WebEngine': 'dev-qt/qtwebengine',
	'Qt5WebEngineWidgets': 'dev-qt/qtwebengine',
	'Qt5WebKit': 'dev-qt/qtwebkit',
	'Qt5WebKitWidgets': 'dev-qt/qtwebkit',
	'Qt5WebSockets': 'dev-qt/qtwebsockets',
	'Qt5WebView': 'dev-qt/qtwebview',
	'Qt5Widgets': 'dev-qt/qtwidgets',
	'Qt5X11Extras': 'dev-qt/qtx11extras',
	'Qt5Xml': 'dev-qt/qtxml',
	'Qt5XmlPatterns': 'dev-qt/qtxmlpatterns',
	'UDev': 'virtual/udev',
	'Wayland': 'dev-libs/wayland',
	'WaylandScanner': 'dev-libs/wayland',
	'X11': 'x11-libs/libX11',
	'Xattr': 'sys-apps/attr',
	'XCBCOMPOSITE': 'x11-libs/libxcb',
	'XCBDAMAGE': 'x11-libs/libxcb',
	'XCBDPMS': 'x11-libs/libxcb',
	'XCBIMAGE': 'x11-libs/xcb-util-image',
	'XCBKEYSYMS': 'x11-libs/xcb-util-keysyms',
	'XCBMODULE': 'x11-libs/libxcb',
	'XCBRANDR': 'x11-libs/libxcb',
	'XCBRENDER': 'x11-libs/libxcb',
	'XCBSHAPE': 'x11-libs/libxcb',
	'XCBSHM': 'x11-libs/libxcb',
	'XCBUTIL': 'x11-libs/xcb-util',
	'XCBXCB': 'x11-libs/libxcb',
	'XCBXFIXES': 'x11-libs/libxcb',
	'XCBXTEST': 'x11-libs/libxcb',
	'ZLIB': 'sys-libs/zlib',
}


def findCmakeFiles(path):
	cmakeFiles = []
	for root, dirs, files in os.walk(path):
		for file in files:
			if file == 'CMakeLists.txt':
				cmakeFiles.append(os.path.join(root, file))

	return cmakeFiles


def parseCmakeFile(file):
	with open(file) as f:
		contents = f.read()

	parsed = cmp.parse(contents)

	packages = []

	for x in parsed:
		if x.__class__.__name__ == 'Command' and x.name == 'find_package':
			package = []
			for arg in x.body:
				if arg.contents in IGNORE_ARGS or arg.contents.startswith('$') or arg.contents[0].isdigit():
					continue
				package.append(arg.contents)

			packages.append(package)

	return packages


def getMapping(package):
	if package in PACKAGE_MAP:
		if len(PACKAGE_MAP[package]) >= 1:
			return PACKAGE_MAP[package]
		else:
			return ''
	else:
		return 'ERROR: could not find a mapping for ' + package


def getDeps(path):
	cmakeFiles = findCmakeFiles(path)

	mappings = {}
	for file in cmakeFiles:
		find_packages = parseCmakeFile(file)
		mappings[file] = []

		for package in find_packages:
			if package[0] in COMPONENT_PACKAGES:
				for component in package[1:]:
					mappings[file].append(getMapping(package[0] + component))
			else:
				mappings[file].append(getMapping(package[0]))

	return mappings

def main():
	mappings = getDeps('.')
	for key, value in mappings.items():
		if len(value) >= 1:
			for package in sorted(set(value)):
				if package:
					print('	' + package)


if __name__ == '__main__':
	sys.exit(main())
