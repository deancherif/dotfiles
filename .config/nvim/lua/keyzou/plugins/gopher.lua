return {
	"olexsmir/gopher.nvim",
	ft = "go",
	config = function(_, opts)
		require("gopher").setup(opts)

		vim.keymap.set("n", "<leader>gie", "<cmd>GoIfErr<CR>")

		vim.keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>")
		vim.keymap.set("n", "<leader>gst", "<cmd>GoTagAdd toml<CR>")
	end,
	build = function()
		vim.cmd([[silent! GoInstallDeps]])
	end,
}
