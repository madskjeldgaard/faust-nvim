# Requirements
- Unix or linux system
- Nvim >= v0.5

# installation
Using vim-plug

```
" faust syntax and filetype
Plug 'gmoe/vim-faust'

" Other faust things
Plug '~/code/faust-nvim'
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
