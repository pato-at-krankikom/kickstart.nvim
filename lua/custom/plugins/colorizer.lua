return {
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        tailwind = true,
        css_fn = true, -- enables rgb()/rgba()/hsl()/hsla() function coloring
      },
    },
  },
}
