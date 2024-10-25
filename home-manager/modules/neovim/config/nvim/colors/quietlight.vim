source $VIMRUNTIME/colors/vim.lua " Nvim: revert to Vim default color scheme
let g:colors_name = 'quietlight'

let s:t_Co = &t_Co

hi! link Added Normal
hi! link Changed Normal
hi! link Removed Normal
hi! link Terminal Normal
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link debugBreakpoint ModeMsg
hi! link debugPC CursorLine

" Light background
if (has('termguicolors') && &termguicolors) || has('gui_running')
	let g:terminal_ansi_colors = ['#000000', '#af0000', '#005f00', '#af5f00', '#005faf', '#870087', '#008787', '#d7d7d7', '#626262', '#d70000', '#008700', '#d78700', '#0087d7', '#af00af', '#00afaf', '#ffffff']
	" Nvim uses g:terminal_color_{0-15} instead
	for i in range(g:terminal_ansi_colors->len())
		let g:terminal_color_{i} = g:terminal_ansi_colors[i]
	endfor
endif
hi Normal guifg=#000000 guibg=#d7d7d7 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#e4e4e4 gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CurSearch guifg=#ff5fff guibg=#000000 gui=reverse cterm=reverse
hi Cursor guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi CursorColumn guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi CursorLineNr guifg=#000000 guibg=#eeeeee gui=NONE cterm=NONE
hi DiffAdd guifg=#87d787 guibg=#000000 gui=reverse cterm=reverse
hi DiffChange guifg=#afafd7 guibg=#000000 gui=reverse cterm=reverse
hi DiffDelete guifg=#d78787 guibg=#000000 gui=reverse cterm=reverse
hi DiffText guifg=#d787d7 guibg=#000000 gui=reverse cterm=reverse
hi Directory guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guifg=#000000 guibg=#d7d7d7 gui=reverse cterm=reverse
hi FoldColumn guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=#626262 guibg=#d7d7d7 gui=NONE cterm=NONE
hi IncSearch guifg=#ffaf00 guibg=#000000 gui=reverse cterm=reverse
hi LineNr guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi MatchParen guifg=#ff00af guibg=#d7d7d7 gui=bold cterm=bold
hi ModeMsg guifg=#000000 guibg=NONE gui=bold cterm=bold
hi MoreMsg guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
hi PmenuMatch guifg=#d70000 guibg=#a8a8a8 gui=NONE cterm=NONE
hi PmenuExtra guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
hi PmenuKind guifg=#000000 guibg=#a8a8a8 gui=bold cterm=bold
hi PmenuSbar guifg=#000000 guibg=#e4e4e4 gui=NONE cterm=NONE
hi PmenuSel guifg=#d7d7d7 guibg=#000000 gui=NONE cterm=NONE
hi PmenuMatchSel guifg=#d70000 guibg=#000000 gui=bold cterm=bold
hi PmenuExtraSel guifg=#d7d7d7 guibg=#000000 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#d7d7d7 guibg=#000000 gui=bold cterm=bold
hi PmenuThumb guifg=#000000 guibg=#000000 gui=NONE cterm=NONE
hi Question guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guifg=#ff5fff guibg=#000000 gui=reverse cterm=reverse
hi Search guifg=#00afff guibg=#000000 gui=reverse cterm=reverse
hi SignColumn guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#626262 guibg=NONE gui=bold cterm=bold
hi SpellBad guifg=#af0000 guibg=#d7d7d7 guisp=#af0000 gui=undercurl cterm=underline
hi SpellCap guifg=#005faf guibg=#d7d7d7 guisp=#005faf gui=undercurl cterm=underline
hi SpellLocal guifg=#870087 guibg=#d7d7d7 guisp=#870087 gui=undercurl cterm=underline
hi SpellRare guifg=#008787 guibg=#d7d7d7 guisp=#008787 gui=undercurl cterm=underline
hi StatusLine guifg=#eeeeee guibg=#000000 gui=bold cterm=bold
hi StatusLineNC guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
hi TabLine guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
hi TabLineFill guifg=#000000 guibg=#d7d7d7 gui=NONE cterm=NONE
hi TabLineSel guifg=#eeeeee guibg=#000000 gui=bold cterm=bold
hi Title guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi VertSplit guifg=#626262 guibg=#d7d7d7 gui=NONE cterm=NONE
hi Visual guifg=#ffaf00 guibg=#000000 gui=reverse cterm=reverse
hi VisualNOS guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi WarningMsg guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#000000 guibg=#eeeeee gui=bold cterm=bold
hi Comment guifg=#000000 guibg=NONE gui=bold cterm=bold
hi Constant guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#ff005f guibg=#000000 gui=bold,reverse cterm=bold,reverse
hi Identifier guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#00ffaf guibg=#000000 gui=bold,reverse cterm=bold,reverse
hi Type guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#000000 guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=#000000 guibg=#afff00 gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#d7d7d7 gui=NONE cterm=NONE
hi ToolbarButton guifg=#000000 guibg=#d7d7d7 gui=bold cterm=bold

