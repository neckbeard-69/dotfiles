return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"nvimdev/lspsaga.nvim",
				config = function()
					require("lspsaga").setup({
						symbol_in_winbar = {
							enable = false,
						},
						code_action = {
							show_server_name = true,
						},
						lightbulb = {
							enable = false,
						},
					})
					vim.keymap.set("n", "<leader>te", ":Lspsaga term_toggle<CR>")
				end,
			},
			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("neodev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")
			local servers = {
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},

				lua_ls = {
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},
				emmet_language_server = {
					filetypes = { "html", "php", "templ", "jsx", "tsx" },
				},
				bashls = true,
				rust_analyzer = true,
				svelte = true,
				templ = true,
				taplo = true,
				zls = true,
				pyright = true,
				mojo = { manual_install = true },
				ts_ls = {
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				},
				-- Enabled biome formatting, turn off all the other ones generally
				biome = true,

				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				html = true,
				cssls = true,

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							-- schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				ols = {},

				ocamllsp = {
					manual_install = true,
					cmd = { "dune", "exec", "ocamllsp" },
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
						syntaxDocumentation = { enable = true },
					},

					get_language_id = function(_, lang)
						print("LANG:", lang)
						local map = {
							["ocaml.mlx"] = "ocaml",
						}
						return map[lang] or lang
					end,

					filetypes = {
						"ocaml",
						"ocaml.interface",
						"ocaml.menhir",
						"ocaml.cram",
						"ocaml.mlx",
						"ocaml.ocamllex",
						"reason",
					},

					server_capabilities = {
						semanticTokensProvider = false,
					},

					-- TODO: Check if i still need the filtypes stuff i had before
				},
				intelephense = true,
				gleam = {
					manual_install = true,
				},
				clangd = {
					-- cmd = { "clangd", unpack(require("custom.clangd").flags) },
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					filetypes = { "c", "cpp" },
				},

				tailwindcss = {
					init_options = {
						userLanguages = {
							elixir = "phoenix-heex",
							eruby = "erb",
							heex = "phoenix-heex",
						},
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									[[class: "([^"]*)]],
								},
							},
							-- filetypes_include = { "heex" },
							-- init_options = {
							--   userLanguages = {
							--     elixir = "html-eex",
							--     eelixir = "html-eex",
							--     heex = "html-eex",
							--   },
							-- },
						},
					},
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"delve",
				"html-lsp",
				"css-lsp",

				-- "tailwind-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed, auto_install = true })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", { buffer = 0 })

					vim.keymap.set("n", "<space>rn", ":Lspsaga rename<CR>", { buffer = 0 })
					vim.keymap.set("n", "<space>ca", ":Lspsaga code_action<CR>", { buffer = 0 })
					vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			-- Autoformatting Setup
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					blade = { "blade-formatter" },
					javascript = { "prettier" },
					typesript = { "prettier" },
				},
			})

			conform.formatters.injected = {
				options = {
					ignore_errors = false,
					lang_to_formatters = {
						sql = { "sleek" },
					},
				},
			}

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					-- local filename = vim.fn.expand "%:p"

					local extension = vim.fn.expand("%:e")
					if extension == "mlx" then
						return
					end

					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

			vim.keymap.set("", "<leader>l", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })
		end,
	},
}