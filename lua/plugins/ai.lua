-- =============================================
-- AI Code Completion
-- Codeium: FREE, sabhi languages, account se activate karo
-- :Codeium Auth  → browser mein login karo (ek baar)
-- =============================================

return {
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        -- Virtual text dikhao (ghost text, Copilot jaisa)
        virtual_text = {
          enabled = true,
          -- Tab se accept karo (cmp ke saath conflict nahi)
          key_bindings = {
            accept        = "<C-g>",   -- suggestion accept karo
            accept_word   = "<C-w>",   -- ek word accept karo
            accept_line   = "<C-l>",   -- ek line accept karo  (insert mode)
            next          = "<C-n>",   -- next suggestion
            prev          = "<C-p>",   -- prev suggestion
            dismiss       = "<C-x>",   -- dismiss
          },
        },
      })
    end,
  },
}
