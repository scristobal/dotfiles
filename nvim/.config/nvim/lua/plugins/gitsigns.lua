-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = false,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git change', buffer = bufnr })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange', buffer = bufnr })

        -- Actions
        -- visual mode
        vim.keymap.set('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git stage hunk', buffer = bufnr })
        vim.keymap.set('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git reset hunk', buffer = bufnr })

        -- normal mode
        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git stage hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git reset hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git stage buffer', buffer = bufnr })
        vim.keymap.set('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'Git undo stage hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git reset buffer', buffer = bufnr })
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git preview hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { desc = 'Git blame line', buffer = bufnr })
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git diff against index', buffer = bufnr })
        vim.keymap.set('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Git diff against last commit', buffer = bufnr })

        -- Toggles
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show blame line', buffer = bufnr })
        vim.keymap.set('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'Toggle git show deleted', buffer = bufnr })
      end,
    },
  },
}
