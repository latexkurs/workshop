% !TEX encoding = UTF-8 Unicode
% © 2016–2021 Moritz Brinkmann, CC-by-sa
% https://ma.latexkurs.de


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-slides}[2018/01/26 v0.1 beamer slides for LaTeX Workshop]

\RequirePackage{kvoptions,ifthen,xparse}
\SetupKeyvalOptions{
	family=latexkurspre,
	prefix=ltxkurspre@,
}
\DeclareBoolOption{web}
\ProcessKeyvalOptions{latexkurspre}


%% PDF Annotations for web release
\newif\ifwebrelease
\def\makewebreleasefalse{\webreleasefalse}
\def\makewebreleasetrue{\webreleasetrue}
\ifltxkurspre@web
	\makewebreleasetrue
%	\RequirePackage{pdfcomment}
	\providecommand{\pdfmarginpar}[2][]{\null}%pdfmargincomment[#1]{#2}}
	\PassOptionsToClass{handout}{beamer}
\else
	\makewebreleasefalse
	\providecommand{\pdfmarginpar}[2][]{\null}
	\PassOptionsToClass{presentation}{beamer}
\fi

%% Load Beamer Class and set
\LoadClass[aspectratio=169]{beamer}


%% Language
\RequirePackage{polyglossia}
\setmainlanguage{german}
\setotherlanguage{english}

%% Fonts
\usefonttheme{professionalfonts}
\RequirePackage{csquotes, fontspec, microtype, unicode-math}
\setmainfont{Libertinus Serif}
\setsansfont{Libertinus Sans}
\setmonofont[Scale=.95,AutoFakeSlant]{Inconsolata}
\setmathfont[AutoFakeBold]{Libertinus Math}

%% Layout
%\mode<presentation>{
	\useinnertheme{circles}
	\usecolortheme[rgb={0,0,.5}]{structure}
	\usecolortheme{whale}
	\usecolortheme{orchid}
	\beamertemplatenavigationsymbolsempty
	\setbeamercolor{alerted text}{fg=blue}
	\renewcommand{\thefootnote}{\fnsymbol{footnote}}
	\setbeamertemplate{footline}[frame number]
	\setbeamertemplate{caption}[numbered]
%}

%% Listings
\RequirePackage{showexpl}
\lstloadlanguages{TeX}
\lstset{% for slides
	language=TeX,
	backgroundcolor=\color[RGB]{229, 229, 239},
	basicstyle=\ttfamily\small,
	breakindent=0em,
	breaklines=true,
	captionpos=b,
	columns=flexible,
	commentstyle=\color{blue},
	explpreset={numbers=none},
	frame=lines,
	frameround=ffff,
	identifierstyle=,
	keepspaces=true,
	keywordstyle=,
	language=[LaTeX]TeX,
	numbers=none,
	tabsize=2,
	pos=r,
	rframe={single},
}


%% Option Handling
%\RequirePackage{kvoptions,ifthen}
\SetupKeyvalOptions{
	family=latexkurs,
	prefix=ltxkurs@,
}
\DeclareStringOption{titel}
\DeclareStringOption{datum}
\DeclareStringOption{datum1}
\DeclareStringOption{datum2}
\DeclareBoolOption{vorläufig}
\DeclareBoolOption{kursA}
\DeclareComplementaryOption{kursB}{kursA}
\DeclareBoolOption{web}
\DeclareBoolOption{noshortverb}
\ProcessKeyvalOptions{latexkurs}


\ifltxkurs@kursA
	\providecommand{\kursAB}[2]{#1}
\else
	\providecommand{\kursAB}[2]{#2}
\fi



\ifltxkurs@noshortverb
	\PassOptionsToPackage{shortverb=false}{../tex/latexkurs-commands}
\else
	\PassOptionsToPackage{shortverb=true}{../tex/latexkurs-commands}
\fi

%% Preliminal Version
\ifltxkurs@vorläufig
	\institute{\color{red}\Large Vorläufige Version}
\fi

%% Date Formating
\RequirePackage[german]{datetime2}
%\DTMusemodule{german}{de-DE}
\DTMsavedate{coursedate}{\ltxkurs@datum}
\date{%
	\ifltxkurspre@web%
		\DTMgermanmonthname{\DTMfetchmonth{coursedate}}~\DTMfetchyear{coursedate}%
	\else%
		\DTMUsedate{coursedate}%
	\fi%
}
%\ifltxkurs@kursA
%	\date{\DTMdate{\ltxkurs@datum1}}
%\else
%	\date{\DTMdate{\ltxkurs@datum2}}
%\fi

%% Titlepage
\title{Einführung in das Textsatzsystem \LaTeX{}}
\subtitle{\ltxkurs@titel}
\author[Mo]{Moritz Brinkmann\\\href{mailto:mail@latexkurs.de}{\texttt{mail@latexkurs.de}}}
\AtBeginDocument{
	\frame{\thispagestyle{empty}\titlepage}
}

%% Hypersetup
\RequirePackage{hyperref}
\hypersetup{%
  unicode=true,
  pdfborder={000},
  colorlinks=false,
  pdftitle={Einführung in das Textsatzsystem LaTeX},
  pdfauthor={Moritz Brinkmann},
}

%% overleaf
\RequirePackage{tikz,qrcode}
\usetikzlibrary{calc}
\tikzset{ href node/.style={alias=sourcenode,append after command={let \p1 = (sourcenode.north west),  \p2=(sourcenode.south east),\n1={\x2-\x1},\n2={\y1-\y2} in node [inner sep=0pt, outer sep=0pt,anchor=north west,at=(\p1)] {\href{#1}{\phantom{\rule{\n1}{\n2}}}}}}} % http://tex.stackexchange.com/a/36111
\NewDocumentCommand{\overleaf}{ s m }{
	\thispagestyle{empty}
	\begin{tikzpicture}[remember picture,overlay]
		\node [anchor=south east, xshift=0mm, yshift=1.05mm, href node={https://qn3.de/#2}] at (current page.south east) (OLqrcode) {
			\scalebox{.55}{\parbox{46mm}{
				%In Overleaf ausprobieren:\\[.8ex]
				\centering
				\textcolor{white}{\rule{46mm}{46mm}}\vspace*{-45.5mm}
				\qrcode[height=45mm]{https://qn3.de/#2}
			}}
		};
		\node [anchor=south west, xshift=-27.86mm, yshift=-1.2mm, href node={https://qn3.de/#2}] at (current page.south east) {
			\scalebox{.55}{\url{http://qn3.de/#2}}
		};
		\node [anchor=south east, xshift=1.8mm, yshift=-0.8mm, href node={https://qn3.de/#2}] at (current page.south east) {
			\includegraphics[width=0.8cm]{../tex/overleaf-logo}
		};
		\IfBooleanT{#1}{
			\node [anchor=south, xshift=-14mm, yshift=40mm, rotate=-25, href node={https://qn3.de/#2}] at (current page.south east) (OLtext) {
				{\scalebox{.7}{in Overleaf ausprobieren}}
			};
			\draw [thick, ->] (OLtext) to [bend angle=30, bend right] (OLqrcode);
		}
	\end{tikzpicture}
}

\NewDocumentCommand{\qrcorner}{ m }{
	\begin{tikzpicture}[remember picture,overlay]
		\node [xshift=-2.08cm,yshift=2cm, href node={#1}] at (current page.south east)
		{
			\scalebox{.55}{\parbox{4.1cm}{
				\qrcode[height=4cm]{#1}
			}}
		};
	\end{tikzpicture}
}

% provide column layout for pages containing overleaf QRcode:
\RequirePackage{calc}
\newenvironment{olcol}{
	\begin{columns}[totalwidth=\textwidth]\begin{column}{\textwidth-22mm}
}{
	\end{column}%\begin{column}{25.3mm}\relax\end{column}
	\end{columns}
}

% provide “Arbeitsauftrag”-block
\newenvironment{arbeitsauftrag}{
	\begingroup
	\setbeamercolor{block title}{use=structure,fg=white,bg=green!60!black}
	\setbeamercolor{block body}{use=structure,fg=black,bg=green!20!white}
	\begin{block}{Arbeitsauftrag}
}{
	\end{block}
	\endgroup
}

% \teil command for parts
\newcounter{teil}
\providecommand{\teil}[2][]{
	\ifthenelse{\equal{#1}{}}{\section{#2}}{\section{#1}}
	\stepcounter{teil}
	\frame{\centering\alert{Teil \Roman{teil}}\\\huge #2}
}


%% Bibliography
\usepackage[backend=biber, style=numeric, sorting=none, doi=false, url=false, isbn=false, block=par]{biblatex}
\setbeamertemplate{bibliography item}{%
  \ifboolexpr{ test {\ifentrytype{book}} or test {\ifentrytype{mvbook}}
    or test {\ifentrytype{collection}} or test {\ifentrytype{mvcollection}}
    or test {\ifentrytype{reference}} or test {\ifentrytype{mvreference}} }
    {\setbeamertemplate{bibliography item}[book]}
    {\ifentrytype{online}
       {\setbeamertemplate{bibliography item}[online]}
       {\setbeamertemplate{bibliography item}[article]}}%
  \usebeamertemplate{bibliography item}}

\defbibenvironment{bibliography}
  {\list{}
     {\settowidth{\labelwidth}{\usebeamertemplate{bibliography item}}%
      \setlength{\leftmargin}{\labelwidth}%
      \setlength{\labelsep}{\biblabelsep}%
      \addtolength{\leftmargin}{\labelsep}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}}
  {\endlist}
  {\item}
  
\newbibmacro{string+doiurlisbn}[1]{%
  \iffieldundef{url}{%
    \iffieldundef{doi}{%
      \iffieldundef{isbn}{%
        \iffieldundef{issn}{%
          #1%
        }{%
          \href{http://books.google.com/books?vid=ISSN\thefield{issn}}{#1}%
        }%
      }{%
        \href{http://books.google.com/books?vid=ISBN\thefield{isbn}}{#1}%
      }%
    }{%
      \href{http://dx.doi.org/\thefield{doi}}{#1}%
    }%
  }{%
    \href{\thefield{url}}{#1}%
  }%
}

\renewbibmacro*{issue+date}{%
  \setunit{\addcomma\space}% NEW
%  \printtext[parens]{% DELETED
    \iffieldundef{issue}
      {\usebibmacro{date}}
      {\printfield{issue}%
       \setunit*{\addspace}%
%       \usebibmacro{date}}}% DELETED
       \usebibmacro{date}}% NEW
  \newunit}

\DeclareFieldFormat{title}{\usebibmacro{string+doiurlisbn}{\mkbibquote{#1}}\nopunct}
\DeclareFieldFormat[article,incollection]{title}%
    {\usebibmacro{string+doiurlisbn}{\mkbibquote{#1}}\nopunct}
\DeclareFieldFormat[article,book]{author}{#1\nopunct}
\DeclareFieldFormat{note}{\usebibmacro{string+doiurlisbn}{\texttt{#1}}\nopunct}

\renewbibmacro{in:}{}
\renewbibmacro{isdot}{}

\addbibresource{literatur.bib}
%\AtEndDocument{
\newcommand{\weiterführendeliteratur}{\frame[allowframebreaks]{\frametitle{Weiterführende Literatur}\printbibliography}}




%% load shared package
\RequirePackage{../tex/latexkurs-commands}
