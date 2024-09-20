if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    if has('macunix')
        GuiFont Monaco Nerd Font Mono:h13
    else
        GuiFont Hack Nerd Font:h10
    endif
endif

if exists(':GuiTabline')
    GuiTabline 0
endif

if exists(':GuiRenderFontAttr')
    GuiRenderFontAttr 0
endif
