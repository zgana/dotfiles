local cslike = function(name)
  return {name, version = false, lazy = false, priority = 1000}
end

return {
  cslike("ellisonleao/gruvbox.nvim"),
  cslike("sainnhe/everforest"),
  cslike("rebelot/kanagawa.nvim"),
  cslike("savq/melange-nvim"),

  -- catpuccin rename catppuccin on the fly so it isn't called "nvim"
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
