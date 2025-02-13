% !TEX encoding = UTF-8 Unicode
% 
% © 2016 Moritz Brinkmann, CC-by-sa
% http://latexkurs.github.io


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-exercise}[2018/01/26 v0.2 Exercise sheets for LaTeX Course]

\LoadClass{scrartcl}

\RequirePackage{
	amssymb,
	calc,
	enumitem,
	../tex/latexkurs-commands,
	xparse,
}



%% Fonts
\RequirePackage{fontspec, microtype}
\setsansfont{Libertinus Sans}
\setromanfont{Libertinus Serif}
%\setmathfont{Libertinus Math}
\setmonofont[Scale=.95,AutoFakeSlant]{Inconsolata}
%\setmonofont[Scale=.95]{Anonymous Pro}

%% Option Handling
\RequirePackage{kvoptions, ifthen}
\SetupKeyvalOptions{
	family=latexkurs,
	prefix=ltxkurs@,
}
\DeclareStringOption{blattnr}
\DeclareStringOption{datum}
\DeclareStringOption{ausgabe}
\DeclareStringOption{abgabe}
\DeclareStringOption{titel}
\DeclareBoolOption{vorläufig}
\DeclareBoolOption{lösung}
\DeclareBoolOption{englisch}
\ProcessKeyvalOptions{latexkurs}

%% Language
\RequirePackage{polyglossia}
\ifltxkurs@englisch
	\setmainlanguage{english}
	\setotherlanguage{german}
\else
	\setmainlanguage{german}
	\setotherlanguage{english}
\fi

%% Geometry
\RequirePackage{geometry}
\geometry{a4paper,vmargin=3cm,head=16.0pt}

%% Date Formating
\RequirePackage[useregional=numeric]{datetime2}
\DTMusemodule{german}{german}
\DTMlangsetup[german]{datesep={.}}

%% Layout
\RequirePackage{microtype}
\frenchspacing
\reversemarginpar
\renewcommand*{\thefootnote}{\fnsymbol{footnote}}

%% Head- and Footline
\RequirePackage{scrlayer-scrpage, lastpage}
\pagestyle{scrheadings}
\KOMAoptions{
	headtopline = 1pt,
	headsepline = .6pt,
	footsepline = .6pt,
}
\setkomafont{pagehead}{\normalfont\small\sffamily}
\setkomafont{pagefoot}{\small\itshape}
\ifltxkurs@englisch
	\ihead{\LaTeX\ Workshop}
	\chead{\bfseries\ifthenelse{\equal{\ltxkurs@titel}{}}{Exercise \ltxkurs@blattnr}{\ltxkurs@titel}}
	\ohead{\ifthenelse{\equal{\ltxkurs@ausgabe}{}}{issued \DTMdate{\ltxkurs@datum}}{as of \DTMdate{\ltxkurs@ausgabe}}}
	\ifoot{Mannheim, FSS 2025}
	\cfoot{}
	\ofoot{page~\thepage~of~\pageref{LastPage}}
\else
	\ihead{\LaTeX-Workshop}
	\chead{\bfseries\ifthenelse{\equal{\ltxkurs@titel}{}}{Übungsblatt \ltxkurs@blattnr}{\ltxkurs@titel}}
	\ohead{\ifthenelse{\equal{\ltxkurs@ausgabe}{}}{Datum: \DTMdate{\ltxkurs@datum}}{Stand: \DTMdate{\ltxkurs@ausgabe}}}
	\ifoot{Mannheim, FSS 2025}
	\cfoot{}
	\ofoot{Seite~\thepage~von~\pageref{LastPage}}
\fi


%% Listings
\RequirePackage{showexpl}
\lstloadlanguages{TeX}
\lstset{% for exercise sheets
	backgroundcolor=\color[rgb]{.9 .9 .9},
	basicstyle=\ttfamily\small,
	breakindent=0em,
	breaklines=true,
	captionpos=b,
	commentstyle=\color{gray},
	%explpreset={numbers=none},
	frame=single,
	%frameround=ffff,
	identifierstyle=,
	keywordstyle=,
	language=[LaTeX]TeX,
	numbers=none,
	stepnumber=0,
	pos=l,
	rframe={single},
}

%% Preliminal Version
\ifltxkurs@vorläufig
	\AtBeginDocument{\centerline{%
   	\color{red}\Large \sffamily Vorläufige Version}%
		\vspace*{1ex}%
	}
\fi

%% Makros
\DeclareDocumentCommand\ltxkurs@exercisename{}{Übung}
\DeclareDocumentCommand\ltxkurs@bonusexercisename{}{Bonusaufgabe}
\DeclareDocumentCommand\ltxkurs@solutionname{}{Lösung}
\newcounter{ltxkursexercisecounter}
%\setcounter{ltxkursexercisecounter}{0}
\newlength{\starlength}
\DeclareDocumentEnvironment{aufgabe}{s o d<> m}{%
		\stepcounter{ltxkursexercisecounter}%
		\subsection*{%
			\IfBooleanTF{#1}{\settowidth{\starlength}{$\bigstar$\ }\hspace*{-\the\starlength}$\bigstar$\ \ltxkurs@bonusexercisename}{\ltxkurs@exercisename}\ %
			\ltxkurs@blattnr.\arabic{ltxkursexercisecounter}\ifthenelse{\equal{#4}{}}{}{: #4}%
			\hfill\normalfont\normalsize\textit{\IfValueTF{#2}{#2\IfValueT{#3}{ (+#3)} Punkte}{\IfValueT{#3}{+#3 Bonuspunkte}}}%
		}%
}{}
\newlength{\abgabelength}
\ProvideDocumentCommand\abgabe{+m}{
	\settowidth{\abgabelength}{{\textbf{Abgabe:}}\ }
	\par\hangindent\abgabelength\hangafter1\noindent{\textbf{Abgabe:}}\ #1\par
}
\ProvideDocumentCommand\tipp{+m}{
	\settowidth{\abgabelength}{{\textbf{Tipp:}}\ }
	\par\hangindent\abgabelength\hangafter1\noindent{\textbf{Tipp:}}\ #1\par
}
\DeclareDocumentCommand\lösung{m}{\ifltxkurs@lösung\subsection*{\ltxkurs@solutionname\ \ltxkurs@blattnr.\arabic{ltxkursexercisecounter}} \input{#1}\fi}

%% Hypersetup
\RequirePackage{hyperref}
\expandafter\hypersetup{%
  unicode=true,
  pdfborder={000},
  pdftitle={LaTeX-Workshop},
  pdfauthor={Moritz Brinkmann},
  colorlinks=true,
  linkcolor=blue,
  urlcolor=blue,
}
