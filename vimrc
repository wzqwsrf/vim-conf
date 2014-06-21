"通用配置"启动时不显示援助乌干达儿童
set shortmess=atI

"设定窗口位置
winpos 5 5

"设定窗口大小
" set lines=40 columns=155

"自动语法高亮
syntax on

"关闭vi兼容模式,目的是避免以前版本的一些bug和局限性
set nocompatible

"设定配色模式
colorscheme desert 

"设定背景主题,同colorscheme
"color blue

"用浅色高亮当前行
autocmd InsertLeave * se nocul
autocmd InsertLeave * se cul

"设置行号, 相当于set number
set nu

"覆盖文件时，不需要备份
set nobackup

"设置备份时的行为为覆盖
set backupcopy=yes

"搜索时忽略大小写
set ignorecase smartcase

"禁止搜索到文件两端时重新搜索
set nowrapscan

"输入搜索内容时就显示搜索结果
set incsearch

"搜索时高亮显示已经被找到的内容
set hlsearch

"未保存或者只读时，弹出确认
set confirm

"鼠标可用
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"显示未完成命令
set showcmd

"tab为4个空格
set tabstop=4

"退格键，一次可以删除的空格键
set softtabstop=4

"设定命令移动时的宽度
set shiftwidth=4

"自动切换当前目录为当前文件所在的目录
set autochdir

"c文件类型自动缩进
set cindent

"自动对齐
set autoindent

"智能缩进
set smartindent

"高亮查找匹配
set hlsearch

"背景色
set background=dark

"显示括号匹配
set showmatch
"显示括号匹配的时间
set matchtime=2

"设置魔术
set magic

"开启新行时，使用只能缩进
set smartindent

"设置命令行的行数为1
set cmdheight=1

"右下角显示光标位置,状态栏标尺
set ruler

"显示状态栏，默认为1,不显示
set laststatus=1

" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}  

"被分割的窗口之间显示空白
"set fillchars=vert:/,stl:/,stlnc:/

"不发出警告声
set noerrorbells

"允许折叠
set foldenable

"手动折叠
set foldmethod=manual


set foldmethod=syntax

"空格控制折叠
nnoremap <space>@=((foldclosed(line('.'))<0)?'zc':'zo') <CR>


"开启插件
filetype plugin indent on

set fileencodings=gbk,utf-8,gb2312,gb18030,cp936
set termencoding=gbk,utf-8,gb2312,gb18030,cp936
set encoding=utf-8
set fileencoding=utf-8

"常用函数

"返回操作系统类型
function! MySys()
	if has("win16") ||has("win32")||has("win64")||has("win95")
		return "windows"
	elseif has("unix")
		return 'linux'
	endif
endfunction

"环境初始化
if MySys()=="windows"
	let $VIMFILES=$VIM.'/vimfiles'
elseif MySys()=="linux"
	let $VIMFILES=$HOME.'/.vim'
endif

"设定doc文档目录
let helptags=$VIMFILES.'/doc'

"显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

"设定字体及中文支持
if has("win32")
	set guifont=Inconsolata:h12:cANSI
endif

"配置多语言环境
if has("multi_byte")
	set encoding=utf-8
	set termencoding=utf-8
	set formatoptions+=mM
	set fencs=utf-8,gbk
	if v:lang=~?'^\(zh=\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
	if has("win32")
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
		language messages zh_CN.utf-8
	endif
else
	echoerr "SOrry,this version of vim was not complied with +multi_byte"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建shell文件，cpp文件的文件开头内容
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'sh'
		call setline(1,"\#########################################################################")
		call append(line("."), "\# File Name: ".expand("%")) 
		call append(line(".")+1, "\# Author: tingfang.bao") 
		call append(line(".")+2, "\# mail: mantingfangabc@163.com") 
		call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 
	endif
	autocmd BufNewFile * normal GG
endfunc

"""""""""""""""""""""""""""
"键盘命令,没有明白
""""""""""""""""""""""""""
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

""""""""""""""""""""""""""""
"全选复制:ctrl+a
""""""""""""""""""""""""""""
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G

""""""""""""""""""""""""""""
"选中状态下，ctrl+c复制
"""""""""""""""""""""""""""
vmap <C-c> "+y"

"去空行
nnoremap <F2> :g/^\s*$/d<CR>

"比较文件
nnoremap <C-F2> :vert diffsplit

"新建标签
map <C-t> <Esc>:tabnew<CR>

"关闭文件
" map <C-X> :close<CR> 

"多窗口切换快捷键
" map <silent> <C-j> <C-W>j
" map <silent> <C-k> <C-W>K
" map <silent> <C-h> <C-W>h
" map <silent> <C-l> <C-W>l
" map <silent> <C-R> <C-W>r
"c c++ java按F5进行编译
map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:! ./%
	elseif &filetype == 'python'
		exec "!python %"
	endif
endfunc
"C, C++调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


"NERDTree Config

"文件浏览器在左边
let NERDTreeWinPos = 'left'

"文件浏览器的宽度
let NERDTreeWinSize = 31

"打开文件浏览器的快捷方式
map <C-F11> <ESC>:NERDTreeToggle<RETURN>

"打开vim时，自动启动NERDtree插件
autocmd vimenter * NERDTree


"如果最后一个窗口是NERDTree，自动关[M u1闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

"启用python自动补全功能
"ctrl+x ctrl+o
"ctrl+n ctrl+p
filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete

"启用pydiction diction/插件=10
let g:pydiction_location='~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height=3

"--ctags setting--
" 按下F5重新生成tag文件，并更新taglist
map <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F6> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags "add current directory's generated tags file
" set tags+=~/arm/linux-2.6.24.7/tags "add new tags file(刚刚生成tags的路径，在ctags -R 生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件)
set tags+=/usr/include/tags

"-- omnicppcomplete setting --
" 按下F3自动补全代码，注意该映射语句后不能有其他字符，包括tab；否则按下F3会自动补全一些乱码
imap <F3> <C-X><C-O>
" 按下F2根据头文件内关键字补全
imap <F2> <C-X><C-I>
set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
"let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1 

"highlight Pmenu ctermbg=13 guibg=LightGray
"这是就是得这么设置，不然智能提示的选择项看不到
highlight PmenuSel ctermbg=7 guibg=Black guifg=White
"highlight PmenuSbar ctermbg=7 guibg=DarkGray guifg=white
"highlight PmenuThumb guibg=LightGray

"-- Taglist setting --
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"是否一直处理tags.1:处理;0:不处理
let Tlist_Process_File_Always=1 "实时更新tags
let Tlist_Inc_Winwidth=0

"Taglist 快捷键
map <C-F12> <ESC>:Tlist<RETURN>
autocmd vimenter * Tlist

"--fold setting--
set foldmethod=syntax "用语法高亮来定义折叠
set foldlevel=100 "启动vim时不要自动折叠代码
"set foldcolumn=2 "设置折叠栏宽度

"按ctrl+u，将刚刚输入的那个单词变成大写
inoremap <C-u> <ESC>gUiwea

"powerline{
set guifont="PowerlineSymbols for Powerline"
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'
"}
