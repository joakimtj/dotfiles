return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- Load LSP when you open a file
        config = function()
            -- Disable semantic tokens globally
            vim.lsp.handlers['textDocument/semanticTokens/full'] = function() return nil end
            vim.lsp.handlers['textDocument/semanticTokens/range'] = function() return nil end

            -- Configure diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                underline = false,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Create capabilities without semantic tokens
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.semanticTokens = {
                dynamicRegistration = false,
                tokenTypes = {},
                tokenModifiers = {},
                formats = {},
                requests = {
                    range = false,
                    full = false
                }
            }

            -- Setup lua_ls with some basic settings
            require('lspconfig').lua_ls.setup({
                capabilities = capabilities,
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
            
            -- Setup jdtls
            -- require('lspconfig').jdtls.setup({
                -- cmd = {
                    -- 'java',
                    -- '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    -- '-Dosgi.bundles.defaultStartLevel=4',
                    -- '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    -- '-Dlog.protocol=true',
                    -- '-Dlog.level=ALL',
                    -- '-Xmx1g',
                    -- '--add-modules=ALL-SYSTEM',
                    -- '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    -- '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                    -- '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
                    -- '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_win',
                    -- '-data', vim.fn.expand('~') .. '/.jdtls-workspace'
                -- },
                -- filetypes = { 'java' },
                -- root_dir = function(fname)
                    -- return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
                -- end,
                -- capabilities = capabilities,
                -- settings = {
                    -- java = {
                        -- configuration = {
                            -- updateBuildConfiguration = "automatic",
                        -- },
                        -- signatureHelp = { enabled = true },
                        -- contentProvider = { preferred = 'fernflower' },
                        -- completion = {
                            -- favoriteStaticMembers = {},
                            -- filteredTypes = {
                                -- "com.sun.*",
                                -- "io.micrometer.shaded.*",
                                -- "java.awt.*",
                                -- "jdk.*", "sun.*",
                            -- },
                        -- },
                        -- sources = {
                            -- organizeImports = {
                                -- starThreshold = 9999,
                                -- staticStarThreshold = 9999,
                            -- },
                        -- },
                        -- codeGeneration = {
                            -- toString = {
                                -- template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            -- },
                            -- useBlocks = true,
                        -- },
                        -- -- Explicitly disable semantic tokens
                        -- semanticTokens = {
                            -- enabled = false
                        -- }
                    -- },
                -- },
                -- -- Ensure semantic tokens are disabled when client attaches
                -- on_attach = function(client, bufnr)
                    -- client.server_capabilities.semanticTokensProvider = nil
                -- end
            -- })
            
            -- Set up key mappings for LSP functionality
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local buffer = args.buf
                    
                    -- Disable semantic tokens for this client
                    if client then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                    
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    
                    -- Set up buffer-local keymaps
                    local opts = { buffer = buffer, noremap = true, silent = true }
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
                end,
            })
        end
    }
}