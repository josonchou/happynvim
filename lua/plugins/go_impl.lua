return {
  {
    "venomlab/goimpl.nvim",
    tag = "0.1.0",
    config = function()
      local goimpl = require("goimpl")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "golang", "go" },
        callback = function()
          vim.keymap.set("n", "<leader>cI", function()
            if goimpl.is_go() then
              goimpl.impl()
            end
          end, {
            desc = "实现接口",
          })
        end,
      })
    end,
  },
}
