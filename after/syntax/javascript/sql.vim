" Vim plugin
" Language: JavaScript
" Maintainer: Ian Langworth <ian@langworth.com>

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

exec 'syntax include @SQLSyntax syntax/' . g:javascript_sql_dialect . '.vim'

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax region sqlTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+ contains=@SQLSyntax,jsTemplateExpression,jsSpecial extend

exec 'syntax match sqlTaggedTemplate +\<sql\>\s*\ze`+ nextgroup=sqlTemplateString'
exec 'syntax match sqlTaggedTemplate +\/\*\s*sql\s*\*\/\s*\ze`+ nextgroup=sqlTemplateString'

hi def link sqlTaggedTemplate jsTaggedTemplate

syn cluster jsExpression add=sqlTaggedTemplate
syn cluster sqlTaggedTemplate add=sqlTemplateString
