require("joakim.options")
require("joakim.keymap")
require("joakim.lazy")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Make backgrounds transparent
    local groups = {
      "Normal", "NormalFloat", "NormalNC",
      "StatusLine", "StatusLineNC", 
      "TabLine", "TabLineFill", "TabLineSel",
      "SignColumn", "LineNr", "CursorLineNr",
      "VertSplit", "WinSeparator"
    }
    
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})

vim.cmd("colorscheme nightfox")
print("Hello from Joakim")
