require('auto-save').setup({
  enabled = true,
  execution_message = 'AutoSave: saved at ' .. vim.fn.strftime('%H:%M:%S'),
  trigger_events = {
    immediate_save = {},                     -- vim events that trigger an immediate save
    defer_save = { "InsertLeave" },          -- vim events that trigger a deferred save (saves after `debounce_delay`)
    cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
  },
  write_all_buffers = false,
})
