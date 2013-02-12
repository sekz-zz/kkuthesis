% *** kkuthesis.cls ***
% A Class to create a thesis that complies Khon Kaen University Thesis Guidelines.
% by 
% Kittiphong Meesawat - jarkmeesawat@gmail.com
% Aditap Khongjun - sc-physics@hotmail.com
% 09 Nov 2010

% English Thesis support and 
% Separate ambiguous commands that can be both Thai or English 
% into appropriate form, default in English and adding 'th' after the command
% for Thai commands eg. title (English) and titleth(Thai) 
% by Seksan Poltree - seksan.poltree@gmail.com


% Identification
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{kkuthesis}[2010/11/09 Khon Kaen University Thesis Class]

% This class is based on the standard report class.
% It should have option to process twoside report too.
\LoadClass[a4paper,oneside,openbib]{report}

% This class is currently support only Thai thesis.
% To support English thesis, some works on options 
% must be taking care of.

% Language packages
\RequirePackage[thai,english]{babel}
\RequirePackage{thswitch}
\RequirePackage[authoryear,longnamesfirst]{natbib}
\setcitestyle{authoryear,round,semicolon,aysep={,},yysep={,},notesep={, }}

%\RequirePackage[utf8]{inputenc}
% more investigation on INPUTENC package is required here.

% Layout packages
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{calc}
\RequirePackage{indentfirst}                                                                                                          
\RequirePackage[indentafter]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lineno}
% Both single line and multiple lines captions use
% the same setting.
\RequirePackage[singlelinecheck=false]{caption} 
\RequirePackage{remreset} % I use this just to renew the figure and table counters.

% Graphic package (required here because the thesis must 
% have the university logo on the cover and on the title page)
\RequirePackage{graphicx}

% Preliminary declarations

% Options

% More declarations
% Page margins
% If number of pages does not exceed 170pages, we can use one side print
% Use two pages
\geometry{a4paper, twoside, top=1.5in, bottom=1in, left=1in, right=1in, headsep=0.8in}
\geometry{bindingoffset=0.5in} 

% Page numbering style for the body of the thesis
% Redifined for twopage
\newcommand{\setkkupagestyle}{%
\pagestyle{fancy}
\renewcommand\headrulewidth{0pt}
\lhead{} \chead{} \rhead{} 
\lfoot{} \cfoot{} \rfoot{}
\fancyhead[LE,RO]{\thepage} % option for twoside
\pagenumbering{arabic}
}%

% Paragraph Indentation
% Indent 6 characters, paragraph begins at character 7
% The next level of section requires 6 more characters
% for the indentation
\def\firstindentlength{6ex}
\def\secondindentlength{12ex} 
\def\thirdindentlength{19.5ex}
\def\fourthindentlength{25ex}
\setlength{\parindent}{\firstindentlength}

% Fonts
% I cross my fingers that Kinnari will be able to replace Ang$ana
% Question! - Is this the right way to specify the default font for the whole document?
% I cannot see the correct baselineskip (1.5 line in M$WORD)

\rmfamily
% font for Thai
\def\thairmdefault{kinnari}
\usefont{LTH}{kinnari}{m}{n}
% font for English
\def\englishrmdefault{ptm}
\usefont{OT1}{ptm}{m}{n}
% line spacing entire document for English thesis is 1.5x
\linespread{1.5} 
\selectfont


%%renew font size // english thesis is 12pt for normal, 14pt for head %%
\renewcommand{\small}{\fontsize{11}{13}\selectfont}
\renewcommand{\normalsize}{\fontsize{12}{14}\selectfont}
\renewcommand{\large}{\fontsize{14}{16}\selectfont}

% reduce thswitch font size difference for kinari between Thai and English
% note that this case works with normalsize fonts
\renewcommand{\thaitext}{%
  \fontencoding{LTH}\fontfamily{\thairmdefault}\fontsize{11.25}{14}\selectfont
  \def\rmdefault{\thairmdefault}%
  \def\sfdefault{\thaisfdefault}%
  \def\ttdefault{\thaittdefault}%
  \def\encodingdefault{LTH}
  }
\renewcommand{\latintext}{%
  \fontencoding{\latinencoding}\fontfamily{\englishrmdefault}\fontsize{12}{14}\selectfont
  \def\rmdefault{\englishrmdefault}%
  \def\sfdefault{\englishsfdefault}%
  \def\ttdefault{\englishttdefault}%
  \def\encodingdefault{\latinencoding}
  }

