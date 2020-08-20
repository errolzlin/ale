" Author: Dan Loman <https://github.com/namolnad>
" Description: Support for sourcekit-lsp https://github.com/apple/sourcekit-lsp

call ale#Set('sourcekit_lsp_executable', 'sourcekit-lsp')
call ale#Set('sourcekit_lsp_sdk', '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator13.6.sdk')
call ale#Set('sourcekit_lsp_target, 'x86_64-apple-ios13.6-simulator')

" function! ale_linters#swift#sourcekitlsp#GetCommand(buffer) abort
	" return '%e' . ' ' .
		" \	'-Xswiftc "-sdk"' . ' ' .
		" \	'-Xswiftc /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator13.6.sdk' . ' ' .
		" \	'-Xswiftc "-target"' . ' ' .
		" \	'-Xswiftc x86_64-apple-ios13.6-simulator'
" endfunction

function! ale_linters#swift#sourcekitlsp#GetCommand(buffer) abort
	return '%e' . ' ' .
		\	'-Xswiftc -sdk' . ' ' .
		\	'-Xswiftc ' . ale#Var(a:buffer, 'sourcekit_lsp_sdk') . ' ' .
		\	'-Xswiftc -target' . ' ' .
		\	'-Xswiftc ' . ale#Var(a:buffer, 'sourcekit_lsp_target')
endfunction

call ale#linter#Define('swift', {
\   'name': 'sourcekitlsp',
\   'lsp': 'stdio',
\   'executable': {b -> ale#Var(b, 'sourcekit_lsp_executable')},
\   'command': function('ale_linters#swift#sourcekitlsp#GetCommand'),
\   'project_root': function('ale#swift#FindProjectRoot'),
\   'language': 'swift',
\})
