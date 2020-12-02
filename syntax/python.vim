" Sophisticated syntax highlight for Python in Vim
" Works well with Nord colorscheme
" Author: Filip Godlewski
" Based on: vim-python/python-syntax
" Last update: December 3rd 2020
" Comment: No support for Python 2

if exists("b:current_syntax")
    finish
endif
let s:cpo_save = &cpo
set cpo&vim
let b:current_syntax = 1

" Commented
syn match   pythonShebang       '\%^#!.*$'
syn match   pythonCoding        '\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$'
syn match   pythonComment	"#.*$" contains=pythonTodo,@Spell
syn keyword pythonTodo		FIXME NOTE NOTES TODO TODOS REF REFS contained

" Imports
syn keyword pythonInclude       import as
syn match   pythonInclude       '^\s*\zsfrom\>'

" Statements
syn match   pythonStatement     '\v\.@<!<await>'
syn match   pythonStatement     '\<async\s\+def\>' nextgroup=pythonDefFunc,pythonDefNoArgs skipwhite
syn match   pythonStatement     '\<class\>' containedin=pythonDefFunc,pythonDefNoArgs
syn match   pythonStatement     '\<def\>' containedin=pythonDefFunc,pythonDefNoArgs
syn match   pythonStatement     '\<async\s\+with\>'
syn match   pythonStatement     '\<async\s\+for\>'
syn keyword pythonException     except finally try
syn keyword pythonStatement     assert continue exec global
syn keyword pythonStatement	lambda nonlocal pass print return with yield

" Classes
syn keyword pythonClassVar      self cls containedin=pythonStrInterReg,pythonFuncPar nextgroup=pythonVar,pythonFunc
syn match   pythonVar 	        '\%(\%(from\|import\).\+\)\@<!\zs\.\(\h\w*\)\@>\(__\)\@<!\((\)\@!'hs=s+1 containedin=pythonStrInterReg contains=pythonVarDot nextgroup=pythonFunc,pythonVar
syn match   pythonVarDot        '\.' display containedin=pythonVar contains=pythonVar

