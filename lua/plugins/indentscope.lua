return {
  'echasnovski/mini.indentscope',
  version = false,
  config = function()
    require('mini.indentscope').setup({
      draw = {
        delay = 100,
        animation = function() return 0 end
      },
      symbol = "│"
    })
    
    -- Create autocmd to set highlight after colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
          fg = "#9079ab",
          blend = 10
        })
      end
    })
    
    -- Also set it immediately
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
      fg = "#9079ab",
      blend = 10
    })
  end
}