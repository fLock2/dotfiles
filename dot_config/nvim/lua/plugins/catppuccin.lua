return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- add your options that should be passed to the setup() function here
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
