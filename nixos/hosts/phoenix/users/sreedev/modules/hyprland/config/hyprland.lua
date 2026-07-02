local hl = hl

-- Monitors

hl.monitor({
  output = "desc:LG Electronics LG ULTRAFINE 602NTMXGY347",
  mode = "preferred",
  position = "0x0",
  scale = "auto",
  bitdepth = 10,
})

hl.monitor({
  output = "desc:LG Electronics LG ULTRAFINE 602NTRLGY358",
  mode = "preferred",
  position = "auto-right",
  scale = "auto",
  bitdepth = 10,
})

hl.monitor({
  output = "desc:Samsung Display Corp. 0x4177",
  mode = "preferred",
  position = "auto-down",
  scale = "auto",
  bitdepth = 10,
})



hl.monitor({
  output = "desc:Lenovo Group Limited MNE007JA1-3",
  mode = "preferred",
  position = "auto-down",
  scale = "auto",
  bitdepth = 10,
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "1920x0",
  scale = 1,
})

-- Binds
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"))
hl.bind("CTRL + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("SUPER + XF86AudioLowerVolume", hl.dsp.exec_cmd("brightnessctl s 10%-"))
hl.bind("SUPER + XF86AudioRaiseVolume", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("SUPER + CTRL + Escape", hl.dsp.exec_cmd("noctalia ipc call notifications dismissAll"))
hl.bind("SUPER + Space", hl.dsp.exec_cmd("noctalia ipc call notifications dismissAll"))

for i = 1, 12 do
  local key = i <= 9 and tostring(i % 10) or ({ [10] = "0", [11] = "Minus", [12] = "Equal" })[i]
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = "r~" .. i }))
end

for i = 1, 12 do
  local key = i <= 9 and tostring(i % 10) or ({ [10] = "0", [11] = "Minus", [12] = "Equal" })[i]
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = "r~" .. i }))
end

hl.bind("SUPER + Escape", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + Escape", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + mouse_left", hl.dsp.layout("focus l"))
hl.bind("SUPER + mouse_right", hl.dsp.layout("focus r"))
hl.bind("SUPER + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())

hl.bind("SUPER + H", hl.dsp.layout("focus l"))
hl.bind("SUPER + L", hl.dsp.layout("focus r"))

hl.bind("SUPER + J", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + K", hl.dsp.focus({ workspace = "r-1" }))

hl.bind("SUPER + M", hl.dsp.exec_cmd("hyprctl keyword general:layout 'scrolling'"))
hl.bind("SUPER + SHIFT + m", hl.dsp.exec_cmd("hyprctl keyword general:layout 'monocle'"))

hl.bind("SUPER + Tab", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ direction = "left" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "r" }))
hl.bind("SUPER + CTRL + J", hl.dsp.focus({ monitor = "d" }))
hl.bind("SUPER + CTRL + K", hl.dsp.focus({ monitor = "u" }))

hl.bind("SUPER + x", hl.dsp.layout("fit all"))


hl.bind("SUPER + bracketright", hl.dsp.layout("colresize +0.1"))
hl.bind("SUPER + bracketleft", hl.dsp.layout("colresize -0.1"))

hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))

hl.bind("SUPER + CTRL + Space", hl.dsp.exec_cmd("noctalia ipc call lockScreen lock"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("noctalia ipc call controlCenter toggle"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("noctalia ipc call wallpaper toggle"))

hl.bind("SUPER + D", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + Q", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/clipboard/history"))

hl.bind("SUPER + N", hl.dsp.exec_cmd("noctalia ipc call notifications toggleDND"))
hl.bind("SUPER + backslash", hl.dsp.exec_cmd("noctalia ipc call settings toggle"))
hl.bind("SUPER + S", hl.dsp.window.toggle_swallow())
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SUPER + CTRL + S",
  hl.dsp.exec_cmd('grim -o $(hyprctl monitors -j | jq -r \'.[] | select(.focused) | .name\') - | wl-copy'))
hl.bind("SUPER + SHIFT + W",
  hl.dsp.exec_cmd(
    'grim -g "$(hyprctl activewindow -j | jq \'(.at | "\\(.[0]),\\(.[1])"),(.size | "\\(.[0])x\\(.[1])")\' | xargs)" - | wl-copy'))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- autostarts
hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("hyprpm reload -n")
  hl.exec_cmd("clipse -listen")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wlsunset -l 40.7 -L -73.9")
  hl.exec_cmd("xrdb ~/.Xresources")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

-- general
hl.config({
  cursor = {
    no_hardware_cursors = true,
  },
  general = {
    allow_tearing = false,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    gaps_in = 5,
    gaps_out = 10,
    layout = "scrolling",
    resize_on_border = false,
  },
})

hl.config({
  decoration = {
    blur = {
      brightness = 0.8172,
      contrast = 0.8916,
      enabled = true,
      input_methods_ignorealpha = 0.0,
      new_optimizations = true,
      noise = 0.0117,
      passes = 3,
      popups = false,
      popups_ignorealpha = 0.0,
      size = 8,
      special = true,
      vibrancy = 0.1696,
      xray = false,
    },
    shadow = {
      color = "rgba(1a1a1aee)",
      color_inactive = "rgba(1a1a1aff)",
      enabled = true,
      range = 4,
      render_power = 3,
      sharp = false,
    },
  },
})

-- animations
hl.config({
  animations = {
    enabled = true,
  },
})

-- Bezier curves
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("softAcDecel", { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1 } } })
hl.curve("md2", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.2, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "fade" })

