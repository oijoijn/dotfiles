-- lua/tree.lua
local tree = {}

local uv = vim.loop

local function basename(p)
  -- vim.fs.basename があればそれを使う
  if vim.fs and vim.fs.basename then
    return vim.fs.basename(p)
  end
  -- 互換用
  p = (p:gsub("/+$", ""))
  return p:match("([^/]+)$") or p
end

local function joinpath(a, b)
  if a:sub(-1) == "/" then
    return a .. b
  end
  return a .. "/" .. b
end

local function open_float_buf(title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype = "treeview"

  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = title or " Project Structure ",
    title_pos = "center",
  })

  local function close_win()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q", close_win, { buffer = buf, silent = true, nowait = true })
  vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, silent = true, nowait = true })

  return buf, win
end

local function scandir_children(dirpath)
  local handle, err = uv.fs_scandir(dirpath)
  if not handle then
    return nil, nil, err
  end

  local dirs, files = {}, {}
  while true do
    local name, t = uv.fs_scandir_next(handle)
    if not name then
      break
    end
    if t == "directory" then
      table.insert(dirs, name)
    else
      -- file / link / unknown はファイル扱い（必要なら分岐可能）
      table.insert(files, name)
    end
  end

  table.sort(dirs, function(a, b) return a:lower() < b:lower() end)
  table.sort(files, function(a, b) return a:lower() < b:lower() end)

  return dirs, files, nil
end

local function build_tree_lines(opts)
  opts = opts or {}

  -- env を優先（従来の TREE_* を踏襲）
  local limit = tonumber(vim.env.TREE_LIMIT) or opts.limit or 5
  local max_depth = tonumber(vim.env.TREE_DEPTH) or opts.max_depth or 2
  local root = vim.env.TREE_ROOT or opts.root or uv.cwd()

  -- 相対指定 "." の場合も cwd を基準にする
  if root == "." then
    root = uv.cwd()
  end

  local lines = {}
  lines[#lines + 1] = (basename(root) or "root") .. "/"

  local function walk(dirpath, prefix, depth)
    if depth > max_depth then
      return
    end

    local dirs, files, err = scandir_children(dirpath)
    if err then
      lines[#lines + 1] = prefix .. "└── [permission denied]"
      return
    end

    -- dirs は全表示、files は先頭 limit のみ
    local shown = {}
    for _, d in ipairs(dirs) do
      shown[#shown + 1] = { name = d, is_dir = true }
    end
    for i = 1, math.min(limit, #files) do
      shown[#shown + 1] = { name = files[i], is_dir = false }
    end

    for i, e in ipairs(shown) do
      local last = (i == #shown)
      local branch = last and "└── " or "├── "
      local name = e.name .. (e.is_dir and "/" or "")
      lines[#lines + 1] = prefix .. branch .. name

      if e.is_dir then
        local next_prefix = prefix .. (last and "    " or "│   ")
        walk(joinpath(dirpath, e.name), next_prefix, depth + 1)
      end
    end

    local extra = #files - limit
    if extra > 0 then
      lines[#lines + 1] = prefix .. "└── … (" .. extra .. " more files)"
    end
  end

  walk(root, "", 1)
  return lines
end

function tree.open_tree_float(opts)
  local buf = open_float_buf(" Project Structure ")
  local lines = build_tree_lines(opts)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
end

return tree
