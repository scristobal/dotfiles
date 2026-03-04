-- Automatically reloads Neovim buffers when files change on disk
return {
    'diogo464/hotreload.nvim',
    opts = {}  -- Uses fs_event watchers by default
}
