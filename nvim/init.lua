--[[
===========Options==========
--]]
local opts = {
	rnu = true,
	nu = true,
	incsearch = true,
	ignorecase = true,
	smartcase = true,
	scrolloff = 999,
	sidescrolloff = 999,
	wrap = false,
	hlsearch = false,
	splitbelow = true,
	splitright = true,
	completeopt = { 'menuone', 'menu', 'noselect' },
	pumheight = 10,
	expandtab = true,
	shiftwidth = 8,
	softtabstop = -1,
	smarttab = true,
	smartindent = true,
	cindent = true,
	timeoutlen = 300,
	signcolumn = 'yes',
        guicursor = 'a:block'
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

--[[
==========Keymaps=========
--]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function imap(lhs, rhs, desc)
        local key_opts = { noremap = true, silent = true, desc = desc }
        vim.keymap.set('i', lhs, rhs, key_opts)
end

local function nmap(lhs, rhs, desc)
        local key_opts = { noremap = true, silent = true, desc = desc }
        vim.keymap.set('n', lhs, rhs, key_opts)
end

-- INSERT MODE
imap('jj', '<Esc>', 'Return to NORMAL mode from INSERT mode.')

-- NORMAL MODE
nmap('<Leader>h', ':bprev<CR>', 'Swap to the buffer on the left.')
nmap('<Leader>l', ':bnext<CR>', 'Swap to the buffer on the right.')

--[[
=========Plugins========
--]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
        -- Theme
        {
                'rebelot/kanagawa.nvim',
                opts = {
                        commentStyle = { italic = false },
                        keywordStyle = { italic = false },
                        theme = 'dragon'
                },
                config = function(_, opts)
                        vim.cmd([[colorscheme kanagawa]])
                end
        },

        -- Treesitter
        {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
                config = function()
                        local configs = require('nvim-treesitter.configs')
                        configs.setup({
                                ensure_installed = {
                                        'c',
                                        'lua',
                                        'markdown',
                                        'bash'
                                },
                        })
                end
        },

        -- Plenary
        {
                'nvim-lua/plenary.nvim'
        }
})

-- Buffer navigation plugin.
