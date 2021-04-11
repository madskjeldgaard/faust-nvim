local commands = {
	"Faust2SC lua require('faust-nvim').faust2sc()",
	"Faust2Teensy lua require('faust-nvim').faust2teensylib()",
	"Faust2SCInstall lua require('faust-nvim').faust2scinstall()",
	"FaustDocs101 lua require('faust-nvim').faust101()",
	"FaustDocsLib lua require('faust-nvim').faustlibdocs()",
	"FaustDocsSyntax lua require('faust-nvim').faustsyntax()",
	"FaustDocsCompiler lua require('faust-nvim').faustcompilerdocs()",
	"FaustExamples lua require('faust-nvim').faustexamples()",
}

for index = 1, #commands do
	vim.cmd("command! " .. commands[index])
end