% Float page alignment margin to top margin
\setlength{\@fptop}{0pt}

% Redefine even page for cleardoublepage to blank and no number
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
	\thispagestyle{empty}
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi
  	\fi\fi}
    
% Table of Content
% The major part was taken from report.cls
% and modified according to the KKU Graduate School Manual


% Disable space between chapter in lot and lof
% from http://tex.stackexchange.com/questions/784/how-to-change-the-line-spacing-in-my-list-of-figures/793#793
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace} % for figure
\addtocontents{lot}{\protect\noaddvspace} % for table

\setcounter{tocdepth}{1}
\renewcommand\tableofcontents{%
\chapter*{TABLE OF CONTENTS}%
\begin{flushright}
\textbf{Page}
\end{flushright}
% Hold current page value
% for TOC heading
\newcounter{tocitem}
\setcounter{tocitem}{0}
\modulolinenumbers[50]
\linenumbers[1]
\@starttoc{toc}%
\setcounter{tocitem}{0}
\clearpage
\cleardoublepage
}

% A new command to test wheather it is a newpage or not.
% Useful to insert a heading (if possible) for the subsequence pages of the toc

% The rests are done by the titletoc package
% I fixed the titledepth to 1 for the sake of simplicity.
% If make it more general -> if more headings -> the entry will be more 
% and one must solve the "Table of Contents (cont.)" on the second page of the TOC.
% In this case, I think the bug is at the Graduate School and I will not fix it.

