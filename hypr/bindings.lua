-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- macOS-style Chrome tab switching: SUPER + ALT + Left/Right (Cmd+Option+arrows).
-- Apple keyboards: the right Option key is <RALT> = AltGr (MOD5), so both modifier
-- variants are bound (left-hand and right-hand Cmd+Option both work).
-- In Chrome this sends CTRL+Page_Up/Page_Down (previous/next tab); in any other
-- app it keeps Omarchy's default behavior (move window into group).
local function chrome_tab(direction, fallback)
  return function()
    local window = hl.get_active_window()
    if window then
      local class = window.class or ""
      local initial = window.initial_class or ""
      if class:match("chrome") or initial:match("chrome") then
        hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = direction, state = "down" }))
        hl.timer(function()
          hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL", key = direction, state = "up" }))
        end, { timeout = 50, type = "oneshot" })
        return
      end
    end
    hl.dispatch(fallback)
  end
end

hl.unbind("SUPER + ALT + LEFT") -- was: Move window to group on left
hl.unbind("SUPER + ALT + RIGHT") -- was: Move window to group on right
-- Apple keyboards: the right Option key is <RALT> = AltGr (MOD5), not plain Alt,
-- so bind both modifier variants (left hand: Cmd+Option, right hand: right
-- Cmd + right Option).
o.bind("SUPER + ALT + LEFT", "Chrome: previous tab (else: move window to group on left)", chrome_tab("Page_Up", hl.dsp.window.move({ into_group = "l" })))
o.bind("SUPER + ALT + RIGHT", "Chrome: next tab (else: move window to group on right)", chrome_tab("Page_Down", hl.dsp.window.move({ into_group = "r" })))
o.bind("SUPER + MOD5 + LEFT", "Chrome: previous tab (else: move window to group on left)", chrome_tab("Page_Up", hl.dsp.window.move({ into_group = "l" })))
o.bind("SUPER + MOD5 + RIGHT", "Chrome: next tab (else: move window to group on right)", chrome_tab("Page_Down", hl.dsp.window.move({ into_group = "r" })))
