vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
-- resize
vim.keymap.set("n", "<C-Right>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +5<CR>")
vim.keymap.set("n", "<C-Up>", ":resize -5<CR>")
-- move cursor to window
vim.keymap.set("n", "<A-Right>", "<C-w>l")
vim.keymap.set("n", "<A-Left>", "<C-w>h")
vim.keymap.set("n", "<A-Up>", "<C-w>k")
vim.keymap.set("n", "<A-Down>", "<C-w>j")




local comment_function = function ()
    local extension = vim.fn.expand('%:e')
    if extension == "c" or extension == "cpp" or extension == "hpp" or extension == "h" then
        vim.keymap.set("v", "<leader>c", [[:s:^://<CR>:noh<CR>]] )
        vim.keymap.set("v", "<leader>C", [[:s:^//<CR>:noh<CR>]] )
    elseif extension == "lua" then
        vim.keymap.set("v", "<leader>c", [[:s:^:--<CR>:noh<CR>]] )
        vim.keymap.set("v", "<leader>C", [[:s:^--<CR>:noh<CR>]] )
    elseif extension == "sh" or extension == "Makefile" then
        vim.keymap.set("v", "<leader>c", [[:s:^:#<CR>:noh<CR>]] )
        vim.keymap.set("v", "<leader>C", [[:s:^#<CR>:noh<CR>]] )
    elseif extension == "asm" then
        vim.keymap.set("v", "<leader>c", [[:s:^:;<CR>:noh<CR>]] )
        vim.keymap.set("v", "<leader>C", [[:s:^;<CR>:noh<CR>]] )
    end
end
comment_function()
