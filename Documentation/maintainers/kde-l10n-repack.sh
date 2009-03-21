#!/bin/sh
KDEVER=$1
SVNREV=$2

LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu fa fi fr
	fy ga gl gu he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta te tg
	th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

for lng in ${LANGS}
do
svn up -r ${SVNREV} kde-l10n-${lng}
done

svn up -r ${SVNREV} scripts

for lng in ${LANGS}
do
	cp -r kde-l10n-${lng} kde-l10n-${lng}-${KDEVER}
	cp -r scripts kde-l10n-${lng}-${KDEVER}/
	rm -rf kde-l10n-${lng}-${KDEVER}/{docmessages,messages,docs}/extragear*
	rm -rf kde-l10n-${lng}-${KDEVER}/{docmessages,messages,docs}/playground*
	rm -rf kde-l10n-${lng}-${KDEVER}/{docmessages,messages,docs}/koffice
	rm -rf kde-l10n-${lng}-${KDEVER}/{docmessages,messages,docs}/kdevelop
	rm -rf kde-l10n-${lng}-${KDEVER}/{docmessages,messages,docs}/qt
	cd kde-l10n-${lng}-${KDEVER}
	find . -xtype d -iname .svn | xargs rm -rf
	cd ../
	tar cpf kde-l10n-${lng}-${KDEVER}.tar kde-l10n-${lng}-${KDEVER}
	lzma -9 kde-l10n-${lng}-${KDEVER}.tar
	rm -rf kde-l10n-${lng}-${KDEVER}
done
