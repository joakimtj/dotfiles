return {
  'echasnovski/mini.tabline',
  version = false,
  config = function()
    require('mini.tabline').setup({
      -- Set to `true` to show file icons (requires 'nvim-tree/nvim-web-devicons')
      show_icons = true,
      
      -- Highlight tabs which have unsaved changes
      highlight_unsaved = true,
    })
  end
}