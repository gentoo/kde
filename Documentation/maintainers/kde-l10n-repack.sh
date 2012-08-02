#!/bin/sh
KDEVER=$1
SVNREV=$2

LANGS="af ar as ast be be@latin bg bn bn_IN br ca ca@valencia crh cs csb cy da de el en_GB eo es et eu fa fi fr fy ga gl gu ha he hi hne hr hsb hu hy ia id is it ja ka kk km kn ko ku lb lt lv mai mk ml mr ms mt nb nds ne nl nn nso oc or pa pl ps pt pt_BR ro ru rw se si sk sl sr sr@ijekavian sr@ijekavianlatin sr@latin sv ta te tg th tr uk uz uz@cyrillic vi wa xh zh_CN zh_HK zh_TW"

# Update repo
svn up -r ${SVNREV} kde-l10n
# copy repo
cp -r kde-l10n kde-l10n_packages
cd kde-l10n_packages
for L in ${LANGS}; do
	rm -rf ./${L}/messages/{extragear-*,playground-*,qt,kdevelop,kdereview}
	./scripts/autogen.sh ${L}
	mv ${L} kde-l10n-${L}-${KDEVER}
	cd kde-l10n-${L}-${KDEVER}
	find . -xtype d -iname .svn | xargs rm -rf
	cd ../
	tar cpf kde-l10n-${L}-${KDEVER}.tar kde-l10n-${L}-${KDEVER}
	xz -9 -v kde-l10n-${L}-${KDEVER}.tar
	rm -rf kde-l10n-${L}-${KDEVER}
done
