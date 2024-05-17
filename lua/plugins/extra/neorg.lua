return {
  "nvim-neorg/neorg",
  dependencies = { "vhyrro/luarocks.nvim" },
  version = "*",
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icons = {
              heading = {
                icons = { "🌺", "🌸", "🌹", "💞", "🌼", "💓", "💘", "🌒" }
              },
              list = {
                icons = { "♥️" }
              }
            },

          }
        },
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              local leader = keybinds.leader
              keybinds.remap("norg", "n", "<Leader>a", "za")
            end,
          }
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/hikari.d/notes/hikari-norg",
            },
            default_workspace = "notes",
          },
        },
      },
    }

    vim.wo.foldlevel = 0
    vim.wo.conceallevel = 2
  end,
}
--   config = function()
--     require("neorg").setup {
--       load = {
--         ["core.defaults"] = {},  -- Loads default behaviour
--         ["core.concealer"] = {}, -- Adds pretty icons to your documents
--         ["core.dirman"] = {      -- Manages Neorg workspaces
--           config = {
--             workspaces = {
--               notes = "~/notes",
--             },
--           },
--         },
--       },
--     }
--   end,