if s:t_Co >= 256
  " Light background
  hi Normal ctermfg=16 ctermbg=188 cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=254 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CurSearch ctermfg=207 ctermbg=16 cterm=reverse
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=255 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=255 cterm=NONE
  hi CursorLineNr ctermfg=16 ctermbg=255 cterm=NONE
  hi DiffAdd ctermfg=114 ctermbg=16 cterm=reverse
  hi DiffChange ctermfg=146 ctermbg=16 cterm=reverse
  hi DiffDelete ctermfg=174 ctermbg=16 cterm=reverse
  hi DiffText ctermfg=176 ctermbg=16 cterm=reverse
  hi Directory ctermfg=16 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=241 ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=16 ctermbg=188 cterm=reverse
  hi FoldColumn ctermfg=241 ctermbg=NONE cterm=NONE
  hi Folded ctermfg=241 ctermbg=188 cterm=NONE
  hi IncSearch ctermfg=214 ctermbg=16 cterm=reverse
  hi LineNr ctermfg=248 ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=199 ctermbg=188 cterm=bold
  hi ModeMsg ctermfg=16 ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=16 ctermbg=NONE cterm=NONE
  hi NonText ctermfg=241 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=16 ctermbg=248 cterm=NONE
  hi PmenuMatch ctermfg=160 ctermbg=248 cterm=NONE
  hi PmenuExtra ctermfg=16 ctermbg=248 cterm=NONE
  hi PmenuKind ctermfg=16 ctermbg=248 cterm=bold
  hi PmenuSbar ctermfg=16 ctermbg=254 cterm=NONE
  hi PmenuSel ctermfg=188 ctermbg=16 cterm=NONE
  hi PmenuMatchSel ctermfg=160 ctermbg=16 cterm=bold
  hi PmenuExtraSel ctermfg=188 ctermbg=16 cterm=NONE
  hi PmenuKindSel ctermfg=188 ctermbg=16 cterm=bold
  hi PmenuThumb ctermfg=16 ctermbg=16 cterm=NONE
  hi Question ctermfg=16 ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=207 ctermbg=16 cterm=reverse
  hi Search ctermfg=39 ctermbg=16 cterm=reverse
  hi SignColumn ctermfg=16 ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=241 ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=124 ctermbg=188 cterm=underline
  hi SpellCap ctermfg=25 ctermbg=188 cterm=underline
  hi SpellLocal ctermfg=90 ctermbg=188 cterm=underline
  hi SpellRare ctermfg=30 ctermbg=188 cterm=underline
  hi StatusLine ctermfg=255 ctermbg=16 cterm=bold
  hi StatusLineNC ctermfg=16 ctermbg=248 cterm=NONE
  hi TabLine ctermfg=16 ctermbg=248 cterm=NONE
  hi TabLineFill ctermfg=16 ctermbg=188 cterm=NONE
  hi TabLineSel ctermfg=255 ctermbg=16 cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi VertSplit ctermfg=241 ctermbg=188 cterm=NONE
  hi Visual ctermfg=214 ctermbg=16 cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=255 cterm=NONE
  hi WarningMsg ctermfg=16 ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=16 ctermbg=255 cterm=bold
  hi Comment ctermfg=16 ctermbg=NONE cterm=bold
  hi Constant ctermfg=16 ctermbg=NONE cterm=NONE
  hi Error ctermfg=197 ctermbg=16 cterm=bold,reverse
  hi Identifier ctermfg=16 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=16 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=16 ctermbg=NONE cterm=NONE
  hi Special ctermfg=16 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=16 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=49 ctermbg=16 cterm=bold,reverse
  hi Type ctermfg=16 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=16 ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=16 ctermbg=154 cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=188 cterm=NONE
  hi ToolbarButton ctermfg=16 ctermbg=188 cterm=bold
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  " Light background
  hi CurSearch ctermfg=magenta ctermbg=black cterm=reverse
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Folded ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=yellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi PmenuSbar ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi Search ctermfg=cyan ctermbg=black cterm=reverse
  hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=bold
  hi StatusLineNC ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi TabLine ctermfg=darkgrey ctermbg=NONE cterm=reverse
  hi VertSplit ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=darkgreen ctermbg=black cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=black cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi Directory ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi FoldColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuMatch ctermfg=NONE ctermbg=darkred cterm=reverse
  hi PmenuExtra ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuKind ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuMatchSel ctermfg=darkred ctermbg=NONE cterm=bold
  hi PmenuExtraSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuKindSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuThumb ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Question ctermfg=NONE ctermbg=NONE cterm=standout
  hi QuickFixLine ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkblue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi StatusLine ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=standout
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi Comment ctermfg=NONE ctermbg=NONE cterm=bold
  hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=bold,reverse
  hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Special ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Statement ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Todo ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Type ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  unlet s:t_Co
  finish
