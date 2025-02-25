return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    config = function()
        vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)
        vim.keymap.set("n", "<space>fg", require('telescope.builtin').git_files)
        vim.keymap.set("n", "<space>fc", require('telescope.builtin').grep_string)
    end
}

