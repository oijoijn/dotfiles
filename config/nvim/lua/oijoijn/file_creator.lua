local creator = {}

function creator.file(path)
    local file_name = vim.fn.input("file name: ")
    -- if exit
    if vim.fn.filereadable(path) == 1 then
        -- 既にある場合はそのまま開くだけ
        print("File already exists: " .. file_name)
    else
        vim.cmd("edit " .. vim.fn.fnameescape(file_name))
    end
end

return creator
