-- Bootstrap lazy.nvim if necessary
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

-- Initialize lazy.nvim
vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup('plugins', {})

-- Import config modules
require('keybindings')
