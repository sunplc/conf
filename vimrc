"settings
set nocompatible	"不兼容vi
set history=100		"命令的历史记录最多保存100条
set number			" 显示行号
set visualbell

set tabstop=4		" 设置制表符的显示宽度为4列
set softtabstop=4	" 每个tab键占4个空格的宽度
set expandtab		" 制表符将被展开为多个空格字符
set shiftwidth=4

"set cindent		"设置C/C++方式自动对齐
set autoindent		" 新换一行时，复制当前行的缩进
set smarttab		" 在行和段开始处使用制表符 

syntax enable		" enable syntax processing

set path+=**		" 搜索时进入子目录搜索，find命令可以递归搜索，find dir/ or find a.txt
set wildmenu		" 使用tab键补全文件名时，显示所有匹配的文件，例如输入 :e ~/.vim<TAB>

" set cursorline	" 高亮当前行
set showmatch		" 高亮显示匹配的括号 [{()}]
set incsearch		" 输入pattern时即时搜索
set hlsearch		" 高亮显示搜索结果，可以用 :nohls 取消显示

let mapleader=","	" 设置leader key为逗号
nnoremap <leader><space> :nohlsearch<CR> " 设置快捷键逗号+空格，执行:nohlsearch(取消高亮显示搜索结果)

set textwidth=80	" 限制行宽，超过后自动换行
"set colorcolumn=80 " 第80列显示不同颜色
set fileformat=unix " 文件格式，换行符不同，unix=>LF, dos=>CRLF, mac=>CR
set encoding=utf-8	" 文件编码

set splitright
set splitbelow

"split navigations 使用CTRL+Vim标准移动键，切换窗口
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""
" 设置F3快捷键，执行当前文件
map <F3> :! ./% <CR>
" 设置F4快捷键 预处理当前文件
" map <F4> :! cpp % <CR>
map <F4> :w <CR> :! php % <CR>
" 设置F5快捷键 保存当前C文件并编译保存为当前文件名（后缀改为.out）,并运行
map <F5> :w <CR> :!gcc % -Wall -std=c99 -lm -o %<.out && ./%<.out <CR>
" 设置F6快捷键 保存当前C文件并编译保存为当前文件名加.gdb（后缀改为.out）,并使用GDB调试运行
map <F6> :w <CR> :!gcc % -Wall -lm -g -o %<.gdb.out && gdb %<.gdb.out <CR>
map <F7> :w <CR> :! make <CR>
map <F8> :w <CR> :! make clean && make <CR>

