#!/bin/sh
KDEVER=$1
SVNREV=$2

LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu fa fi fr
	fy ga gl gu he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta te tg
	th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

# Update repo
svn up -r ${SVNREV} kde-l10n
# copy repo
cp -r kde-l10n kde-l10n_packages
cd kde-l10n_packages
for ${LNG} in ${LANGS}; do
	rm -rf ./${LNG}/messages/{extragear-*,koffice,playground-*,qt,kdevelop,kdereview}
	./scripts/autogen.sh ${LNG}
	mv ${LNG} kde-l10n-${LNG}-${KDEVER}
	cd kde-l10n-${LNG}-${KDEVER}
	find . -xtype d -iname .svn | xargs rm -rf
	cd ../
	tar cpf kde-l10n-${LNG}-${KDEVER}.tar kde-l10n-${LNG}-${KDEVER}
	xz -9 -v kde-l10n-${LNG}-${KDEVER}.tar
	rm -rf kde-l10n-${LNG}-${KDEVER}
done
