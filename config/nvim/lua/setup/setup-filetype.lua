vim.filetype.add({
  pattern = {
    -- jinja templates
    [".*/.*py.*jinja"] = "python",
    [".*/.*toml.*jinja"] = "toml",
    [".*/.*.ya?ml.*jinja"] = "yaml",

    -- e.g. cloudformation
    [".*/*.template"] = "yaml",
  },
})

