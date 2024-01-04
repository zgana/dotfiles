local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rules({

  -- Lua
  Rule("( ", " ", {"lua", "rust"}),
  Rule("[ ", " ", {"lua", "rust"}),
  Rule("{ ", " ", {"lua", "rust"}),

  -- TeX / LaTeX
  Rule("$", "$", {"tex", "latex"}),

})