"" 补全单双引号和各种括号
"inoremap ' ''<LEFT>
"inoremap " ""<LEFT>
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
""inoremap { {}<LEFT>
"inoremap { {}<ESC>i
"" 输入{后立即回车，会空一行，然后补全}
"inoremap {<CR> {<CR><BS>}<ESC>O

"""""""""""" 补全单双引号和各种括号，自动跳过 start
inoremap {<cr> {<cr><BS>}<ESC>O    
"if set filetype indent on, please use the line above.

"inoremap {<cr> {<cr>}<ESC>O<TAB>
inoremap {<CR> {<CR><BS>}<ESC>O
"if you only set autoindent, please use the line above

function! CuteLeftBracket(character1, character2)
	let l:line = getline(".")
	let l:nextCharacter = l:line[col(".")]
	if (char2nr(l:nextCharacter) == 0) 
		\ || (char2nr(l:nextCharacter) == 9) 
		\ || (char2nr(l:nextCharacter) == 32)
		execute "normal! a" . a:character2
		execute "normal! h"
	endif
endfunction

function! CuteRightBracket(character)
	let l:line = getline(".")
	let l:nextCharacter = l:line[col(".")] 
	if l:nextCharacter == a:character 
		execute "normal! x"
	else
		execute "normal! r" . a:character
	endif
endfunction

inoremap ( (<ESC>:call CuteLeftBracket('(', ')')<cr>a
inoremap [ [<ESC>:call CuteLeftBracket('[', ']')<cr>a
inoremap { {<ESC>:call CuteLeftBracket('{', '}')<cr>a
inoremap ) .<ESC>:call CuteRightBracket(')')<cr>a
inoremap ] .<ESC>:call CuteRightBracket(']')<cr>a
inoremap } .<ESC>:call CuteRightBracket('}')<cr>a
"above are something which can make vim use ()[]{}just like Xcode

function! CuteQoute(character)
	let l:line = getline(".")
	let l:lastCharacter = l:line[col(".") - 2]
	let l:nextCharacter = l:line[col(".")] 
	"notice that we has inserted a quote befor we use this function
	"before the <ESC> works, it is like this [lastCharacter][samequote][cursor'|'][nextCharacter]"

	if char2nr(l:lastCharacter) == 92
		execute
	elseif l:nextCharacter == a:character
		execute "normal! x"
	elseif l:lastCharacter == a:character
		execute
	elseif (char2nr(l:nextCharacter) == 0) 
		\ || (char2nr(l:nextCharacter) == 9) 
		\ || (char2nr(l:nextCharacter) == 32)
		execute "normal! a" . a:character
		execute "normal! h"
	endif
endfunction

inoremap " "<ESC>:call CuteQoute("\"")<cr>a
inoremap ' '<ESC>:call CuteQoute("'")<cr>a
"above are something which can make vim use ''and \"" like Xcode

function! CuteDelete()
	let l:line = getline(".")
	let l:Character = l:line[col(".") - 3]
	let l:nextCharacter = l:line[col(".")]
	if col(".") != 2
		exec "normal x"
		if char2nr(l:nextCharacter) != 0 
			exec "normal h"
			if (((l:nextCharacter == ")") && (l:Character == "(")) || 
						\((l:nextCharacter == "}") && (l:Character == "{"))	||
						\((l:nextCharacter == "]") && (l:Character == "[")))	
				exec "normal x"
			elseif	(((l:nextCharacter == "'") && (l:Character == "'"))	||
						\((l:nextCharacter == "\"") && (l:Character == "\"")))	 
				let l:BackslashIndicator=l:line[col(".") - 3]
				let l:pos=col(".") - 3
				let l:counter=0
				while((l:pos > 0) && (l:BackslashIndicator == "\\"))
					let l:pos=l:pos - 1
					let l:counter=l:counter + 1
					let l:BackslashIndicator=l:line[l:pos]
				endwhile
				while(l:counter > 0)
					let l:counter=l:counter - 2
				endwhile
				if l:counter != -1
					exec "normal x"
				endif
			endif
		endif
	else
		if char2nr(l:Character) == 0
			exec "normal hx"
		endif
	endif
endfunction

inoremap <BS> ..<ESC>:call CuteDelete()<CR>a<BS><BS>


""""""""""""""""""""""""""""""""""""""""""""
" 新建文件时，自动根据扩展名加载模板文件
autocmd! BufNewFile * call LoadTemplate()
fun LoadTemplate()
	"获取扩展名或者类型名
	let ext = expand ("%:e")
	let tpl = expand("~/.vim/tpl/".ext.".tpl")
	if !filereadable(tpl)
		"echohl WarningMsg | echo "No template [".tpl."] for .".ext | echohl None
		return
	endif

	"读取模板内容
	silent execute "0r ".tpl
	"指定光标位置
	"silent execute "normal 5G$"
	"silent call search("#cursor#", "w")
	"silent execute "normal 7x"
	"进入插入模式
	"startinsert
endfun
""""""""""""""""""""""""""""""""""""""""""""

" If we're not in vi-compatible mode, then load advanced VIM code
" 仅当启动vim时才加载以下设置，避免启动vi时报错
if !has("compatible")

	" 1.安装 Vundle
	"   git clone https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
    " 2.执行 :PluginInstall
    " 3.安装 ctrlp
    "   cd ~/.vim
    "   git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim
    "   执行  :helptags ~/.vim/bundle/ctrlp.vim/doc
    "   重启执行  :helptags ~/.vim/bundle/ctrlp.vim/doc

	""""""""""  Vundle Plugin manage """"""""""""""""""
	filetype off                  " required
	
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	Plugin 'VundleVim/Vundle.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'scrooloose/nerdcommenter'
	Plugin 'NLKNguyen/papercolor-theme'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	"""""""""""""""""""""""""""""""""""""""""""""""""""
 
	" 插件设置
	" 1. NerdTree setting
	map <C-n> :NERDTreeToggle<CR>
	let g:NERDTreeDirArrowExpandable = '+'
	let g:NERDTreeDirArrowCollapsible = '-'
	" 2. NerdCommenter setting
	let g:NERDSpaceDelims = 1
	let g:NERDCompactSexyComs = 0
    " 3. papercolor-theme setting
    set t_Co=256
    set background=dark
    colorscheme PaperColor"
    " 4. ctrlp setting
    set runtimepath^=~/.vim/bundle/ctrlp.vim

	" tmux setting
	set term=screen-256color

	" papercolor-theme setting
	set t_Co=256
	set background=dark
	colorscheme PaperColor
	"colorscheme default

endif

