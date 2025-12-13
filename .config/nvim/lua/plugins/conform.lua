-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  event = "VeryLazy",   -- load on VeryLazy (or change to BufReadPost if you prefer)
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },

  -- Options (same as your original, but without LazyVim checks)
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        python = { "isort", "black" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier", "markdownlint", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint", "markdown-toc" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "gofmt" },
        java = { "google-java-format" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- Examples (commented):
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
    }
    return opts
  end,

  -- Config: setup conform with opts and create convenience commands/autocmds
  config = function(_, opts)
    local ok, conform = pcall(require, "conform")
    if not ok then
      vim.notify("conform.nvim not available", vim.log.levels.WARN)
      return
    end

    conform.setup(opts)

    -- Optional: Create a :Format command that uses conform
    vim.api.nvim_create_user_command("Format", function(ctx)
      -- if a range is provided, format the range in visual mode; otherwise full buffer
      if ctx.range ~= 0 then
        local bufnr = vim.api.nvim_get_current_buf()
        conform.format({ bufnr = bufnr })
      else
        conform.format({ bufnr = vim.api.nvim_get_current_buf() })
      end
    end, { range = true, desc = "Format buffer (conform.nvim)" })

    -- Optional: auto-format on save (uncomment to enable)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        -- use sync formatting to ensure file is formatted before write
        conform.format({ bufnr = bufnr, async = false })
      end,
    })

    -- Optional: a helper to get available formatters for the current buffer
    vim.api.nvim_create_user_command("ConformList", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local ok2, list = pcall(function() return conform.list_formatters(bufnr) end)
      if not ok2 then
        vim.notify("Failed to list conform formatters", vim.log.levels.ERROR)
        return
      end
      if vim.tbl_isempty(list) then
        print("No conform formatters available for this buffer")
        return
      end
      for _, info in ipairs(list) do
        print(info.name)
      end
    end, { desc = "List conform formatters for current buffer" })
  end,
}

