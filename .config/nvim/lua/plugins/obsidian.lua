local day_sec = 86400
local month_sec = 2592000
local year_sec = 31536000
local tmp_today = os.date('*t', os.time())

-- Summarizing various elements of today's date
---@type table
local today = {
  year = tmp_today.year,
  month = tmp_today.month,
  day = tmp_today.day,
  -- zero padding
  z_month = string.format('%02d', tmp_today.month),
  -- zero padding
  z_day = string.format('%02d', tmp_today.day),
}

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },

  cmd = {
    'ObsidianBacklinks',
    'ObsidianCheck',
    'ObsidianFollowLink',
    'ObsidianLink',
    'ObsidianLinkNew',
    'ObsidianNew',
    'ObsidianOpen',
    'ObsidianPasteImg',
    'ObsidianQuickSwitch',
    'ObsidianRename',
    'ObsidianSearch',
    'ObsidianTemplate',
    'ObsidianToday',
    'ObsidianTomorrow',
    'ObsidianWorkspace',
    'ObsidianYesterday',
  },

  opts = {
    workspaces = {
      {
        name = 'obsidian',
        path = '~/vaults/obsidian',
      },
    },
    -- Default save location for newly created notes
    notes_subdir = '03_Personal Reports/10_Fleeting Note',
    -- see below for full list of options 👇
    log_level = vim.log.levels.INFO,

    use_advanced_uri = true,
    finder = 'telescope.nvim',

    -- Sort search results by "path", "modified", "accessed", or "created".
    sort_by = 'modified',
    sort_reversed = true,

    -- Open note in current buffer
    open_notes_in = 'current',
    yaml_parser = 'native',

    -- Optional, for templates (see below).
    templates = {
      subdir = '91_Templates',
      date_format = '%Y年%m月%d日',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {
        -- YYYYMMDD
        today = function()
          local year = today.year
          local month = today.z_month
          local day = today.z_day
          return (year .. month .. day)
        end,
        -- Tomorrow
        tomorrow = function()
          local tmp = os.date('*t', os.time() + day_sec)
          local year = tmp.year
          local month = string.format('%02d', tmp.month)
          local day = string.format('%02d', tmp.day)
          return (year .. '年' .. month .. '月' .. day .. '日')
        end,
        -- Yesterday
        yesterday = function()
          local tmp = os.date('*t', os.time() - day_sec)
          local year = tmp.year
          local month = string.format('%02d', tmp.month)
          local day = string.format('%02d', tmp.day)
          return (year .. '年' .. month .. '月' .. day .. '日')
        end,
      },
    },

    -- Default save location for newly daily notes
    daily_notes = {
      folder = '03_Personal Reports/01_Daily Notes',
      date_format = '%Y年%m月%d日',
      -- NOTE: Should without `templates` folder
      template = 'Daily Notes template.md',
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      use_path_only = true,
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
    },
  },
}
