return{
	"GCBallesteros/jupytext.nvim",
	config = true,
	layz=false,
	opts = {
		style = "markdown",
		output_extension = "md",
		force_ft = "markdown",
	},
	config = function(_, opts)
		require('jupytext').setup(opts)
	end,
}
