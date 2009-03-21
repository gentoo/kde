LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu fa fi fr
	fy ga gl gu he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta te tg
	th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

for lng in ${LANGS}
do
svn co svn://anonsvn.kde.org/home/kde/trunk/l10n-kde4/${lng} kde-l10n-${lng}
done