%\tocheadcont{\tocitem}{\linenumber}{headertype}
\newcommand{\tocheadcont}[3]{
\ifthenelse{#1>27 \OR #2>27}{
\cleardoublepage
%Should be a newpage here.
\pagebreak[4]
\resetlinenumber[1]
\setcounter{tocitem}{0}
\begin{center}
{\large \textbf{#3 (Cont.)} }
\end{center} 
\vspace{\baselineskip}
\begin{flushright}
\textbf{Page}
\end{flushright}
}{}
}

\titlecontents{chapter}[0mm]{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{TABLE OF CONTENT}}{\MakeUppercase\chaptername\hspace{1ex}\thecontentslabel\hspace{2mm}}{}{\hfill \contentspage}

\titlecontents{section}[0mm]{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{TABLE OF CONTENT}}{\hspace{\firstindentlength}\thecontentslabel.\hspace{2mm}}{\hspace{\firstindentlength}\thecontentslabel\hspace{2mm}}{\hfill \contentspage} 

% List of Tables
% The major part was taken from report.cls
% and modified according to the KKU Graduate School Manual
%\newcommand\listoftables{%
%    \if@twocolumn
%      \@restonecoltrue\onecolumn
%    \else
%      \@restonecolfalse
%    \fi
%    \chapter*{\listtablename}%
%      \@mkboth{%
%          \MakeUppercase\listtablename}%
%         {\MakeUppercase\listtablename}%
%    \@starttoc{lot}%
%    \if@restonecol\twocolumn\fi
%    }

\renewcommand\listoftables{%
\chapter*{\MakeUppercase\listtablename}%
\begin{flushright}
\textbf{Page}
\end{flushright}
\resetlinenumber[1]
\setcounter{tocitem}{0}
\@starttoc{lot}%
\setcounter{tocitem}{0}
\clearpage
\pagewiselinenumbers
\cleardoublepage
}


\titlecontents{table}[0mm]{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{LIST OF TABLES}}{\contentspush{\tablename\hspace{1ex}\thecontentslabel\hspace{2mm}}}{}{\hfill \contentspage}

\renewcommand\listoffigures{%
\chapter*{\MakeUppercase\listfigurename}%
\begin{flushright}
\textbf{Page}
\end{flushright}
\resetlinenumber[1]
\setcounter{tocitem}{0}
\@starttoc{lof}%
\setcounter{tocitem}{0}
\clearpage
\pagewiselinenumbers
\cleardoublepage
}

% Indent the next line of the entry by the width of the label with \contentspush
\titlecontents{figure}[0mm]{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{LIST OF FIGURES}}{\contentspush{\figurename\hspace{1ex}\thecontentslabel\hspace{2mm}}}{}{\hfill \contentspage}


% Chapter Style
% Question! - The thesis manual requires that the space between the chapter heading 
% and the first paragraph is 2 lines. How long is 2 lines? Absolute (like I did) or 
% relative shall be used?
\renewcommand{\@makechapterhead}[1]{%
% Does center environment effect on the vertical space?
% Is 45 points enough for 2 lines?
\thispagestyle{empty}
\begin{center} 
{\large \textbf{ \MakeUppercase\@chapapp\space  ~\thechapter} \\ \textbf{#1}}
\end{center}
\vspace{2\baselineskip}
}

\def\thechapter{\Roman{chapter}}

% Chapter Style (Starred Version - For TOC)
% Most are similar to Chapter style above
% but just without number.
\renewcommand{\@makeschapterhead}[1]{%
% Does center environment effect on the vertical space?
% Is 45 points enough for 2 lines?
\thispagestyle{empty}
\begin{center}
{\large \MakeUppercase\ \textbf{#1} }
\end{center} 
\vspace{2\baselineskip}
}

% Redefine Section Style

% sert dept of numbering in section 
\setcounter{secnumdepth}{4}

\renewcommand\thesection{\arabic{section}}
\titleformat{\section}{\bfseries\large\upshape}{\thesection.}{3ex}{\null}
\titlespacing{\section}{0ex}{\baselineskip}{\parskip}

\newcommand{\kkusection}[1]{
\section{#1}
\setlength{\parindent}{\firstindentlength}
}

% Redefine Subsection Style
% The thesis manual says that the first paragraph after the heading
% should indent to the heading label position
% but looking at the submitted thesis, seems like this rule is not 
% in practice.

% This can be done, but by creating a newcommand
% \kkusubsection and add a white space with a rigid length after the 
% formatted \subsection
% This destroys the compatibility of the source tex file. 
% I do not like this and like to know how to do it properly.

\renewcommand\thesubsection{\thesection.\arabic{subsection}}
\titleformat{\subsection}{\bfseries\normalsize\upshape}{\thesubsection}{3ex}{\null}
\titlespacing{\subsection}{\firstindentlength}{\baselineskip}{\parskip}

\newcommand{\kkusubsection}[1]{
\subsection{#1} 
\setlength{\parindent}{\secondindentlength}
}


%% subsubsection redefind
\renewcommand\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\titleformat{\subsubsection}{\normalsize\upshape}{\thesubsubsection}{3ex}{\null}
\titlespacing{\subsubsection}{\secondindentlength}{0em}{0em}

\newcommand{\kkusubsubsection}[1]{
\subsubsection{#1} 
\setlength{\parindent}{\thirdindentlength}
}

% Define plain section normal text
\newenvironment{kkuplainsection}{%
\titleformat{\subsection}[runin]{\normalsize\upshape}{\thesubsection}{3ex}{\null}
\titlespacing{\subsection}{\firstindentlength}{0em}{0em}
}{
\titleformat{\subsection}{\bfseries\normalsize\upshape}{\thesubsection}{3ex}{\null}
\titlespacing{\subsection}{\firstindentlength}{\baselineskip}{\parskip}
}

% redefine paragraph as 4th level identation 
\renewcommand\theparagraph{\thesubsubsection.\arabic{paragraph}}
\titleformat{\paragraph}{\normalsize\upshape}{\theparagraph}{3ex}{\null}
\titlespacing{\paragraph}{\thirdindentlength}{0em}{0em}

\newcommand{\kkuparagraph}[1]{
\paragraph{#1} 
\setlength{\parindent}{\fourthindentlength} 
}

\DeclareCaptionLabelSeparator{doublespace}{~~}

% Redefine table caption style
\captionsetup[table]{format=hang,labelfont={bf,up},textfont={md,up},labelsep=doublespace,justification=raggedright,position=top}
\@removefromreset{table}{chapter}
\renewcommand\thetable{\arabic{table}}

% Redefine figure caption style
\captionsetup[figure]{format=hang,labelfont={bf,up},textfont={md,up},labelsep=doublespace,justification=centering,position=below}
\@removefromreset{figure}{chapter}
\renewcommand\thefigure{\arabic{figure}}

% Generate Cover pages
% - Thesis Information

% Thai commands
\newcommand*{\thesislang}[1]{\def\@thesislang{#1}}

\newcommand*{\titleth}[1]{\def\@titleth{#1}}
\newcommand*{\authora}[1]{\def\@authora{#1}} % author without title in English
\newcommand*{\authorth}[1]{\def\@authorth{#1}} % author with title in Thai
\newcommand*{\authortha}[1]{\def\@authortha{#1}} % author withour title in Thai
\newcommand*{\academicyearth}[1]{\def\@academicyearth{#1}}
\newcommand*{\degreeth}[1]{\def\@degreeth{#1}}
\newcommand*{\advisorth}[1]{\def\@advisorth{#1}}

\newcommand*{\academicyear}[1]{\def\@academicyear{#1}}
\newcommand*{\degree}[1]{\def\@degree{#1}}
\newcommand*{\advisor}[1]{\def\@advisor{#1}}

\newcommand*{\committeechair}[1]{\def\@committeechair{#1}}
\newcommand*{\firstcommittee}[1]{\def\@firstcommittee{#1}}
\newcommand*{\secondcommittee}[1]{\def\@secondcommittee{#1}}

\newcommand*{\committeechairth}[1]{\def\@committeechairth{#1}}
\newcommand*{\firstcommitteeth}[1]{\def\@firstcommitteeth{#1}}
\newcommand*{\secondcommitteeth}[1]{\def\@secondcommitteeth{#1}}

\newcommand*{\deanofgs}[1]{\def\@deanofgs{#1}}
\newcommand*{\deanofen}[1]{\def\@deanofen{#1}}


% - Front Cover
\renewcommand\maketitle{%

%% clear page numbering
\thispagestyle{empty}
\pagestyle{empty}

\begin{titlepage}
\begin{center}
	%\vspace{2.5cm}
	\begin{figure}
  	\begin{center}
		\IfFileExists{kkuNew.png}{\includegraphics[scale =0.1]{kkuNew.png}}{File kkuNew.png is not found.}
    	\end{center}
	\end{figure}
\end{center}
\begin{center}
\latintext
{\large \textbf{\MakeUppercase{\@title}}}
\end{center}
\vspace{6cm}
\begin{center}
{\large \textbf{\MakeUppercase{\@author}}}
\end{center}
\vspace{6.9cm}
\begin{center}
{\large \textbf{A THESIS FOR THE DEGREE OF \MakeUppercase{\@degree} \\ KHON KAEN UNIVERSITY} \\
\textbf{\@academicyear}}
\end{center}
\cleardoublepage
\end{titlepage}%

% No Thai title page in Thai for English Thesis

% Title page in English
\latintext
\begin{titlepage}
\thispagestyle{empty}
\begin{center}
{\large \textbf{\MakeUppercase{\@title}}}
\end{center}
\vspace{8cm}
\begin{center}
{\large \textbf{\MakeUppercase{\@author}}}
\end{center}
\vspace{8.5cm}
\begin{center}
\textbf{\MakeUppercase{A thesis submitted in partial fulfillment of the }}\\
\textbf{\MakeUppercase{requirements for the degree of \@degree}}\\
\textbf{\MakeUppercase{in Compute Engineering}}\\
\textbf{\MakeUppercase{Graduate School Khon Kaen University}}\\
\textbf{\MakeUppercase{\@academicyear}}
\end{center}
\cleardoublepage
\end{titlepage}

% Certificate page in English
\latintext
\begin{titlepage}
\thispagestyle{empty}
\begin{center}
	\begin{figure}
  	\begin{center}
		\IfFileExists{kkuNew.png}{\includegraphics[scale =0.1]{kkuNew.png}}{File kkuNew.png is not found.}
    	\end{center}
	\end{figure}
\end{center}
\begin{center}
\large
\textbf{THESIS APPROVAL}\\
\textbf{KHON KAEN UNIVERSITY}\\
\textbf{FOR}\\
\textbf{MASTER OF ENGINEERING}\\
\textbf{IN COMPUTER ENGINEERING}
\end{center}
\vspace{0.5cm}
\begin{flushleft}
\textbf{Thesis Title}: \hspace{2em} \@title \\
\vspace{0.5cm}
\textbf{Author}: \hspace{2em} \@author \\
\vspace{0.7cm}
\begin{tabular}{@{}lll}
\textbf{Thesis Examination Committee} & \@committeechair  & Chairperson \\
                               & \@firstcommittee & Member \\
                               & \@secondcommittee  & Member
\end{tabular}
\end{flushleft}
\vspace{0.5cm}
\textbf{Thesis Advisor:}\\
\begin{center}
% \makebox with zero width is free from center environment
% this is very handy for signature line.
% Could be useful for official memo (Thailand) too.
\makebox[6cm][l]{\dotfill{}}\makebox[0pt][l]{ Advisor}\\
(\@advisor)
\end{center}
\vspace{0.5cm}
\begin{center}
\begin{tabular}{ccc}
\dotfill{}&&\dotfill{}\\
 (\@deanofgs)&&(\@deanofen)\\
Dean, Graduate School && Dean, Faculty of Engineering
 \\
\end{tabular}
\end{center}
\vspace{0.5cm}
\begin{center}
Copyright of Khon Kaen University
\end{center}
\cleardoublepage
\end{titlepage}
}% End \maketitle

% Generate Abstract
% This portion of code is taken directly from report.cls
% but since it is for a very restrict thesis format
% so I remove the redundant part (the later part specify 
% what to do if it was not a titlepage)

% To make it comply with the graduate school
% I have to add something too.

%\renewenvironment{abstract}{%
%      \titlepage
%      \null\vfil
%      \@beginparpenalty\@lowpenalty
%      \begin{center}%
%	\bfseries \abstractname
%        \@endparpenalty\@M
%      \end{center}}%
%     {\par\vfil\null\endtitlepage}

% The vspace between title and the advisor line is HARD CODE
% This is not a good practice since one have to change it manually
% if the line space is changed.

% It works for now anyway.

\newenvironment{abstractth}{%
\thaitext
\addcontentsline{toc}{chapter}{ABSTRACT (IN THAI)}
\begin{flushright}
\parbox{\textwidth-1.8cm}{\begin{flushleft}
\hspace{-2cm} \@authortha. \@academicyearth. \textbf{\MakeUppercase{ \@titleth}}. วิทยานิพนธ์{\wbr}ปริญญา\@degreeth {\wbr} ~สาขาวิชา{\wbr}วิศวกรรม{\wbr}คอมพิวเตอร์ บัณฑิตวิทยาลัย มหาวิทยาลัยขอนแก่น.\end{flushleft}\vspace{-4mm}
\hspace{-2cm} \textbf{อาจารย์ที่ปรึกษาวิทยานิพนธ์:} \@advisorth}
\end{flushright}
\vspace{2.5mm}
\begin{center}
\textbf{บทคัดย่อ}
\end{center}
\vspace{2.5mm}
}{
\selectlanguage{english} % set back to English
\cleardoublepage
}

% Abstract in English

\renewenvironment{abstract}{%
\latintext
\addcontentsline{toc}{chapter}{ABSTRACT (IN ENGLISH)}
\begin{flushright}
\parbox{\textwidth-1.5cm}{\begin{flushleft}
\hspace{-1.5cm} \@authora. \@academicyear. \textbf{ \@title}. Master of Engineering Thesis in Computer Engineering, Graduate School, Khon Kaen University.\end{flushleft}\vspace{-3mm}
\hspace{-1.5cm} \textbf{Thesis Advisor:} \@advisor}
\end{flushright}
\vspace{2.5mm}
\begin{center}
\textbf{ABSTRACT}
%\bfseries \abstractname
\end{center}
\vspace{2.5mm}
}{
\cleardoublepage
}
\latintext
% Generate Dedication
\newenvironment{dedication}{%
\addcontentsline{toc}{chapter}{DEDICATION}
\begin{center}
\null
% This should be changed to center vertical alignment by other command 
% such as box or somthing like that.
\vspace{8cm}
}{
\end{center}
\cleardoublepage
}

% Generate Acknowledgement
\newenvironment{acknowledge}{%
\addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
\begin{center}
\textbf{\large{ACKNOWLEDGEMENTS}}
\end{center}
%\vspace{1.7cm}
\vspace{\baselineskip}
}{
\par
\vspace{1.5cm}
\makebox[0.5\textwidth]{\null}\makebox[0.5\textwidth]{\centering \@authora} 
\cleardoublepage
}

% Generate Table of Contents

% Generate List of Tables

% Generate List of Figures

% Generate List of Abbreviations