endif

if s:t_Co >= 8
  " Light background
  hi CurSearch ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Folded ctermfg=NONE ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=darkyellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=NONE ctermbg=NONE cterm=NONE
  hi NonText ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Search ctermfg=darkcyan ctermbg=black cterm=reverse
  hi SpecialKey ctermfg=NONE ctermbg=NONE cterm=bold
  hi StatusLineNC ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi TabLine ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi VertSplit ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=darkgreen ctermbg=black cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=black cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=black cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi Directory ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi FoldColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuMatch ctermfg=NONE ctermbg=darkred cterm=reverse
  hi PmenuExtra ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuKind ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuMatchSel ctermfg=darkred ctermbg=NONE cterm=bold
  hi PmenuExtraSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuKindSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PmenuThumb ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Question ctermfg=NONE ctermbg=NONE cterm=standout
  hi QuickFixLine ctermfg=darkmagenta ctermbg=black cterm=reverse
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=reverse
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkblue ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi StatusLine ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Visual ctermfg=darkyellow ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=standout
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi Comment ctermfg=NONE ctermbg=NONE cterm=bold
  hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Error ctermfg=darkred ctermbg=black cterm=bold,reverse
  hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Special ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Statement ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Todo ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  hi Type ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=bold,reverse
  unlet s:t_Co
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=reverse
  hi CursorColumn term=NONE
  hi CursorLine term=underline
  hi CursorLineNr term=bold
  hi DiffAdd term=reverse
  hi DiffChange term=NONE
  hi DiffDelete term=reverse
  hi DiffText term=reverse
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,reverse
  hi FoldColumn term=NONE
  hi Folded term=NONE
  hi IncSearch term=bold,reverse,underline
  hi LineNr term=NONE
  hi MatchParen term=bold,underline
  hi ModeMsg term=bold
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=reverse
  hi PmenuSel term=bold
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=reverse
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=underline
  hi SpellCap term=underline
  hi SpellLocal term=underline
  hi SpellRare term=underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi Terminal term=NONE
  hi TabLineSel term=bold,reverse
  hi Title term=NONE
  hi VertSplit term=NONE
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Comment term=bold
  hi Constant term=NONE
  hi Error term=bold,reverse
  hi Identifier term=NONE
  hi Ignore term=NONE
  hi PreProc term=NONE
  hi Special term=NONE
  hi Statement term=NONE
  hi Todo term=bold,reverse
  hi Type term=NONE
  hi Underlined term=underline
  unlet s:t_Co
  finish
endif

" Background: light
" Color: brightwhite   #eeeeee           255               grey
" Color: light0        #000000           16                black
" Color: light1        #af0000           124               darkred
" Color: light2        #005f00           22                darkgreen
" Color: light3        #af5f00           130               darkyellow
" Color: light4        #005faf           25                darkblue
" Color: light5        #870087           90                darkmagenta
" Color: light6        #008787           30                darkcyan
" Color: light7        #d7d7d7           188               grey
" Color: light8        #626262           241               darkgrey
" Color: light9        #d70000           160               red
" Color: light10       #008700           28                green
" Color: light11       #d78700           172               yellow
" Color: light12       #0087d7           32                blue
" Color: light13       #af00af           127               magenta
" Color: light14       #00afaf           37                cyan
" Color: light15       #ffffff           231               white
" Color: diffred       #d78787           174               red
" Color: diffgreen     #87d787           114               green
" Color: diffblue      #afafd7           146               blue
" Color: diffpink      #d787d7           176               magenta
" Color: uipink        #ff00af           199               magenta
" Color: uilime        #afff00           154               green
" Color: uiteal        #00ffaf           49                cyan
" Color: uiblue        #00afff           39                blue
" Color: uipurple      #af00ff           129               darkmagenta
" Color: uiamber       #ffaf00           214               yellow
" Color: invisigrey    #a8a8a8           248               darkgrey
" Color: yasogrey      #e4e4e4           254               grey
" Color: uicursearch   #ff5fff           207               magenta
" Color: errorred      #ff005f           197               red
" Term colors: light0 light1 light2 light3 light4 light5 light6 light7
" Term colors: light8 light9 light10 light11 light12 light13 light14 light15
" Background: any
" vim: et ts=2 sw=2 sts=2
