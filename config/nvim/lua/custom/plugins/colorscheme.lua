local cslike = function(name)
  return {name, version = false, lazy = false, priority = 1000}
end

return {
  cslike("ellisonleao/gruvbox.nvim"),
  cslike("sainnhe/everforest"),
  cslike("rebelot/kanagawa.nvim"),
  cslike("savq/melange-nvim"),
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
