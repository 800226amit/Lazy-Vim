-- =============================================
-- AI Code Completion — Codeium (FREE)
-- Setup (ek baar): :Codeium Auth → browser mein login karo
-- =============================================

return {
  {
    "Exafunction/codeium.nvim",
    -- cmd = "Codeium" ensure karta hai ki :Codeium Auth
    -- plugin load hone se PEHLE bhi kaam kare
    cmd   = "Codeium",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = true,
          key_bindings = {
            -- <C-g>  → puri suggestion accept karo
            accept      = "<C-g>",
            -- <A-w>  → ek word accept karo  (Alt+w)
            accept_word = "<A-w>",
            -- <A-l>  → ek line accept karo  (Alt+l)
            accept_line = "<A-l>",
            -- <A-.>  → next suggestion      (Alt+.)
            next        = "<A-.>",
            -- <A-,>  → prev suggestion      (Alt+,)
            prev        = "<A-,>",
            -- <A-x>  → suggestion hatao     (Alt+x)
            dismiss     = "<A-x>",
          },
        },
      })
    end,
  },
}
