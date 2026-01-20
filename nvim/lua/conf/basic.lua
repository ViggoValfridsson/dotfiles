vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- Set default indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Don't wrap lines
vim.opt.wrap = false

-- Reset  cursor on leave
vim.cmd([[
  augroup SetGuiCursor
    autocmd!
    autocmd VimLeave,VimSuspend * set guicursor=a:ver20
  augroup END
]])

-- Always split in intuitive directions
vim.opt.splitright = true   -- vertical splits open to the right
vim.opt.splitbelow = true  -- horizontal splits open below

-- Always keep 8 rows below cursor
vim.opt.scrolloff = 8
