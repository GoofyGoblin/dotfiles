-- Mason tool installer for formatters, linters, and other tools
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = {
      -- Formatters
      "stylua", -- Lua formatter
      "shfmt", -- Shell formatter
      "prettier", -- Web formatter (HTML, CSS, JS, TS, JSON, etc.)
      "black", -- Python formatter
      "isort", -- Python import sorter
      "rustfmt", -- Rust formatter
      "clang-format", -- C/C++ formatter
      
      -- Linters
      "eslint_d", -- JavaScript/TypeScript linter
      "flake8", -- Python linter
      "shellcheck", -- Shell script linter
      "luacheck", -- Lua linter
      "markdownlint", -- Markdown linter
      
      -- Language servers (backup if not installed via mason-lspconfig)
      "lua-language-server",
      "pyright",
      "rust-analyzer",
      "typescript-language-server",
      "html-lsp",
      "css-lsp",
      "bash-language-server",
      "json-lsp",
      "clangd",
      
      -- Additional tools
      "codelldb", -- Debugger for Rust/C++
      "debugpy", -- Python debugger
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
    debounce_hours = 5, -- at least 5 hours between attempts to install/update
  },
}