if vim.fn.has "nvim-0.7" == 1 then
    local cuc = vim.api.nvim_create_user_command
    cuc("FaustGenerateHelp", function()
        require('faust-nvim').generate_faust_docs()
    end, {desc = "Generate Faust Documents"})
    cuc("FaustDocs101", function()
        require('faust-nvim').faust101()
    end, {desc = "Faust 101"})
    cuc("FaustDocsLib", function()
        require('faust-nvim').faustlibdocs()
    end, {desc = "Faust Docs"})
    cuc("FaustDocsSyntax", function()
        require('faust-nvim').faustsyntax()
    end, {desc = "Faust Syntax"})
    cuc("FaustDocsCompiler", function()
        require('faust-nvim').faustcompilerdocs()
    end, {desc = "Faust Compiler"})
    cuc("FaustExamples", function()
        require('faust-nvim').faustexamples()
    end, {desc = "Faust Examples"})
    -- cuc("FaustWelcome", function(args)
    --     print("Welcome and " .. args.args)
    -- end, {
    -- nargs = "*",
    -- desc = "Faust says welcome",
    -- })
else
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
end
