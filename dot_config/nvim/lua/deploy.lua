local function deploy()
	local os = require("os")
	local f = io.open(vim.fn.getcwd() .. "/.mapping.json", "r")

	if f == nil then
		print("No config file provided")
		return
	end

	local config = vim.json.decode(f:read("*all"))
	f:close()
	local current_file = vim.fn.expand("%:p")

	if config.auto_save then
		vim.api.nvim_create_autocmd("BufWritePost", { pattern = "*", callback = deploy, once = true })
	end

	for _, value in pairs(config.mapping) do
		if string.match(current_file, value.local_path) then
			local deploy_path = current_file:gsub(value.local_path, config.root_path .. value.remote_path)
			local command = string.format(
				"sshpass -p %s scp -P %s %s %s@%s:%s",
				config.password,
				config.port,
				current_file,
				config.user,
				config.ip,
				deploy_path
			)

			os.execute(command)
			print("File uploaded to" .. deploy_path)
			return
		end
	end
	print("Can't find mapping")
end

vim.keymap.set("n", "<leader>uf", deploy)
