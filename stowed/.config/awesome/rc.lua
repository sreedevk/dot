pcall(require, "luarocks.loader")
pcall(require, "awful.autofocus")
pcall(require, "awful.hotkeys_popup.keys")

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Error handling
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/base.lua")

modkey     = "Mod4"
terminal   = "kitty"
editor     = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Autorun
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("~/.config/polybar/launch.sh")

awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
}

menubar.utils.terminal = terminal
mykeyboardlayout       = awful.widget.keyboardlayout()

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  local names = { "main", "www", "gfx", "slack", "im" }
  local l = awful.layout.suit
  local layouts = { l.spiral, l.spiral, l.spiral, l.spiral, l.spiral }
  awful.tag(names, s, layouts)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
end)

root.buttons(gears.table.join(
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

-- {{{ Key bindings
globalkeys = gears.table.join(
-- help/info
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

  -- tag navigation
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  -- Screenshots
  awful.key(
    { modkey, "Shift" }, "s",
    function()
      awful.spawn("scrot -s " .. os.getenv("HOME") .. "/Pictures/screenshots/")
    end,
    { description = "Screenshot", group = "awesome" }
  ),

  -- Brightness
  awful.key(
    {}, "XF86MonBrightnessUp",
    function() os.execute("brightnessctl set +1%") end,
    { description = "Brightness +", group = "hotkeys" }
  ),

  awful.key(
    {}, "XF86MonBrightnessDown",
    function() os.execute("brightnessctl set 1%-") end,
    { description = "Brightness -", group = "hotkeys" }
  ),

  -- Audio
  awful.key(
    {}, "XF86AudioRaiseVolume",
    function() os.execute("pactl set-sink-volume 0 +5%") end,
    { description = "Volume -", group = "hotkeys" }
  ),
  awful.key(
    {}, "XF86AudioLowerVolume",
    function() os.execute("pactl set-sink-volume 0 -5%") end,
    { description = "Volume +", group = "hotkeys" }
  ),

  awful.key(
    {}, "XF86AudioMute",
    function() os.execute("pactl set-sink-mute 0 toggle") end,
    { description = "Volume Mute", group = "hotkeys" }
  ),

  -- window navigation
  awful.key(
    { modkey }, "j",
    function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }
  ),

  awful.key(
    { modkey }, "k",
    function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }
  ),

  awful.key(
    { modkey, "Shift" }, "j",
    function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }
  ),

  awful.key(
    { modkey, "Shift" }, "k",
    function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }
  ),

  -- screen navigation
  awful.key(
    { modkey, "Control" }, "j",
    function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }
  ),

  awful.key(
    { modkey, "Control" }, "k",
    function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }
  ),

  awful.key(
    { modkey }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),

  -- app launcher
  awful.key(
    { modkey }, "d",
    function() awful.spawn("rofi -show combi -combi-modes 'run,window,ssh' -modes combi") end,
    { description = "open app launcher", group = "launcher" }
  ),

  -- terminal launcher
  awful.key(
    { modkey }, "Return",
    function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }
  ),

  awful.key(
    { modkey }, "KP_Enter",
    function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }
  ),

  -- Awesome Management
  awful.key(
    { modkey, "Shift" }, "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),

  awful.key(
    { modkey, "Control" }, "q",
    awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),

  -- client switcher
  awful.key(
    { modkey }, "Tab",
    function() awful.spawn("rofi -show window") end,
    { description = "Switch Windows", group = "awesome" }
  ),

  -- layout manipulation

  awful.key(
    { modkey }, "l",
    function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }
  ),

  awful.key({ modkey }, "h",
    function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }
  ),

  awful.key({ modkey, "Shift" }, "h",
    function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }
  ),

  awful.key({ modkey, "Shift" }, "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }
  ),

  awful.key({ modkey, "Control" }, "h",
    function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }
  ),

  awful.key(
    { modkey, "Control" }, "l",
    function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }
  ),

  awful.key({ modkey }, "space",
    function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }
  ),
  awful.key(
    { modkey, "Shift" }, "space",
    function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }
  ),

  -- compositor management
  awful.key(
    { modkey }, "p",
    function() os.execute("pkill picom") end,
    { description = "kill picom", group = "awesome" }
  ),

  awful.key(
    { modkey, "Shift" }, "p",
    function() awful.spawn("picom -b") end,
    { description = "start picom", group = "awesome" }
  ),

  -- DND
  awful.key(
    { modkey }, "n",
    function() naughty.toggle() end,
    { description = "pause notifications", group = "awesome" }
  )
)

clientkeys = gears.table.join(
  awful.key(
    { modkey }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }
  ),
  awful.key(
    { modkey, "Shift" }, "q",
    function(c) c:kill() end,
    { description = "close", group = "client" }
  ),

  awful.key(
    { modkey, "Shift" }, "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),

  awful.key(
    { modkey, "Control" }, "Return",
    function(c)
      c:swap(awful.client.getmaster())
    end,
    { description = "move to master", group = "client" }
  ),

  awful.key({ modkey }, "o",
    function(c)
      c:move_to_screen()
    end,
    { description = "move to screen", group = "client" }
  ),

  awful.key({ modkey }, "t",
    function(c)
      c.ontop = not c.ontop
    end,
    { description = "toggle keep on top", group = "client" }
  ),

  awful.key({ modkey }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }
  ),

  awful.key(
    { modkey, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }
  ),

  awful.key(
    { modkey }, "w",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" }
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key(
      { modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),

    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "pavucontrol",
      "xtightvncviewer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "ConfigManager", -- Thunderbird's about:config.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true } },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  { rule = { class = "Firefox" }, properties = { screen = 1, tag = "www" } },
  { rule = { class = "Brave-browser" }, properties = { screen = 1, tag = "www" } },
  { rule = { class = "Slack" }, properties = { screen = 1, tag = "slack" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
