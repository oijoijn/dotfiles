return {
    'akinsho/toggleterm.nvim',
    config = function()
        local toggleterm = require('toggleterm')
        local Terminal = require('toggleterm.terminal').Terminal

        toggleterm.setup({
            -- 基本設定は変更なし
            size = 13,
            open_mapping = false,
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = false,
            direction = 'horizontal',
            close_on_exit = true,
            persist_mode = false,
            float_opts = {
                border = 'curved',
                winblend = 3,
            },
            on_open = function()
                vim.api.nvim_command("startinsert")
            end,
        })

        -- 複数のターミナルインスタンスを作成
        -- 水平分割ターミナル1（デフォルト）
        local horizontal_termt = Terminal:new({
            direction = 'horizontal',
            id = 0, -- 明示的にIDを指定
        })

        -- キーマッピング設定
        vim.keymap.set({'n', 't'}, '<C-\\>', function() horizontal_termt:toggle() end,
            { desc = 'Toggle Terminal t' })
    end,
}
