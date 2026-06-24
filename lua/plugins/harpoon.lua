-- =============================================
-- Harpoon 2 - Instant file jumping (no mouse needed)
-- Mark files with <leader>ha, jump with <C-1>..<C-4>
-- =============================================

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Telescope extension for harpoon list
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({ results = file_paths }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      -- Expose telescope picker for keymaps
      _G._harpoon_telescope = toggle_telescope
    end,
  },
}
