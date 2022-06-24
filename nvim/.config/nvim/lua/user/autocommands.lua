local vim = vim
local api = vim.api

function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmds = {
  general_settings = {
    { "FileType qf,helpn,lspinfo nnoremap <silent> <buffer> q :close<CR>" };
    { "FileType man nnoremap <silent> <buffer> q :q!<CR>" };
    { "TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})" };
    { "BufWinEnter * :set formatoptions-=cro" };
    { "FileType qf set nobuflisted" };
  };
  terminal_job = {
    { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber signcolumn=no" };
    { "TermOpen", "*", "startinsert" };
  };
  alpha = {
    { "User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2" };
    { "User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3" };
  };
  git = {
    { "FileType gitcommit setlocal wrap" };
    { "FileType gitcommit setlocal spell" };
  };
  markdown = {
    { "FileType markdown setlocal wrap" };
    { "FileType markdown setlocal spell" };
  };
  }

nvim_create_augroups(autocmds)
