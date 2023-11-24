local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rules({

  -- Lua
  Rule("( ", " ", {"lua"}),
  Rule("[ ", " ", {"lua"}),
  Rule("{ ", " ", {"lua"}),

  -- TeX / LaTeX
  Rule("$", "$", {"tex", "latex"}),

})
