vim.filetype.add({
  pattern = {
    -- jinja templates
    [".*/.*%.md.*%.jinja"] = "markdown",
    [".*/.*%.rst.*%.jinja"] = "rst",
    [".*/.*%.py.*%.jinja"] = "python",
    [".*/.*%.toml.*%.jinja"] = "toml",
    [".*/.*%.ya?ml.*%.jinja"] = "yaml",

    -- databricks
    [".databrickscfg"] = "dosini",

    -- e.g. cloudformation
    [".*/*%.template"] = "yaml",

  },
})

