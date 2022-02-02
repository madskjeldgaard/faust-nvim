local commands = {
	"FaustGenerateHelp lua require('faust-nvim').generate_faust_docs()",
	"FaustDocs101 lua require('faust-nvim').faust101()",
	"FaustDocsLib lua require('faust-nvim').faustlibdocs()",
	"FaustDocsSyntax lua require('faust-nvim').faustsyntax()",
	"FaustDocsCompiler lua require('faust-nvim').faustcompilerdocs()",
	"FaustExamples lua require('faust-nvim').faustexamples()",
}

for index = 1, #commands do
	vim.cmd("command! " .. commands[index])
end
