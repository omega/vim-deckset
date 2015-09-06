" Vim syntax file
" Language: Deckset Flavored Markdown
" Based upon Github Flavored Markdown, which is based on Tim Pope's Markdown
" 
" GFM Maintainer: Jeff Tratner <github.com/jtratner>
" Tim Pop Markdown Maintainer: Tim Pope <vimNOSPAM@tpope.org>
"
" Filenames: None automatically triggered. 
"            Only used if the Deckset plugin 
"            sets filetype = deckset
"
" (nearly the same as jratner's Github Flavored Markdown,
"  with some additions for things Deckset supports, and some
"  attempts at weird hacks)

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'deckset'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn sync minlines=10
syn case ignore

syn match markdownValid '[<>]\c[a-z/$!]\@!'
syn match markdownValid '&\%(#\=\w*;\)\@!'

syn match markdownLineStart "^[<@]\@!" nextgroup=@markdownBlock,htmlSpecialChar,decksetPragma

syn cluster decksetPragma contains=dsFooter,dsSlideNumbers,dsAutoscale,dsBuildLists
syn cluster markdownBlock contains=markdownH1,markdownH2,markdownH3,markdownH4,markdownH5,markdownH6,markdownBlockquote,markdownListMarker,markdownOrderedListMarker,markdownCodeBlock,markdownRule,markdownGHCodeBlock
syn cluster markdownInline contains=markdownLineBreak,markdownLinkText,markdownItalic,markdownBold,markdownCode,markdownEscape,@htmlTop,markdownError

syn match markdownH1 "^.\+\n=\+$" contained contains=@markdownInline,markdownHeadingRule
syn match markdownH2 "^.\+\n-\+$" contained contains=@markdownInline,markdownHeadingRule

syn match markdownHeadingRule "^[=-]\+$" contained

syn region markdownH1 matchgroup=markdownHeadingDelimiter start="##\@!"      end="#*\s*$" keepend oneline contains=@markdownInline,contained
syn region markdownH2 matchgroup=markdownHeadingDelimiter start="###\@!"     end="#*\s*$" keepend oneline contains=@markdownInline,contained
syn region markdownH3 matchgroup=markdownHeadingDelimiter start="####\@!"    end="#*\s*$" keepend oneline contains=@markdownInline,contained
syn region markdownH4 matchgroup=markdownHeadingDelimiter start="#####\@!"   end="#*\s*$" keepend oneline contains=@markdownInline,contained
syn region markdownH5 matchgroup=markdownHeadingDelimiter start="######\@!"  end="#*\s*$" keepend oneline contains=@markdownInline,contained
syn region markdownH6 matchgroup=markdownHeadingDelimiter start="#######\@!" end="#*\s*$" keepend oneline contains=@markdownInline,contained

syn match markdownBlockquote ">\%(\s\|$\)" contained nextgroup=@markdownBlock

syn region markdownCodeBlock start="    \|\t" end="$" contained

" TODO - strikeout support
syn cluster validFooterText contains=markdownLinkText,markdownItalic,markdownBold,markdownCode,markdownEscape
" TODO - make sure no blank lines between pragma statements
syn match dsFooter "^footer:\s*" oneline keepend contains=@validFooterText

" TODO - Only true/false allowed on the following
syn keyword dsPragmaBoolean true false
syn match dsSlideNumbers "^slidenumbers:\s*" oneline nextgroup=@dsPragmaBoolean
syn match dsAutoscale "^autoscale:\s*" oneline nextgroup=@dsPragmaBoolean
syn match dsBuildLists "^build-lists:\s*" oneline nextgroup=@dsPragmaBoolean

" TODO: real nesting
syn match markdownListMarker "\%(\t\| \{0,4\}\)[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| \{0,4}\)\<\d\+\.\%(\s\+\S\)\@=" contained

syn match markdownRule "\* *\* *\*[ *]*$" contained
syn match markdownRule "- *- *-[ -]*$" contained

syn match markdownLineBreak " \{2,\}$"

syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained

syn region markdownItalic start="\<\*\|\*\>" end="\<\*\|\*\>" keepend contains=markdownLineStart
syn region markdownItalic start="\<_\|_\>" end="\<_\|_\>" keepend contains=markdownLineStart
syn region markdownBold start="\<\*\*\|\*\*\>" end="\<\*\*\|\*\*\>" keepend contains=markdownLineStart,markdownItalic
syn region markdownBold start="\<__\|__\>" end="\<__\|__\>" keepend contains=markdownLineStart,markdownItalic
syn region markdownBoldItalic start="\<\*\*\*\|\*\*\*\>" end="\<\*\*\*\|\*\*\*\>" keepend contains=markdownLineStart
syn region markdownBoldItalic start="\<___\|___\>" end="\<___\|___\>" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=markdownLineStart
syn region markdownGHCodeBlock matchgroup=markdownCodeDelimiter start="^\s*$\n\s*```\s\?\S*\s*$" end="\s*```$\n\s*\n" contained  keepend

syn match markdownEscape "\\[][\\`*_{}()#+.!-]"

" Copying rst's method of using literal strings
hi def link markdownGHCodeBlock           String
hi def link markdownCodeBlock             String
hi def link markdownCode                  String
hi def link markdownH1                    htmlH1
hi def link markdownH2                    htmlH2
hi def link markdownH3                    htmlH3
hi def link markdownH4                    htmlH4
hi def link markdownH5                    htmlH5
hi def link markdownH6                    htmlH6
hi def link markdownHeadingRule           markdownRule
hi def link markdownHeadingDelimiter      Delimiter
hi def link markdownOrderedListMarker     markdownListMarker
hi def link markdownListMarker            htmlTagName
hi def link markdownBlockquote            Comment
hi def link markdownRule                  PreProc

hi def link markdownLinkText              htmlLink
hi def link markdownIdDeclaration         Typedef
hi def link markdownId                    Type
hi def link markdownUrl                   Float
hi def link markdownUrlTitle              String
hi def link markdownIdDelimiter           markdownLinkDelimiter
hi def link markdownUrlDelimiter          htmlTag
hi def link markdownUrlTitleDelimiter     Delimiter

hi def link markdownItalic                htmlItalic
hi def link markdownBold                  htmlBold
hi def link markdownBoldItalic            htmlBoldItalic
hi def link markdownCodeDelimiter         Delimiter

hi def link markdownEscape                Special

hi def link dsSlideNumbers                Identifier
hi def link dsAutoscale                   Identifier
hi def link dsBuildLists                  Identifier
hi def link dsFooter                      Identifier
"" todo - fix me
hi def link validFooterText               Underlined
hi def link dsPragmaBoolean               Keyword

let b:current_syntax = "deckset"

if main_syntax ==# 'deckset'
  unlet main_syntax
endif
" vim:set sw=2:
