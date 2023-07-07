% This document class provides a simple memo for LaTeX users.
% It is based on article.cls and inherits most of the functionality
% that class.
% customized for IST Courses by Rui Santos Cruz.
% Original Author: Rob Oakes, Copyright 2010.  
% Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texMemo}[2010/07/31 - Simple Memo Class, Including Logo, 2015/09/20 adaptation by Rui Cruz]
\RequirePackage{palatino}
\usepackage{graphicx}
% Load the Base Class
\LoadClassWithOptions{article}
% Begin Requirements
\RequirePackage{ifthen}
% Specialized memo Commands (To, From, Subject, Logo, Letterhead Address)
\def\@memocourse{\relax}
\newcommand{\memocourse}[1]{\gdef\@memocourse{#1}}
\def\@memoid{\relax}
\newcommand{\memoid}[1]{\gdef\@memoid{#1}}
\def\@memofrom{\relax}
\newcommand{\memofrom}[1]{\gdef\@memofrom{#1}}
\def\@memosubject{\relax}
\newcommand{\memosubject}[1]{\gdef\@memosubject{#1}}
\def\@memodate{\relax}
\newcommand{\memodate}[1]{\gdef\@memodate{#1}}
\def\@memologo{\relax}
\newcommand{\logo}[1]{\gdef\@memologo{\protect #1}}
\def\@letterheadaddress{\relax}
\newcommand{\lhaddress}[1]{\gdef\@letterheadaddress{#1}}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par
}

% Set the Paper Size and margins
\RequirePackage{geometry}
\geometry{margin=1.0in}

% Create the Letterhead and To/From Block
\renewcommand{\maketitle}{\makememotitle}
\newcommand\makememotitle{
	\ifthenelse{\equal{\@memologo}{\relax}}{}
	{ % Create With Logo
	\begin{minipage}[t]{1\columnwidth}%
		\begin{flushright}
			\vspace{-0.3in}
			\@memologo
			\vspace{0.8in}
		\par\end{flushright}%
	\end{minipage}
	}
	{\begin{center}
	\LARGE\bf
	A\textsc{xonal Guidance }
	\end{center}}
	\vspace{1cm}
	% To, From, Subject Block
	\begin{description}
		\ifthenelse{\equal{\@memofrom}{\relax}}{}{\item [\IfLanguageName{english}{Author:}{Authors:}] \@memofrom}
		\ifthenelse{\equal{\@memoid}{\relax}}{}{\item [\IfLanguageName{english}{Project title:}{Project title:}] \@memoid} 
\ifthenelse{\equal{\@memocourse}{\relax}}{}{\item [\IfLanguageName{english}{University/ Department:}{University department:}] \@memocourse}
		\ifthenelse{\equal{\@memosubject}{\relax}}{}{\item [\IfLanguageName{english}{Duration:}{Duration:}] \@memosubject}
		\ifthenelse{\equal{\@memodate}{\relax}}{}{\item [\IfLanguageName{english}{Date:}{Date:}] \@memodate}
	\end{description}
	\decorativeline\bigskip{}
}