-- inputs
hl.config({
  scrolling = {
    column_width = 0.90,
    direction = "right",
    focus_fit_method = 0,
    follow_focus = true,
    follow_min_visible = 0.4,
    fullscreen_on_one_column = true,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    mfact = 0.70
  },
  xwayland = {
    force_zero_scaling = true,
  },
  misc = {
    disable_hyprland_logo = true,
    enable_swallow = true,
    focus_on_activate = false,
    force_default_wallpaper = 0,
    swallow_regex = "^(Alacritty|kitty)$",
    vrr = 0
  },
  input = {
    accel_profile = "adaptive",
    follow_mouse = 1,
    kb_layout = "us,apl",
    kb_model = "",
    kb_options = "ctrl:nocaps,compose:ralt,grp:shifts_toggle",
    kb_rules = "",
    kb_variant = ",dyalog",
    sensitivity = 0,
    tablet = {
      output = "current",
      transform = 2,
    },
    touchpad = {
      clickfinger_behavior = true,
      disable_while_typing = true,
      natural_scroll = true,
    },
  },
})

-- rules
-----------------------
---- LAYER RULES ----
-----------------------

hl.layer_rule({
  name = "vicinae-layer",
  match = { namespace = "vicinae" },
  blur = true,
  dim_around = true,
  ignore_alpha = 0.0,
  no_anim = false,
  animation = "fade",
  blur_popups = true,
  xray = false,
})

hl.layer_rule({
  name = "noctalia-notifications",
  match = { namespace = "noctalia-notifications-.*$" },
  ignore_alpha = 0,
  blur = false,
  blur_popups = false,
})

hl.layer_rule({
  name = "noctalia-background",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
  dim_around = false,
})

hl.layer_rule({
  name = "gtk-layer-shell",
  match = { namespace = "gtk-layer-shell" },
  blur = true,
  ignore_alpha = 0.1,
})

hl.layer_rule({
  name = "cheatsheet",
  match = { namespace = "cheatsheet" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "indicator",
  match = { namespace = "indicator.*" },
  blur = true,
  ignore_alpha = 0.6,
  no_anim = true,
})

hl.layer_rule({
  name = "sideleft",
  match = { namespace = "sideleft.*" },
  animation = "slide left",
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "sideright",
  match = { namespace = "sideright" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "sideright-anim",
  match = { namespace = "sideright.*" },
  animation = "slide right",
})

hl.layer_rule({
  name = "launcher",
  match = { namespace = "launcher" },
  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  name = "overview",
  match = { namespace = "overview" },
  ignore_alpha = 0.6,
  no_anim = true,
  blur = true,
})

hl.layer_rule({
  name = "bar",
  match = { namespace = "bar" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "corner",
  match = { namespace = "corner.*" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "osk",
  match = { namespace = "osk" },
  blur = true,
  ignore_alpha = 0.6,
  no_anim = true,
})

hl.layer_rule({
  name = "dock",
  match = { namespace = "dock" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "shell",
  match = { namespace = "shell:*" },
  blur = true,
  ignore_alpha = 0.6,
})

hl.layer_rule({
  name = "session",
  match = { namespace = "session" },
  blur = true,
})

hl.layer_rule({
  name = "anyrun-noanim",
  match = { namespace = "anyrun" },
  no_anim = true,
})

hl.layer_rule({
  name = "hyprpicker-noanim",
  match = { namespace = "hyprpicker" },
  no_anim = true,
})

hl.layer_rule({
  name = "selection-noanim",
  match = { namespace = "selection" },
  no_anim = true,
})

hl.layer_rule({
  name = "walker-noanim",
  match = { namespace = "walker" },
  no_anim = true,
})

-------------------------
---- WINDOW RULES ----
-------------------------

-- File dialog rules (shared pattern)
local dialog_titles = {
  "^(Choose wallpaper)(.*)$",
  "^(Library)(.*)$",
  "^(Open Folder)(.*)$",
  "^(File Upload)(.*)$",
  "^(Select a File)(.*)$",
  "^(Save As)(.*)$",
  "^(Open File)(.*)$",
}
for _, title in ipairs(dialog_titles) do
  hl.window_rule({
    name = "dialog-" .. title,
    match = { title = title },
    center = true,
    float = true,
    size = "1000 600",
  })
end

hl.window_rule({
  name = "xwaylandvideobridge",
  match = { class = "^(xwaylandvideobridge)$" },
  opacity = "0.0 override",
  no_anim = true,
  no_initial_focus = true,
  max_size = "1 1",
  no_blur = true,
  no_focus = true,
})

hl.window_rule({
  name = "pip-float",
  match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
  float = true,
})

hl.window_rule({
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "firefox-pip",
  match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },
  float = true,
})

hl.window_rule({
  name = "firefox-library",
  match = { class = "^(firefox)$", title = "^(Library)$" },
  float = true,
})

hl.window_rule({
  name = "about-firefox",
  match = { title = "^(About Mozilla Firefox)$" },
  float = true,
})

hl.window_rule({
  name = "pwvucontrol",
  match = { class = "^(com.saivert.pwvucontrol)$" },
  float = true,
  size = "1400 650",
})

hl.window_rule({
  name = "pip-position",
  match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" },
  keep_aspect_ratio = true,
  move = "73% 72%",
  size = "25% 75%",
  float = true,
  pin = true,
})

hl.window_rule({
  name = "steam-tearing",
  match = { class = "(steam_app)" },
  immediate = true,
})

hl.window_rule({
  name = "no-shadow-tiled",
  match = { float = false },
  no_shadow = true,
})

hl.window_rule({
  name = "nsxiv-tile",
  match = { class = "^(Nsxiv)$" },
  tile = true,
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.bind("SUPER + R", function() hl.dsp.submap("resize") end)
hl.define_submap("resize", function()
  hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
end)


hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.gesture({ fingers = 4, direction = "pinch", action = "cursorZoom", zoom_level = 2, mode = "mult" })

require "nixbinds"
