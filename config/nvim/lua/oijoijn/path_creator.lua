local creator = {}

function creator.path()
    -- 1. パスの取得・加工処理
    local file_path = vim.fn.expand('%:p')
    if file_path == '' or file_path == nil then
        print("Error: No file name.")
        return
    end

    local launch_dir = vim.g.nvim_launch_dir

    local final_path
    if launch_dir and file_path:find(launch_dir, 1, true) == 1 then
        final_path = string.sub(file_path, #launch_dir + 2)
    else
        final_path = vim.fn.expand('%:t')
    end

    -- 2. バッファの先頭に行を挿入
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { final_path })

    -- 3. 挿入後にカーソルを先頭へ移動して gcc を実行
    vim.schedule(function()
        -- 挿入されたのは先頭(0行目)なので、カーソルを先頭(gg)へ移動
        vim.cmd("normal! gg")

        -- gcc を実行
        local key = vim.api.nvim_replace_termcodes("gcc", true, false, true)
        vim.api.nvim_feedkeys(key, "m", false)
    end)
end

return creator
