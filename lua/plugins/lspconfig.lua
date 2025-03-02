return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- Load LSP when you open a file
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                underline = false,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            })
            -- Setup lua_ls with some basic settings
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' } -- Recognize 'vim' global
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true), -- Adds all nvim runtime files to lua workspace
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })
            require('lspconfig').clangd.setup{}
            require('lspconfig').texlab.setup{}
        end
    }
}

