# Features

- Commands for compiling and installing as SuperCollder UGens, to Teensy and others
- Fuzzy find examples
- Commands for looking up docs
- Correct comment string for faust filetype
- Faust snippets (snippets.nvim format)
- Other small handdy bits and pieces

# Requirements
- Unix or linux system
- Nvim >= v0.5

# installation
Using vim-plug

```
" faust syntax and filetype
Plug 'gmoe/vim-faust'

" Other faust things
Plug 'madskjeldgaard/faust-nvim'
```

Using packer.nvim
```lua
use {
    'madskjeldgaard/faust-nvim',
        ft = "faust", -- only load plugin on .dsp files
        config = function()
            require 'faust-nvim'.setup()
            local opts = { noremap = true, silent = true }
            -- mapping examples
            vim.api.nvim_set_keymap('n', '<A-h>', ':FaustExamples<CR>', opts)
            vim.api.nvim_set_keymap('n', '<C-e>', ':Faust2SCInstall<cr>', opts)
        end,
        requires = 'gmoe/vim-faust'
}
```

# Setup

call the .setup function via lua:
```lua
require 'faust-nvim'.setup()
```

And then if you want to use the snippets with snippets.nvim, import the snippets to your global snippets-table:

```lua
require'snippets'.snippets["faust"] = require'faust-nvim/snippets'
```
