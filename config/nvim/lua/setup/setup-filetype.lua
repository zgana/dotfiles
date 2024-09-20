vim.filetype.add({
  pattern = {
    [".*/*.template"] = "yaml",
    [".*/.*.ya?ml.*jinja"] = "yaml",
  },
})

