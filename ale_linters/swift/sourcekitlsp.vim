" Author: Dan Loman <https://github.com/namolnad>
" Description: Support for sourcekit-lsp https://github.com/apple/sourcekit-lsp

call ale#Set('sourcekit_lsp_executable', 'sourcekit-lsp')

function! ale_linters#swift#sourcekitlsp#GetCommand(buffer) abort
	return '%e' . ' ' .
		\	'-Xswiftc "-sdk"' . ' ' .
		\	'-Xswiftc "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator13.6.sdk"' . ' ' .
		\	'-Xswiftc "-target"' . ' ' .
		\	'-Xswiftc "x86_64-apple-ios13.6-simulator"'
endfunction

call ale#linter#Define('swift', {
\   'name': 'sourcekitlsp',
\   'lsp': 'stdio',
\   'executable': {b -> ale#Var(b, 'sourcekit_lsp_executable')},
\   'command': function('ale_linters#swift#sourcekitlsp#GetCommand'),
\   'project_root': function('ale#swift#FindProjectRoot'),
\   'language': 'swift',
\})
