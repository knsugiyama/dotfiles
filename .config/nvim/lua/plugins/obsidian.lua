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
  hour = tmp_today.hour,
  min = tmp_today.min,
  sec = tmp_today.sec,
  weeknum = ('W' .. os.date '%V'),
  -- zero padding
  z_month = string.format('%02d', tmp_today.month),
  -- zero padding
  z_day = string.format('%02d', tmp_today.day),
  -- zero padding
  z_hour = string.format('%02d', tmp_today.hour),
  -- zero padding
  z_min = string.format('%02d', tmp_today.min),
  -- zero padding
  z_sec = string.format('%02d', tmp_today.sec),
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

    preferred_link_style = 'wiki',
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
      subdir = '91_Templates/911_Nvim_Templates',
      date_format = '%Y%m%d',
      time_format = '%H%M%S',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {
        today = function()
          local year = today.year
          local month = today.z_month
          local day = today.z_day
          return (year .. '-' .. month .. '-' .. day)
        end,
        tomorrow = function()
          local tmp = os.date('*t', os.time() + day_sec)
          local year = tmp.year
          local month = string.format('%02d', tmp.month)
          local day = string.format('%02d', tmp.day)
          return (year .. '-' .. month .. '-' .. day)
        end,
        yesterday = function()
          local tmp = os.date('*t', os.time() - day_sec)
          local year = tmp.year
          local month = string.format('%02d', tmp.month)
          local day = string.format('%02d', tmp.day)
          return (year .. '-' .. month .. '-' .. day)
        end,
        this_week = function()
          local year = today.year
          local weeknum = today.weeknum
          return (year .. '-' .. weeknum)
        end,
        -- YYYYMMDDHHMMSS
        uid = function()
          local year = today.year
          local month = today.z_month
          local day = today.z_day
          local hour = today.z_hour
          local min = today.z_min
          local sec = today.z_sec
          return (year .. month .. day .. hour .. min .. sec)
        end,
      },
    },

    -- Default save location for newly daily notes
    daily_notes = {
      folder = '03_Personal Reports/01_Daily Notes',
      -- date_format = '%Y年%m月%d日',
      -- NOTE: Should without `templates` folder
      template = 'Daily Notes template.md',
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
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

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = false, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
      external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = 'ObsidianRefText' },
      highlight_text = { hl_group = 'ObsidianHighlightText' },
      tags = { hl_group = 'ObsidianTag' },
      block_ids = { hl_group = 'ObsidianBlockID' },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },

    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = 'zz_Files', -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format('![%s](%s)', path.name, path)
      end,
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      if title ~= nil then
        return title
      else
        local year = today.year
        local month = today.z_month
        local day = today.z_day
        local hour = today.z_hour
        local min = today.z_min
        local sec = today.z_sec
        return (year .. month .. day .. hour .. min .. sec)
      end
    end,
  },
}
