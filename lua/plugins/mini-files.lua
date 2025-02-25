return {
    "echasnovski/mini.files",
    version = false,
    lazy = false,
    opts = { use_as_default_explorer = true },
    config = function()
        require('mini.files').setup()
        vim.keymap.set('n', '<Leader>e', function()
            require('mini.files').open()
        end, { desc = 'Open mini.files explorer' })
    end
}
