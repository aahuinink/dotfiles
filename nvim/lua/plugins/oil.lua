-- In an oil trash view (<Leader>ot or g\), restore the item under the cursor into
-- Neovim's current working directory (:pwd), keeping its original file name.
local function restore_to_cwd()
  if not vim.api.nvim_buf_get_name(0):match "^oil%-trash://" then
    return vim.notify("Quick restore only works in an oil trash view", vim.log.levels.WARN)
  end
  -- Restoring re-renders every oil buffer, which would throw away unsaved oil edits
  for _, bufnr in ipairs(require("oil.view").get_all_buffers()) do
    if vim.bo[bufnr].modified then
      return vim.notify("Save or discard your pending oil edits first", vim.log.levels.WARN)
    end
  end

  local entry = require("oil").get_cursor_entry()
  local info = entry and entry.meta and entry.meta.trash_info
  if not info then
    return vim.notify("No trashed item under the cursor", vim.log.levels.WARN)
  end

  local dest = vim.fs.joinpath(vim.fn.getcwd(), vim.fs.basename(info.original_path))
  if vim.uv.fs_lstat(dest) then
    return vim.notify("Not restoring: " .. dest .. " already exists", vim.log.levels.ERROR)
  end

  -- Same move oil does for a trash -> files restore (falls back to copy+delete across devices)
  require("oil.fs").recursive_move(
    entry.type,
    info.trash_file,
    dest,
    vim.schedule_wrap(function(err)
      if err then
        return vim.notify("Restore failed: " .. err, vim.log.levels.ERROR)
      end
      vim.uv.fs_unlink(info.info_file)
      vim.notify("Restored " .. dest)
      -- Refresh the trash view and any oil buffer showing the destination folder
      require("oil.view").rerender_all_oil_buffers { refetch = true }
    end)
  )
end

return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      -- Centered float sized like the Lazy/Mason windows (80% of the editor)
      float = {
        max_width = 0.8,
        max_height = 0.8,
        border = "rounded",
      },
      keymaps = {
        ["<Leader>or"] = { restore_to_cwd, mode = "n", desc = "Restore trashed item to cwd" },
      },
    },
  },
}
