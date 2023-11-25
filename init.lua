-- enter command-line window
--vim.api.nvim_set_keymap('n', 'qs', 'q:', { noremap = true })
local keymap = vim.keymap
local map = vim.keymap.set

-- command-line history
map('c', '<C-p>', '<Up>', { desc = "Up" })
map('c', '<C-n>', '<Down>', { desc = "Down" })

map({'n', 'v'}, 's', ':', { desc = "Command line" })
map({'n', 'o', 'v'}, 'c', 'k', { desc = "Up" })
map({'n', 'o', 'v'}, 't', 'j', { desc = "Down" })
map({'n', 'o', 'v'}, 'n', 'l', { desc = "Right" })
map({'n', 'o'}, 'N', 'L', { desc = "Screen top" })
map({'n', 'o'}, 'C', 'N', { desc = "Find previous" })
map({'n', 'o'}, 'T', 'n', { desc = "Find next" })
map({'n', 'o'}, 'l', 't', { desc = "'Til" })
map({'n', 'o'}, 'L', 'T', { desc = "Back 'til" })
map({'n', 'o'}, ':', 'S', { desc = "Substitute line" })
map({'n', 'o'}, ';', 's', { desc = "Substitute" })
map({'n', 'o'}, 'S', ';', { desc = "Repeat l/L/f/F" })

map('n', 'K', 'C', { desc = "Change to EOL" })
map('n', 'k', 'c', { desc = "Change" })
map('n', 'J', 'K', { desc = "Help" })
map('n', 'j', 'J', { desc = "Join lines" })
map('n', '<S-F1>', 'K', { desc = "Help" })

-- Easy window navigation
map('', '<C-h>', '<C-w>h', { desc = "Window left" })
map('', '<C-t>', '<C-w>j', { desc = "Window down" })
map('', '<C-c>', '<C-w>k', { desc = "Window up" })
map('', '<C-n>', '<C-w>l', { desc = "Window right" })

-- disable f1
map('i', '<F1>', '<nop>')
map('n', '<F1>', '<nop>')

-- Insert a line without entering insert mode
map('n', '<CR>', 'o<Esc>', { desc = "Line below - no insert" })
map('n', '<S-Enter>', 'O<Esc>', { desc = "Line above - no insert" })

-- Code navigation
map('n', '<C-.>', 'gd', { desc = "Go to definition" })
map('n', '<C-,>', '<C-O>', { desc = "Go back" })

require("starter.core")
require("starter.lazy")

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config{
  float={border=_border}
}

require('lspconfig.ui.windows').default_options = {
  border = _border
}

-- workaround for error restoring session with auto-session
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})
