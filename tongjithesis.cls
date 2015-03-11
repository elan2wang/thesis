%% This is file `tongjithesis.cls'.
%% 


\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{tongjithesis}
[2015/03/05 1.1 Tongji University Thesis Template]

\hyphenation{Tongji-Thesis}
\def\tongjithesis{\textsc{TongjiThesis}}
\def\version{1.1}

%% 论文类型选项定义
\newif\iftongji@master\tongji@masterfalse
\newif\iftongji@doctor\tongji@doctorfalse
\newif\iftongji@secret\tongji@secretfalse
\DeclareOption{master}{\tongji@mastertrue}
\DeclareOption{doctor}{\tongji@doctortrue}
\DeclareOption{secret}{\tongji@secrettrue}

%% 是否在文本，目录和标题中使用 arial 字体
\newif\iftongji@arial
\newif\iftongji@arialtoc
\newif\iftongji@arialtitle
\DeclareOption{arial}{\tongji@arialtrue}
\DeclareOption{arialtoc}{\tongji@arialtoctrue}
\DeclareOption{arialtitle}{\tongji@arialtitletrue}

%% 将参数传递给 ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ExecuteOptions{utf,arialtitle} %参数之间用逗号分割,不能有空格

\ProcessOptions\relax
\LoadClass[cs4size,a4paper,openright,nocap,UTF8]{ctexbook}

%% 指定论文类型，若未指定则报错
\iftongji@master\relax\else
  \iftongji@doctor\relax\else
      \ClassError{tongjithesis}%
        {You have to specify one of thesis options: bachelor, master or doctor.}{}
  \fi
\fi

%% 加载宏包
\RequirePackage{ifxetex}
\RequirePackage{CJK,CJKnumb}
\RequirePackage{ifthen,calc}
\RequirePackage{amsmath,amssymb}
\RequirePackage{txfonts}
\RequirePackage{graphicx}
\RequirePackage[config]{subfig}
\RequirePackage{indentfirst}
\RequirePackage[neverdecrease]{paralist}

%% 中文字体处理
\renewcommand{\baselinestretch}{1.0}
\ifxetex
  \xeCJKsetup{AutoFakeBold=true,AutoFakeSlant=true}
  \punctstyle{quanjiao}
  % todo: minor fix of CJKnumb
  \def\CJK@null{\kern\CJKnullspace\Unicode{48}{7}\kern\CJKnullspace}
  \defaultfontfeatures{Mapping=tex-text} % use TeX --
  \ifCTEX@nofonts
    \input{zhfonts.def}
  \fi

  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \setmonofont{Courier New}
\else
  \RequirePackage{CJKspace}
  \iftongji@arial
    \IfFileExists{arial.sty}%
                 {\RequirePackage{arial}}%
                 {\ClassWarning{tongjithesis}{no arial.sty availiable!}}
  \fi
\fi

%% 加载宏包
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage[numbers,super,sort&compress]{natbib}
\RequirePackage{hyperref}

%% 生成有书签的 pdf 及其开关
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=true}
\fi
\hypersetup{%
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  %pdfpagelabels,
  pdfborder=0 0 0}
\urlstyle{same}

%%%%%%%%%%%%%%%%%%%%%%%%%% 主文档格式 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 单双面模式设置
\renewcommand\frontmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{tongji@empty}}

\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{tongji@headings@main}}

\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagestyle{tongji@headings@noseq}}

%% 字体设置
\newlength\tongji@linespace

\newcommand{\tongji@choosefont}[2]{%
   \setlength{\tongji@linespace}{#2*\real{#1}}%
   \fontsize{#2}{\tongji@linespace}\selectfont}

%% \tongji@define@fontsize{⟨字号名称⟩}{⟨磅数⟩}
%% 避免了字号选择和行距的紧耦合。所有字号定义时为单倍行距,并提供选项指定行距倍数。
\def\tongji@define@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][\baselinestretch]{%
    \tongji@choosefont{##1}{#2}}}

\tongji@define@fontsize{chuhao}{42bp}
\tongji@define@fontsize{xiaochu}{36bp}
\tongji@define@fontsize{yihao}{26bp}
\tongji@define@fontsize{xiaoyi}{24bp}
\tongji@define@fontsize{erhao}{22bp}
\tongji@define@fontsize{erhaoban}{20bp}
\tongji@define@fontsize{xiaoer}{18bp}
\tongji@define@fontsize{sanhao}{16bp}
\tongji@define@fontsize{xiaosan}{15bp}
\tongji@define@fontsize{sihao}{14bp}
\tongji@define@fontsize{banxiaosi}{13bp}
\tongji@define@fontsize{xiaosi}{12bp}
\tongji@define@fontsize{dawu}{11bp}
\tongji@define@fontsize{wuhao}{10.5bp}
\tongji@define@fontsize{xiaowu}{9bp}
\tongji@define@fontsize{liuhao}{7.5bp}
\tongji@define@fontsize{xiaoliu}{6.5bp}
\tongji@define@fontsize{qihao}{5.5bp}
\tongji@define@fontsize{bahao}{5bp}

%% 正文字体小四（12pt），行距为固定值20磅
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}
  \abovedisplayskip=10bp \@plus 2bp \@minus 2bp
  \abovedisplayshortskip=10bp \@plus 2bp \@minus 2bp
  \belowdisplayskip=\abovedisplayskip
  \belowdisplayshortskip=\abovedisplayshortskip}

%% 页面设置
\AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}
\AtBeginDvi{\special{!%
      \@percentchar\@percentchar BeginPaperSize: a4
      ^^Ja4^^J\@percentchar\@percentchar EndPaperSize}}
\setlength{\textwidth}{\paperwidth}
\setlength{\textheight}{\paperheight}
\setlength\marginparwidth{0cm}
\setlength\marginparsep{0cm}
\addtolength{\textwidth}{-6.4cm}
\addtolength{\textheight}{-8.6cm}
\setlength{\oddsidemargin}{3.2cm-1in}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\topskip}{0pt}
\setlength{\skip\footins}{15pt}
\setlength{\topmargin}{2.54cm-\headheight}
\setlength{\footskip}{1.3cm}
\setlength{\headsep}{0.7em} %控制页面第一行上面的空白空间 0.7行

%% 页眉页脚设置
\let\tongji@cleardoublepage\cleardoublepage
\newcommand{\tongji@clearemptydoublepage}{%
  \clearpage{\pagestyle{empty}\tongji@cleardoublepage}}
\let\cleardoublepage\tongji@clearemptydoublepage
% 页眉页脚都不显示
\def\ps@tongji@empty{%
  \let\@oddhead\@empty%
  \let\@evenhead\@empty%
  \let\@oddfoot\@empty%
  \let\@evenfoot\@empty}
% 只显示页脚（页码）
\def\ps@tongji@plain{%
  \let\@oddhead\@empty%
  \let\@evenhead\@empty%
  \def\@oddfoot{\hfil\wuhao\thepage\hfil}%
  \let\@evenfoot=\@oddfoot}

% 有章节号的 正文章节 页眉页脚设置
\def\ps@tongji@headings@main{%
  \def\@oddhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\songti\hfill\leftmark}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@evenhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\songti\tongji@cschoolname\hspace{0.5em}\tongji@capply\hspace{0.5em}\tongji@ctitle \hfill}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@oddfoot{\hfill\wuhao\thepage\hfill}
  \let\@evenfoot=\@oddfoot}

% 没有有章节号的 章节 页眉页脚设置
\def\ps@tongji@headings@noseq{%
  \def\@oddhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\songti\hfill\tongji@cschoolname\hspace{0.5em}\tongji@capply\hspace{0.5em}\leftmark}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@evenhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\songti\tongji@cschoolname\hspace{0.5em}\tongji@capply\hspace{0.5em}\leftmark\hfill}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@oddfoot{\hfill\wuhao\thepage\hfill}
  \let\@evenfoot=\@oddfoot}

% 英文摘要 页眉页脚设置
\def\ps@tongji@headings@eabstract{%
  \def\@oddhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\hfill\wuhao\songti\tongji@eschoolname\hspace{0.5em}\tongji@eapplyshort\hspace{0.5em}\leftmark}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@evenhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\songti\tongji@eschoolname\hspace{0.5em}\tongji@eapplyshort\hspace{0.5em}\leftmark\hfill}%
      \vskip2pt\hbox{\vrule width\textwidth height0.6pt depth0pt}}}
  \def\@oddfoot{\hfill\wuhao\thepage\hfill}
  \let\@evenfoot=\@oddfoot}

\renewcommand{\chaptermark}[1]{\@mkboth{\@chapapp\  ~~#1}{}}

%% 段落设置
\setlength{\parskip}{0pt \@plus2pt \@minus0pt}
\def\tongji@item@space{%
  \let\itemize\compactitem
  \let\enditemize\endcompactitem
  \let\enumerate\compactenum
  \let\endenumerate\endcompactenum
  \let\description\compactdesc
  \let\enddescription\endcompactdesc}

%% 脚注设置
\newcommand*\MakePerPage[2][\@ne]{%
  \expandafter\def\csname c@pchk@#2\endcsname{\c@pchk@{#2}{#1}}%
  \newcounter{pcabs@#2}%
  \@addtoreset{pchk@#2}{#2}}
\def\new@pagectr#1{\@newl@bel{pchk@#1}}
\def\c@pchk@#1#2{\z@=\z@
  \begingroup
  \expandafter\let\expandafter\next\csname pchk@#1@\arabic{pcabs@#1}\endcsname
  \addtocounter{pcabs@#1}\@ne
  \expandafter\ifx\csname pchk@#1@\arabic{pcabs@#1}\endcsname\next
  \else \setcounter{#1}{#2}\fi
  \protected@edef\next{%
    \string\new@pagectr{#1}{\arabic{pcabs@#1}}{\noexpand\thepage}}%
  \protected@write\@auxout{}{\next}%
  \endgroup\global\z@}
\MakePerPage{footnote}
\def\tongji@textcircled#1{%
  \ifnum \value{#1} <10 \textcircled{\xiaoliu\arabic{#1}}
  \else\ifnum \value{#1} <100 \textcircled{\qihao\arabic{#1}}\fi
  \fi}
\renewcommand{\thefootnote}{\tongji@textcircled{footnote}}
\renewcommand{\thempfootnote}{\tongji@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\tongji@footnotesize\footnotesize
\renewcommand\footnotesize{\tongji@footnotesize\xiaowu[1.5]}
\def\@makefnmark{\textsuperscript{\hbox{\normalfont\@thefnmark}}}
\long\def\@makefntext#1{
    \bgroup
      \setbox\@tempboxa\hbox{%
        \hb@xt@ 2em{\@thefnmark\hss}}
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      \footnotesize
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      #1
    \par\egroup}

%% 数学公式相关
\allowdisplaybreaks[4]
\gdef\@endtrivlist#1{%  % from \endtrivlist
  \if@inlabel \indent\fi
  \if@newlist \@noitemerr\fi
  \ifhmode
    \ifdim\lastskip >\z@ #1\unskip \par  %<<<<<<<<<<<<<<<<<<<<<<
      \else #1\unskip \par \fi
  \fi
  \if@noparlist \else
    \ifdim\lastskip >\z@
       \@tempskipa\lastskip \vskip -\lastskip
      \advance\@tempskipa\parskip \advance\@tempskipa -\@outerparskip
      \vskip\@tempskipa
    \fi
    \@endparenv
  \fi #1}

%% 定义字样使用黑体，正文使用宋体，冒号隔开
\theorembodyfont{\songti\rmfamily}
\theoremheaderfont{\heiti\rmfamily}

%% 浮动对象以及表格设置
\setlength{\floatsep}{2bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{2bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{12bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\let\old@tabular\@tabular
\def\tongji@tabular{\wuhao[1]\old@tabular}
\DeclareCaptionLabelFormat{tongji}{{\wuhao[1]\songti #1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{tongji}{\hspace{1em}}
\DeclareCaptionFont{tongji}{\songti\wuhao[1]}
\captionsetup{labelformat=tongji,labelsep=tongji,font=tongji}
\captionsetup[table]{position=top,belowskip={6bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[subfloat]{labelformat=simple,font=tongji,captionskip=6bp,nearskip=6bp,farskip=0bp,topadjust=0bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\let\tongji@LT@array\LT@array
\def\LT@array{\dawu[1.5]\tongji@LT@array} % set default font size
\def\hlinewd#1{%
  \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline}


%%%%%%%%%%%%%%%%%%%% 章节设置 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 如果标题中包含英文 使用 Arial 字体
\iftongji@arialtitle
  \def\tongji@title@font{\sffamily}
\fi

\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi\phantomsection%
  \global\@topnum\z@%
  \@afterindenttrue%
  \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
   \if@mainmatter
     \refstepcounter{chapter}%
     \addcontentsline{toc}{chapter}{\protect\numberline{\@chapapp}#1}%TODO: shit
   \else
     \addcontentsline{toc}{chapter}{#1}%
   \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \@makechapterhead{#2}}

\def\@makechapterhead#1{
  \vspace*{14.9bp} %实际间距24bp-\headsep
  {\parindent \z@ \centering
    \heiti\bfseries\csname tongji@title@font\endcsname\sanhao[1]
    \ifnum \c@secnumdepth >\m@ne
      \@chapapp \hspace{0.5em}
    \fi
    #1\par\nobreak
    \vskip 18bp}}

\def\@schapter#1{%
  \@makeschapterhead{#1}
  \@afterheading}

\def\@makeschapterhead#1{
  \vspace*{14.9bp} %实际间距24bp-\headsep
  {\parindent \z@ \centering
   \heiti\bfseries\csname tongji@title@font\endcsname\sanhao[1]
     \def\@tempa{#1}
     \def\@tempb{\eabstractname}
     \ifx\@tempa\@tempb\bfseries\fi
   \interlinepenalty\@M
   #1\par\nobreak
   \vskip 18bp}}

\newcounter{tongji@bookmark}

\def\tongji@chapter*{%
  \@ifnextchar [ % ]
    {\tongji@@chapter}
    {\tongji@@chapter@}}

\def\tongji@@chapter@#1{\tongji@@chapter[#1]{#1}}

\def\tongji@@chapter[#1]#2{%
  \@ifnextchar [ % ]
    {\tongji@@@chapter[#1]{#2}}
    {\tongji@@@chapter[#1]{#2}[]}}

\def\tongji@@@chapter[#1]#2[#3]{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection
  \def\@tmpa{#1}
  \def\@tmpb{#3}
  \ifx\@tmpa\@empty
    \addtocounter{tongji@bookmark}\@ne
    \pdfbookmark[0]{#2}{tongjichapter.\thetongji@bookmark}
  \else
    \addcontentsline{toc}{chapter}{#1}
  \fi
  \chapter*{#2}
  \ifx\@tmpb\@empty
    \@mkboth{#2}{#2}
  \else
    \@mkboth{#3}{#3}
  \fi}

\renewcommand\section{
  \@startsection {section}{1}{\z@}%
  {-24bp\@plus -1ex \@minus -.2ex}%
  {6bp \@plus .2ex}%
  {\heiti\csname tongji@title@font\endcsname\xiaosan}}
\renewcommand\subsection{
  \@startsection{subsection}{2}{\z@}%
  {-12bp\@plus -1ex \@minus -.2ex}%
  {6bp \@plus .2ex}%
  {\heiti\csname tongji@title@font\endcsname\sihao}}
\renewcommand\subsubsection{
  \@startsection{subsubsection}{3}{\z@}%
  {-12bp\@plus -1ex \@minus -.2ex}%
  {6bp \@plus .2ex}%
  {\heiti\csname tongji@title@font\endcsname\xiaosi}}


%%%%%%%%%%%%%%%%%%%%% 目录格式设置 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{secnumdepth}{3} % 章节内部标题层次
\setcounter{tocdepth}{2}    % 目录层次

\renewcommand\tableofcontents{%
  \vskip24bp{\tongji@chapter*[]{\contentsname}}\vskip18bp
  \pagestyle{tongji@headings@noseq}
  \xiaosi[1.5]\@starttoc{toc}\normalsize}

\iftongji@arialtoc
  \def\tongji@toc@font{\sffamily}
\fi

\def\@pnumwidth{2em}
\def\@tocrmarg{2em}
\def\@dotsep{1}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@tempdima #3\relax
    \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
    {\csname tongji@toc@font\endcsname #4}\nobreak
    \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
    \nobreak{\normalfont \normalcolor #5}%
    \par}%
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 4bp \@plus\p@
    \setlength\@tempdima{4em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\heiti\csname tongji@toc@font\endcsname #1} % numberline is called here, and it uses \@tempdima
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak{\normalfont\normalcolor #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{\@dottedtocline{1}{1.2em}{2.1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{3em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{3.5em}{3.8em}}

%%%%%%%%%%%%%%%%%%%%%%% 封面和封底 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 封面页替换命令定义
\def\tongji@define@term#1{
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname tongji@#1\endcsname{##1}}
  \csname #1\endcsname{}}
\tongji@define@term{secretlevel}
\tongji@define@term{secretyear}
\tongji@define@term{ctitle}
\tongji@define@term{cdegree}
\newcommand\cdepartment[2][]{\def\tongji@cdepartment@short{#1}\def\tongji@cdepartment{#2}}
\def\caffil{\cdepartment} % todo: for compatibility
\def\tongji@cdepartment@short{}
\def\tongji@cdepartment{}

\tongji@define@term{cmajorfirst}
\def\csubject{\cmajorfirst} % for compatibility
\tongji@define@term{cmajorsecond}
\def\csubject{\cmajorsecond} % for compatibility

\tongji@define@term{cstudent}
\tongji@define@term{cstudentid}
\tongji@define@term{csupervisor}
\tongji@define@term{cassosupervisor}
\tongji@define@term{ccosupervisor}
\tongji@define@term{cdate}
\tongji@define@term{cfunds}
\tongji@define@term{efunds}
\tongji@define@term{etitle}
\tongji@define@term{edegree}
\tongji@define@term{edepartment}
\def\eaffil{\edepartment} % todo: for compability
\tongji@define@term{emajorfirst}
\def\esubject{\emajorfirst} % todo: for compability
\tongji@define@term{emajorsecond}
\def\esubject{\emajorsecond} % todo: for compability
\tongji@define@term{estudent}
\tongji@define@term{estudentid}
\tongji@define@term{esupervisor}
\tongji@define@term{eassosupervisor}
\tongji@define@term{ecosupervisor}
\tongji@define@term{edate}

%% 中英文摘要设置
\long\@xp\def\@xp\collect@@body\@xp#\@xp1\@xp\end\@xp#\@xp2\@xp{%
  \collect@@body{#1}\end{#2}}
\long\@xp\def\@xp\push@begins\@xp#\@xp1\@xp\begin\@xp#\@xp2\@xp{%
  \push@begins{#1}\begin{#2}}
\long\@xp\def\@xp\addto@envbody\@xp#\@xp1\@xp{%
  \addto@envbody{#1}}
\newcommand{\tongji@@cabstract}[1]{\long\gdef\tongji@cabstract{#1}}
\newenvironment{cabstract}{\collect@body\tongji@@cabstract}{}
\newcommand{\tongji@@eabstract}[1]{\long\gdef\tongji@eabstract{#1}}
\newenvironment{eabstract}{\collect@body\tongji@@eabstract}{}
\def\tongji@parse@keywords#1{
  \expandafter\gdef\csname tongji@#1\endcsname{} % todo: need or not?
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname tongji@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname tongji@#1\endcsname{\ignorespaces\csname tongji@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname tongji@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\tongji@parse@keywords{ckeywords}
\tongji@parse@keywords{ekeywords}

%% 中文封面设置
\newlength{\tongji@title@width}
\def\tongji@put@title#1{\makebox{\hb@xt@ \tongji@title@width{#1}}}
\newcommand{\tongji@first@titlepage}{
  \begin{center}
    \vspace*{0.4cm}
    \parbox[b][1.8cm][t]{\textwidth}{%
      \hspace*{11.2cm}\iftongji@secret{\sanhao\tongji@secret@title}\else\rule{1cm}{0cm}\fi\\[0.1cm]
      \centering\includegraphics[width=10.0cm, height=2.6cm]{tongjilogo.png}}

    \parbox[t][9cm][t]{\paperwidth-10cm}{%
      \renewcommand{\baselinestretch}{1}
      \begin{center}
        \par\vskip 0.5cm \erhao[1]\textbf{\lishu\tongji@capply}\par\vskip 1.4cm
        \erhao[2]\textbf{\heiti\tongji@ctitle}\par\vskip 17pt
        \ifx\cfunds\@empty\else
          \xiaosi{\tongji@cfunds}
          \par\vskip 20bp
        \fi
      \end{center}}

    \vskip -0.1cm
    \hspace*{1.5cm}\parbox[t][8.5cm][t]{\textwidth}{
      \sanhao[1.5]
      \begin{center}\fangsong
        \setlength{\tongji@title@width}{6em}
        \setlength{\extrarowheight}{4pt}
        \begin{tabular}{p{\tongji@title@width}@{}c@{\extracolsep{8pt}}l}
          \tongji@put@title{\tongji@cstudenttitle}     & \tongji@title@sep & {\ziju{3bp}\tongji@cstudent}    \\
          \tongji@put@title{\tongji@cstudentidtitle}   & \tongji@title@sep & {\ziju{3bp}\tongji@cstudentid}  \\
          \tongji@put@title{\tongji@cdepartmenttitle}  & \tongji@title@sep & {\ziju{3bp}\tongji@cdepartment} \\
          \tongji@put@title{\tongji@cmajortitlefirst}  & \tongji@title@sep & {\ziju{3bp}\tongji@cmajorfirst} \\
          \tongji@put@title{\tongji@cmajortitlesecond} & \tongji@title@sep & {\ziju{3bp}\tongji@cmajorsecond}\\
          \tongji@put@title{\tongji@csupervisortitle}  & \tongji@title@sep & {\ziju{3bp}\tongji@csupervisor} \\
          \ifx\tongji@cassosupervisor\@empty\else
            \tongji@put@title{\tongji@cassosupertitle} & \tongji@title@sep & {\ziju{3bp}\tongji@cassosupervisor}\\
          \fi
          \ifx\tongji@ccosupervisor\@empty\else
            \tongji@put@title{\tongji@ccosupertitle}   & \tongji@title@sep & {\ziju{3bp}\tongji@ccosupervisor}\\
          \fi
        \end{tabular}
      \end{center}}
    \begin{center}
       {\sanhao \songti \tongji@cdate}
    \end{center}
  \end{center}} % end of titlepage

%% 英文封面设置
\newcommand{\engcover}{%
\begin{center}
    \vspace*{0.4cm}
    \parbox[b][1.8cm][t]{\textwidth}{%
      \hspace*{11.2cm}\iftongji@secret{\sanhao\tongji@secret@title}\else\rule{1cm}{0cm}\fi\\[0.1cm]
      \centering\includegraphics[width=10.0cm, height=2.6cm]{tongjilogo.png}}
    
    \parbox[t][9cm][t]{\paperwidth-6cm}{
      \renewcommand{\baselinestretch}{1}
      \begin{center}
            \sihao[1.3]{\tongji@eapply}\par\vskip 1.4cm
            \erhaoban[1.5]\textbf{\bfseries\sffamily\tongji@etitle}\par\vskip 14pt
            \ifx\efunds\@empty\else
              \xiaosi[1.3]{\tongji@efunds}
              \par\vskip 20bp
            \fi
      \end{center}}
    
    \vskip 0.5cm
    \hspace*{1.6cm}\parbox[t][8.7cm][t]{\textwidth}{\sanhao[1.5]
      \begin{center}
        \begin{tabular}{lp{7cm}l}
          Candidate :            & \tongji@estudent\\ 
          Student Number :       & \tongji@estudentid\\ 
          School/Department :    & \tongji@edepartment\\
          Discipline :           & \tongji@emajorfirst\\
          Major :                & \tongji@emajorsecond\\
          Supervisor :           & \tongji@esupervisor\\
          \ifx\tongji@eassosupervisor\@empty\else
          Associate Supervisor : & \tongji@eassosupervisor\\
          \fi
          \ifx\tongji@ecosupervisor\@empty\else
          Cooperate Supervisor : & \tongji@ecosupervisor\\
          \fi
        \end{tabular}
      \end{center}}
      \begin{center}
        \sanhao\tongji@edate
      \end{center}
\end{center}} % end of english cover

\newcommand\tongji@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}

%% 论文授权部分设置
\newcommand{\tongji@declareshortname@mk}{%
 \vspace*{-0.1cm} % shit code!
  \begin{center}\erhao\heiti\tongji@declarename\end{center}
  \vskip18pt\sihao[2.03]\par
  \tongji@declaretext\par
 \vskip8.9cm
    \begingroup
      \parindent0pt\xiaosi
      \hspace*{5.5cm}\tongji@authorsig\relax\hspace*{1cm}\\[3pt]
      \hspace*{9.5cm}\tongji@date\relax\hspace*{1cm}
    \endgroup}

\newcommand{\tongji@authorization@mk}{%
 \vspace*{-0.1cm} % shit code!
  \begin{center}\erhao\heiti\tongji@authtitle\end{center}
  \vskip18pt\sihao[2.03]\par
  \tongji@authorization\par
 \vskip7.9cm
    \begingroup
      \parindent0pt\xiaosi
      \hspace*{5.5cm}\tongji@authorsig\relax\hspace*{1cm}\\[3pt]
      \hspace*{9.5cm}\tongji@date\relax\hspace*{1cm}
    \endgroup}

%% 封面生成
\newcommand{\makecover}{
  \phantomsection
  \pdfbookmark[-1]{\tongji@ctitle}{ctitle}
  \normalsize%
  \begin{titlepage}
    \tongji@first@titlepage
    \clearpage\engcover
    \clearpage\tongji@authorization@mk
    \clearpage\tongji@declareshortname@mk
  \end{titlepage}
  \normalsize
  \tongji@makeabstract
  \let\@tabular\tongji@tabular}

%% 摘要格式设置
\newcommand{\tongji@makeabstract}{
  \tongji@chapter*[]{\cabstractname} % no tocline
  \pagestyle{tongji@headings@noseq}
  \pagenumbering{Roman}
  \tongji@cabstract
  \vskip20bp
  \setbox0=\hbox{\songti\textbf{\tongji@ckeywords@title}}
  \noindent\hangindent\wd0\hangafter1
    \box0\tongji@ckeywords
  \tongji@chapter*[]{\eabstractname} % no tocline
  \pagestyle{tongji@headings@eabstract}
  \tongji@eabstract
  \vskip20bp
  \setbox0=\hbox{\textbf{Key words:\enskip}}
  \noindent\hangindent\wd0\hangafter1
    \box0\tongji@ekeywords}

%% 主要符号表设置
\newenvironment{denotation}[1][2.5cm]{%
  \tongji@chapter*[]{\tongji@denotation@name} % no tocline
  \thispagestyle{tongji@headings@noseq}
  \noindent\begin{list}{}%
    {\vskip-30bp\wuhao[1.5]
    \renewcommand\makelabel[1]{##1\hfil}
    \setlength{\labelwidth}{#1}
    \setlength{\labelsep}{0.5cm}
    \setlength{\itemindent}{0cm}
    \setlength{\leftmargin}{\labelwidth+\labelsep}
    \setlength{\rightmargin}{0cm}
    \setlength{\parsep}{0cm}
    \setlength{\itemsep}{0cm}
    \setlength{\listparindent}{0cm}
    \setlength{\topsep}{0pt}
   }}{\end{list}}

%% 致谢设置
\newenvironment{ack}{%
  \tongji@chapter*[\tongji@acklongname]{\tongji@ackname}[\tongji@acklongname]
  \thispagestyle{tongji@headings@noseq}}

%% 索引设置
\def\tongji@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}

\def\tongji@listof#1{% #1: float type
  \@ifstar
    {\tongji@chapter*[]{\csname list#1name\endcsname}\tongji@starttoc{#1}}
    {\tongji@chapter*{\csname list#1name\endcsname}\tongji@starttoc{#1}}}

\renewcommand\listoffigures{\tongji@listof{figure}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\tongji@listof{table}}
\let\l@table\l@figure
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\tongji@listof{equation}}
\let\l@equation\l@figure

%% 参考文献设置
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
  \unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
  \if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
\DeclareRobustCommand\onlinecite{\@onlinecite}
\def\@onlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\def\tongjidot{\unskip.}
\def\tongjimasterbib{\iftongji@doctor [M]\else [Master Thesis]\fi}
\def\tongjiphdbib{\iftongji@doctor [D]\else [Doctor Thesis]\fi}
\renewenvironment{thebibliography}[1]{%
  \tongji@chapter*{\bibname}%
  \thispagestyle{tongji@headings@noseq}
  \wuhao[1.5]
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\renewcommand{\makelabel}[1]{##1\hfill}
         \settowidth\labelwidth{1.1cm}
         \setlength{\labelsep}{0.4em}
         \setlength{\itemindent}{0pt}
         \setlength{\leftmargin}{\labelwidth+\labelsep}
         \addtolength{\itemsep}{-0.7em}
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy\frenchspacing
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \interlinepenalty4000%
    \sfcode`\.\@m}
   {\def\@noitemerr
     {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist\frenchspacing}

%% 附录设置
\let\tongji@appendix\appendix
\renewenvironment{appendix}{%
  \tongji@appendix
  \gdef\@chapapp{\appendixname~\thechapter}
  \thispagestyle{tongji@headings@noseq}
  }{}

%% 个人简历设置
\newenvironment{resume}{%
  \tongji@chapter*{\tongji@resume@title}
  \thispagestyle{tongji@headings@noseq}
  \setlength{\parindent}{0pt}
  \wuhao[1.5]}{}
\newcommand{\resumeitem}[1]{\vskip15bp{\wuhao\songti\textbf{#1}}\par}

%% 生成索引的一些命令
\iffalse
\newcommand{\bs}{\symbol{'134}}%Print backslash
\newcommand{\cih}[1]{%
  \index{commands!#1@\texttt{\bs#1}}%
  \index{#1@\texttt{\hspace*{-1.2ex}\bs #1}}}
\newcommand{\ci}[1]{\cih{#1}\texttt{\bs#1}}
\newcommand{\pai}[1]{%
  \index{packages!#1@\textsf{#1}}%
  \index{#1@\textsf{#1}}%
  \textsf{#1}}
\newcommand{\ei}[1]{%
  \index{environments!\texttt{#1}}%
  \index{#1@\texttt{#1}}%
  \texttt{#1}}
\newcommand{\wi}[1]{\index{#1}#1}
\fi

%% 自定义命令
\renewcommand*{\ziju}[1]{\renewcommand{\CJKglue}{\hskip #1}}
\newcommand{\pozhehao}{\kern0.3ex\rule[0.8ex]{2em}{0.1ex}\kern0.3ex}

%% 装入配置文件
\AtEndOfClass{\input{tongjithesis.cfg}}

%% 设置pdf文档信息
\def\tongji@setup@pdfinfo{%
  \hypersetup{%
    pdftitle={\tongji@ctitle},
    pdfauthor={\tongji@cstudent},
    pdfsubject={\tongji@cdegree},
    pdfkeywords={\tongji@ckeywords},
    pdfcreator={\tongji@cstudent},
    pdfproducer={\tongjithesis}}}

%% 应用对列表环境的修改
\AtEndOfClass{\sloppy\tongji@item@space}
\endinput

%% 
%% End of file `tongjithesis.cls'