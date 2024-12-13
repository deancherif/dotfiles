return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      update_focused_file = {
        enable = true,
      },
      filters = {
        dotfiles = true,
      },
    }

    -- Make :bd and :q behave as usual when tree is visible
    vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
      nested = false,
      callback = function(e)
        local tree = require('nvim-tree.api').tree

        -- Nothing to do if tree is not opened
        if not tree.is_visible() then
          return
        end

        -- How many focusable windows do we have? (excluding e.g. incline status window)
        local winCount = 0
        for _, winId in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(winId).focusable then
            winCount = winCount + 1
          end
        end

        -- We want to quit and only one window besides tree is left
        if e.event == 'QuitPre' and winCount == 2 then
          vim.api.nvim_cmd({ cmd = 'qall' }, {})
        end

        -- :bd was probably issued an only tree window is left
        -- Behave as if tree was closed (see `:h :bd`)
        if e.event == 'BufEnter' and winCount == 1 then
          -- Required to avoid "Vim:E444: Cannot close last window"
          vim.defer_fn(function()
            -- close nvim-tree: will go to the last buffer used before closing
            tree.toggle { find_file = true, focus = true }
            -- re-open nivm-tree
            tree.toggle { find_file = true, focus = false }
          end, 10)
        end
      end,
    })
    local nt_api = require 'nvim-tree.api'

    nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
      local tree_winid = nt_api.tree.winid()

      if tree_winid ~= nil then
        vim.api.nvim_set_option_value('statusline', '%t', { win = tree_winid })
      end
    end)

    local nvimTreeFocusOrToggle = function()
      local nvimTree = require 'nvim-tree.api'
      local currentBuf = vim.api.nvim_get_current_buf()
      local currentBufFt = vim.api.nvim_get_option_value('filetype', { buf = currentBuf })
      if currentBufFt == 'NvimTree' then
        nvimTree.tree.toggle()
      else
        nvimTree.tree.focus()
      end
    end

    vim.keymap.set('n', '<leader>e', nvimTreeFocusOrToggle, { desc = 'Open or focus NvimTree' })
  end,
}