" Function definition
syn match   pythonDefNoArgs     '\(def\|class\)\s\k\+:'
syn region  pythonDefFunc       start=+\(def\|class\)\s\k\+(+ excludenl end=+).\{-}:+ keepend contains=pythonDefFuncArg,pythonDefFuncPar
syn region  pythonDefFuncPar    start=+(+ excludenl end=+:$+ containedin=pythonDefFunc contains=pythonDefFuncVal,pythonDefFuncNot display
syn match   pythonDefFuncArg    ~\%((\|,\s\|=\s\)\@>\zs\%(\w\+\|\*\{1,2}\w\+\|'.\+'\|".\+"\)~ containedin=pythonDefFuncPar contains=pythonClassVar,pythonDefFuncAst,pythonDefFuncNot
syn match   pythonDefFuncAst    '\*' containedin=pythonDefFuncPar
syn match   pythonDefFuncNot    '\%(abs\|all\|any\|bin\|bool\|bytearray\|callable\|chr\|classmethod\|compile\|complex\|delattr\|dict\|dir\|divmod\|enumerate\|eval\|filter\|float\|format\|frozenset\|getattr\|globals\|hasattr\|hash\|help\|hex\|id\|input\|int\|isinstance\|issubclass\|iter\|len\|list\|locals\|map\|max\|memoryview\|min\|next\|object\|oct\|open\|ord\|pow\|print\|property\|range\|repr\|reversed\|round\|set\|setattr\|slice\|sorted\|staticmethod\|str\|sum\|super\|tuple\|type\|vars\|zip\|ascii\|bytes\|exec\|append\|sort\|reverse\|extend\|insert\|remove\|pop\|count\|capitalize\|casefold\|center\|encode\|endswith\|expandtabs\|find\|format_map\|index\|isalnum\|isdecimal\|isdigit\|isidentifier\|islower\|isnumeric\|isprintable\|isspace\|istitle\|isupper\|breakpoint\)' contained
syn match   pythonDefFuncVal    ~\(=\s\)\zs\(\w\+\|'.\+'\|".\+"\)\ze~ containedin=pythonDefFuncPar contains=pythonNumber,pythonBuiltinType,pythonString
syn match   pythonDefFuncVal    ~\(=\)\(\w\+\|'.\+'\|".\+"\)\ze~hs=s+1 containedin=pythonDefFuncPar contains=pythonNumber,pythonBuiltinType,pythonString

" Function call
syn region  pythonFunc          start=+\k\+(+ excludenl end=+)+ keepend contains=pythonFuncPar
syn region  pythonFuncPar       start=+(+ excludenl end=+)+ containedin=pythonFunc
syn match   pythonFuncArg       ~\%((\|,\s\|=\s\)\@>\zs\%(\d\+\|\w\+\|\*\{1,2}\w\+\|'.\+'\|".\+"\)~ containedin=pythonFuncPar contains=pythonFunc,pythonClassVar,pythonFuncAst,pythonNumber,pythonString,pythonFString,pythonBuiltinType,pythonBuiltinMethod
syn match   pythonFuncAst       '\*' containedin=pythonFuncPar
syn match   pythonFuncVal       ~\(=\)\zs\(\w\+\|'.\+'\|".\+"\)\ze~ containedin=pythonFuncPar contains=pythonFunc,pythonClassVar,pythonNumber,pythonBuiltinType,pythonString,pythonFString

" Operators
syn keyword pythonOperator	and in is or containedin=pythonStrInterReg,pythonFuncPar
syn match pythonOperator        '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!=\|!!=' containedin=pythonFString,pythonStrFormat
syn keyword pythonConditional	elif else if containedin=pythonStrInterReg,pythonFuncPar
syn keyword pythonRepeat	for while
syn keyword pythonNegative      not
syn keyword pythonNegStatement  del break raise

" Decorators
syn match   pythonDecorator     '@\k'he=e-1

" Builtin Functions
syn keyword pythonBuiltinFunc	abs all any ascii
syn keyword pythonBuiltinFunc   bin bool bytearray bytes
syn keyword pythonBuiltinFunc   callable chr classmethod compile complex
syn keyword pythonBuiltinFunc	delattr dict dir divmod
syn keyword pythonBuiltinFunc	enumerate eval exec
syn keyword pythonBuiltinFunc   filter float format frozenset
syn keyword pythonBuiltinFunc	getattr globals
syn keyword pythonBuiltinFunc	hasattr hash help hex
syn keyword pythonBuiltinFunc	id input int isinstance issubclass iter
syn keyword pythonBuiltinFunc	len list locals
syn keyword pythonBuiltinFunc	map max memoryview min
syn keyword pythonBuiltinFunc	next
syn keyword pythonBuiltinFunc	object oct open ord
syn keyword pythonBuiltinFunc	pow print property
syn keyword pythonBuiltinFunc	range repr reversed round
syn keyword pythonBuiltinFunc	set setattr slice sorted staticmethod str sum super
syn keyword pythonBuiltinFunc	tuple type
syn keyword pythonBuiltinFunc	tuple type
syn keyword pythonBuiltinFunc	vars
syn keyword pythonBuiltinFunc	zip

" Builtin String Functions
syn keyword pythonBuiltinFunc	capitalize casefold count
syn keyword pythonBuiltinFunc   encode endswith expandtabs
syn keyword pythonBuiltinFunc	find format format_map
syn keyword pythonBuiltinFunc   index
syn keyword pythonBuiltinFunc	isalnum isaplha isdecimal isdigit isidentifier islower
syn keyword pythonBuiltinFunc	isnumeric isprintable isspace istitle isupper
syn keyword pythonBuiltinFunc	join
syn keyword pythonBuiltinFunc	ljust lower lstrip
syn keyword pythonBuiltinFunc	maketrans
syn keyword pythonBuiltinFunc	partition
syn keyword pythonBuiltinFunc	replace rfind rindex rjust rpartition rsplit rstrip
syn keyword pythonBuiltinFunc	split splitlines startswith strip swapcase
syn keyword pythonBuiltinFunc	title translate
syn keyword pythonBuiltinFunc	upper
syn keyword pythonBuiltinFunc	zfill

" Builtin List Functions
syn keyword pythonBuiltinFunc	append clear copy count extend insert pop remove reverse sort

" Builtin Dict Functions
syn keyword pythonBuiltinFunc   clear copy fromkeys get items keys pop popitem setdefault update values

" Builtin Tuple Functions
syn keyword pythonBuiltinFunc   count index

" Builtin Set Functions
syn keyword pythonBuiltinFunc   add
syn keyword pythonBuiltinFunc   clear copy
syn keyword pythonBuiltinFunc   difference difference_update discard
syn keyword pythonBuiltinFunc   intersection intersection_update isdisjoint issubset issuperset
syn keyword pythonBuiltinFunc   pop
syn keyword pythonBuiltinFunc   remove
syn keyword pythonBuiltinFunc   symmetric_difference symmetric_difference_update
syn keyword pythonBuiltinFunc   union update

" Builtin File Functions
syn keyword pythonBuiltinFunc	close
syn keyword pythonBuiltinFunc	detach
syn keyword pythonBuiltinFunc	fileno flush
syn keyword pythonBuiltinFunc	isatty
syn keyword pythonBuiltinFunc	read readable readline readlines
syn keyword pythonBuiltinFunc	seek seekable
syn keyword pythonBuiltinFunc	tell truncate
syn keyword pythonBuiltinFunc	writable write writelines

" Builtin debugging Functions
syn keyword pythonBuiltinFunc	breakpoint

" Builtin Objects
syn keyword pythonBuiltinMethod __doc__ __file__ __name__ __package__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __qualname__ __module__ __defaults__ __code__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __globals__ __dict__ __closure__ __annotations__ __kwdefaults__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __new__ __init__ __post_init__ __init_subclass__ __del__ __repr__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __str__ __bytes__ __format__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __lt__ __le__ __eq__ __ne__ __gt__ __ge__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __hash__ __bool__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __getattr__ __getattribute__ __setattr__ __delattr__ __dir__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __get__ __set__ __delete__ __set_name__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __slots__ __weakref__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __mro_entries__ __prepare__ __class__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __instancecheck__ __subclasscheck__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __class_getitem__ __call__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __len__ __length_hint__ __getitem__ __setitem__ __delitem__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __missing__ __iter__ __reversed__ __contains__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __add__ __sub__ __mul__ __matmul__ __truediv__ __floordiv__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __mod__ __divmod__ __pow__ __lshift__ _rshift__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __and__ __xor__ __or__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __radd__ __rsub__ __rmul__ __rmatmul__ __rtruediv__ __rfloordiv__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __rmod__ __rdivmod__ __rpow__ __rlshift__ _rshift__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __rand__ __rxor__ __ror__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __iadd__ __isub__ __imul__ __imatmul__ __itruediv__ __ifloordiv__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __imod__ __idivmod__ __ipow__ __ilshift__ _rshift__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __iand__ __ixor__ __ior__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __neg__ __pos__ __abs__ __invert__ __complex__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __int__ __float__ __index__ __round__ __trunc__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __floor__ __ceil__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __enter__ __exit__ __await__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __loader__ __spec__ __path__ __cached__ containedin=pythonDefFunc,pythonFunc
syn keyword pythonBuiltinMethod __debug__ containedin=pythonDefFunc,pythonFunc

" Builtin Types
syn keyword pythonBuiltinType   False None True containedin=pythonStrInterReg,pythonFuncPar
syn match   pythonBuiltinType   '\%(False\|None\|True\)'
syn keyword pythonBuiltinType   object bool int float type str list dict set frozenset bytearray bytes containedin=pythonStrInterReg contained
syn keyword pythonBuiltinType   NotImplemented Ellipsis
syn match   pythonBuiltinTyping '\(:\|: \|-> \)\zs\w\+' contains=pythonBuiltinType containedin=pythonDefFuncPar

" Builtin Exceptions
syn keyword pythonExceptions	Exception
syn keyword pythonExceptions	BaseException

syn keyword pythonErrors	ArithmeticError AssertionError AttributeError
syn keyword pythonErrors	BufferError
syn keyword pythonErrors	EOFError
syn keyword pythonErrors	FloatingPointError
syn keyword pythonErrors	GeneratorExit
syn keyword pythonErrors	ImportError IndentationError IndexError
syn keyword pythonErrors	KeyError KeyboardInterrupt
syn keyword pythonErrors	LookupError
syn keyword pythonErrors	MemoryError
syn keyword pythonErrors	NameError NotImplementedError
syn keyword pythonErrors	OSError OverflowError
syn keyword pythonErrors	ReferenceError RuntimeError
syn keyword pythonErrors	StopIteration SyntaxError SystemError SystemExit
syn keyword pythonErrors	TabError TypeError
syn keyword pythonErrors	UnboundLocalError UnicodeError UnicodeDecodeError UnicodeEncodeError UnicodeTranslateError
syn keyword pythonErrors	ValueError
syn keyword pythonErrors	ZeroDivisionError

syn keyword pythonErrors	BlockingIOError BrokenPipeError
syn keyword pythonErrors	ChildProcessError ConnectionAbortedError ConnectionError ConnectionRefusedError ConnectionResetError
syn keyword pythonErrors	EnvironmentError
syn keyword pythonErrors	FileExistsError FileNotFoundError
syn keyword pythonErrors	InterruptedError IOError IsADirectoryError
syn keyword pythonErrors	NotADirectoryError
syn keyword pythonErrors	PermissionError ProcessLookupError
syn keyword pythonErrors	RecursionError
syn keyword pythonErrors	StopAsyncIteration
syn keyword pythonErrors	TimeoutError
syn keyword pythonErrors	VMSError
syn keyword pythonErrors	WindowsError

syn keyword pythonWarnings	BytesWarning DeprecationWarning FutureWarning
syn keyword pythonWarnings	ImportWarning PendingDeprecationWarning
syn keyword pythonWarnings	RuntimeWarning SyntaxWarning UnicodeWarning
syn keyword pythonWarnings	UserWarning Warning
syn keyword pythonWarnings	ResourceWarning

" Numbers
syn match   pythonNumber        '\<\d\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat
syn match   pythonNumber        '\<[1-9][_0-9]*\d\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat
syn match   pythonNumber        '\<\d[jJ]\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat
syn match   pythonNumber        '\<[1-9][_0-9]*\d[jJ]\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat
syn match   pythonNumber        '\<0[xX][_0-9a-fA-F]*\x\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat " hex
syn match   pythonNumber        '\<0[oO][_0-7]*\o\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat " oct
syn match   pythonNumber        '\<0[bB][_01]*[01]\>' display containedin=pythonStrInterReg,pythonFuncPar,pythonDefFuncArg,pythonFuncArg,pythonFString,pythonStrFormat " bin

" Python 3 byte strings
syn region pythonBytes          start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes          start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes          start=+[bB]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell
syn region pythonBytes          start=+[bB]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest2,pythonSpaceError,@Spell

syn match pythonBytesError      '.\+' display contained
syn match pythonBytesContent    '[\u0000-\u00ff]\+' display contained contains=pythonBytesEsc,pythonBytesEscError containedin=pythonBytes

syn match pythonBytesEsc        +\\[abfnrtv'"\\]+ display contained
syn match pythonBytesEsc        '\\\o\o\=\o\=' display contained
syn match pythonBytesEscError   '\\\o\{,2}[89]' display contained
syn match pythonBytesEsc        '\\x\x\{2}' display contained
syn match pythonBytesEscError   '\\x\x\=\X' display contained
syn match pythonBytesEsc        '\\$'

syn match pythonUniEsc          '\\u\x\{4}' display contained
syn match pythonUniEscError     '\\u\x\{,3}\X' display contained
syn match pythonUniEsc          '\\U\x\{8}' display contained
syn match pythonUniEscError     '\\U\x\{,7}\X' display contained
syn match pythonUniEsc          '\\N{[A-Z ]\+}' display contained
syn match pythonUniEscError     '\\N{[^A-Z ]\+}' display contained

" Strings
syn region pythonString         start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonString         start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonString         start=+'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest,pythonSpaceError,@Spell
syn region pythonString         start=+"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest2,pythonSpaceError,@Spell

syn region pythonFString        start=+[fF]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonFString        start=+[fF]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonFString        start=+[fF]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest,pythonSpaceError,@Spell
syn region pythonFString        start=+[fF]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest2,pythonSpaceError,@Spell

" Raw strings
syn region pythonRawString      start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawString      start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawString      start=+[rR]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawString      start=+[rR]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell

syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell

syn match pythonRawEsc          +\\['"]+ display contained

" % operator string formatting
syn match pythonStrFormatting   '%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString,pythonBytesContent
syn match pythonStrFormatting   '%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString,pythonBytesContent

" str.format syntax
syn match pythonStrFormat       "{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonRawString
syn region pythonStrInterReg    start="{"he=e+1,rs=e+1 end="\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}"hs=s-1,re=s-1 extend contained containedin=pythonFString,pythonRawFString contains=pythonStrInterpRegion,@pythonExpression
syn match pythonStrFormat       "{{\|}}" contained containedin=pythonString,pythonRawString,pythonFString,pythonRawFString

" string.Template format
syn match pythonStrTemplate     '\$\$' contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate     '\${[a-zA-Z_][a-zA-Z0-9_]*}' contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate     '\$[a-zA-Z_][a-zA-Z0-9_]*' contained containedin=pythonString,pythonRawString

" setup
hi          pythonClassVar      ctermfg=008 guifg=#4C566A cterm=italic gui=italic
hi          pythonDecorator     ctermfg=003 guifg=#EBCB8B cterm=bold gui=bold
hi          pythonDefFuncNot    ctermfg=001 guifg=#BF616A cterm=bold gui=bold
hi          pythonErrors        ctermfg=001 guifg=#BF616A
hi          pythonNegStatement  ctermfg=001 guifg=#BF616A cterm=bold gui=bold
hi          pythonNegative      ctermfg=001 guifg=#BF616A
hi          pythonVar           ctermfg=002 guifg=#A3BE8C cterm=bold gui=bold
hi          pythonWarnings      ctermfg=003 guifg=#EBCB8B
hi def link pythonBytesEsc      Comment
hi def link pythonCoding        Comment
hi def link pythonComment	Comment
hi def link pythonRawEsc        Comment
hi def link pythonShebang       Comment
hi def link pythonUniEsc        Comment
hi def link pythonConditional	Conditional
hi def link pythonDoctestValue	Define
hi def link pythonSpaceError	Error
hi def link pythonException	Exception
hi def link pythonDefFunc 	Function
hi def link pythonDefNoArgs     Function
hi def link pythonFunc		Function
hi def link pythonInclude	Include
hi def link pythonVarDot        NormalNC
hi def link pythonBuiltin	Number
hi def link pythonBuiltin       Number
hi def link pythonBuiltinFunc   Number
hi def link pythonBuiltinMethod Number
hi def link pythonBuiltinType   Number
hi def link pythonExceptions    Number
hi def link pythonNumber	Number
hi def link pythonOperator	Operator
hi def link pythonRepeat	Repeat
hi def link pythonDoctest	Special
hi def link pythonEscape	Special
hi def link pythonDefFuncAst    SpecialChar
hi def link pythonFuncAst       SpecialChar
hi def link pythonStrFormat     SpecialChar
hi def link pythonStrFormatting SpecialChar
hi def link pythonStrInterReg   SpecialChar
hi def link pythonStrTemplate   SpecialChar
hi def link pythonAsync		Statement
hi def link pythonStatement	Statement
hi def link pythonQuotes	String
hi def link pythonRawString	String
hi def link pythonString	String
hi def link pythonTodo		Todo
hi def link pythonTripleQuotes	pythonQuotes
hi def link pythonBytesError    pythonErrors
hi def link pythonBytesEscError pythonErrors
hi def link pythonUniEscError   pythonErrors
hi def link pythonBytes         pythonString
hi def link pythonBytesContent  pythonString
hi def link pythonFString       pythonString
hi def link pythonRawBytes      pythonString
hi def link pythonRawFString    pythonString
