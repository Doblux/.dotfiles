vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- 4 espacios = 1 tab
vim.opt.softtabstop = 4 -- 4 espacios = 1 tab en modo insertar
vim.opt.shiftwidth = 4 -- cantidad de espacios para la indentacion al mover lineas de codigo
vim.opt.expandtab = true -- Cuando se presiona la tecla de tabulación, se insertarán 4 espacios en lugar de un solo tabulador.

vim.opt.smartindent = true -- activa la indentación inteligente, el editor ajustará automaticamente la indentacion segun el contexto

vim.opt.wrap = false -- 1 linea larguisima en lugar de varias lineas que pertenecen al mismo renglon

vim.opt.swapfile = false -- Esta opción desactiva la creación de archivos de intercambio (swap files).
vim.opt.backup = false -- Neovim no creará estos archivos de respaldo
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true

vim.opt.hlsearch = false -- Esta opción desactiva el resaltado de las búsquedas realizadas.
vim.opt.incsearch = true -- Esta opción activa la búsqueda incremental (mientras busco se va resaltando)

vim.opt.termguicolors = true

vim.opt.scrolloff = 8 -- Esta opción define el número de líneas que se mantendrán visibles por encima y por debajo del cursor cuando te desplazas por el texto
vim.opt.signcolumn = "yes" -- Esta opción activa la columna de signos, que muestra indicadores para errores, advertencias y otros signos que puedas configurar en tu archivo.
vim.opt.isfname:append("@-@") -- añade el carácter @ al conjunto de caracteres que Neovim considera válidos para nombres de archivo.

vim.opt.updatetime = 50 --  Esta opción determina el tiempo, en milisegundos, que Neovim espera antes de actualizar ciertos eventos, como el autoguardado y la visualización de cambios.

vim.opt.cmdheight = 0
