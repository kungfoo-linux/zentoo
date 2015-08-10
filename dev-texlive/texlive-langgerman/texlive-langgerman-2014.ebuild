# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

TEXLIVE_MODULE_CONTENTS="babel-german bibleref-german booktabs-de csquotes-de dehyph-exptl dhua einfuehrung etoolbox-de fifinddo-info geometry-de german germbib germkorr hausarbeit-jura hyphen-german koma-script-examples l2picfaq l2tabu latex-bib-ex latex-referenz latex-tabellen lshort-german lualatex-doc-de microtype-de presentations pstricks-examples r_und_s templates-fenn templates-sommer texlive-de tipa-de translation-arsclassica-de translation-biblatex-de translation-chemsym-de translation-ecv-de translation-enumitem-de translation-europecv-de translation-filecontents-de translation-moreverb-de udesoftec umlaute voss-mathcol collection-langgerman
"
TEXLIVE_MODULE_DOC_CONTENTS="babel-german.doc bibleref-german.doc booktabs-de.doc csquotes-de.doc dehyph-exptl.doc dhua.doc einfuehrung.doc etoolbox-de.doc fifinddo-info.doc geometry-de.doc german.doc germbib.doc germkorr.doc hausarbeit-jura.doc koma-script-examples.doc l2picfaq.doc l2tabu.doc latex-bib-ex.doc latex-referenz.doc latex-tabellen.doc lshort-german.doc lualatex-doc-de.doc microtype-de.doc presentations.doc pstricks-examples.doc r_und_s.doc templates-fenn.doc templates-sommer.doc texlive-de.doc tipa-de.doc translation-arsclassica-de.doc translation-biblatex-de.doc translation-chemsym-de.doc translation-ecv-de.doc translation-enumitem-de.doc translation-europecv-de.doc translation-filecontents-de.doc translation-moreverb-de.doc udesoftec.doc umlaute.doc voss-mathcol.doc "
TEXLIVE_MODULE_SRC_CONTENTS="babel-german.source dhua.source fifinddo-info.source german.source hausarbeit-jura.source udesoftec.source umlaute.source "
inherit  texlive-module
DESCRIPTION="TeXLive German"

LICENSE=" FDL-1.1 GPL-1 GPL-2 LPPL-1.3 OPL TeX-other-free "
SLOT="0"
KEYWORDS="amd64"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2014
!<dev-texlive/texlive-latexextra-2009
!dev-texlive/texlive-documentation-german
"
RDEPEND="${DEPEND} "
