-- Monitor configuration
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1.0,
})

-- Fallback monitor configuration
-- hl.monitor({
--   output = "eDP-1",
--   mode = "1920x1080@60",
--   position = "0x0",
--   scale = 1.0,
-- })


-------------------
--- MY PROGRAMS ---
-------------------

local terminal = "kitty --class OnTop"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local reloadWaybar = "pkill waybar; waybar"
local snip = "snip"
local dropdownTerminal = "kitty --class dropdown-terminal"
local vimwikiTerminal = "kitty --class vimwiki-terminal --title Notes -d ~/Work/VimWiki/ nvim ~/Work/VimWiki/index.wiki"


-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")

  hl.exec_cmd(
    "systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_RUNTIME_DIR XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
  )

  hl.exec_cmd(
    "systemctl --user start --no-block import-private-data.service"
  )
end)

-------------------------------
--- ENVIRONMENT VARIABLES ---
-------------------------------

hl.env("GTK_THEME", "Adwaita")
hl.env("GTK_ICON_THEME", "Adwaita")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")


-----------------------
--- LOOK AND FEEL ---
-----------------------

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,
    border_size = 1,

    col = {
      active_border = {
        colors = {
          "rgba(33ccffee)",
          "rgba(00ff99ee)",
        },
        angle = 45,
      },
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 8,
    rounding_power = 2.0,

    active_opacity = 1.0,
    inactive_opacity = 0.7,

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})


---------------------
--- ANIMATIONS ---
---------------------

hl.curve("myBezier", {
  type = "bezier",
  points = {
    { 0.05, 0.9 },
    { 0.1,  1.05 },
  },
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 7,
  bezier = "myBezier",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 7,
  bezier = "default",
  style = "popin 80%",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 10,
  bezier = "default",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 8,
  bezier = "default",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 7,
  bezier = "default",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 6,
  bezier = "default",
})


-------------------
--- DWINDLE ---
-------------------

hl.config({
  dwindle = {
    preserve_split = true,
  },
})


-----------------
--- MASTER ---
-----------------

hl.config({
  master = {
    new_status = "master",
  },
})


-------------
--- MISC ---
-------------

hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },
})


--------------
--- INPUT ---
--------------

hl.config({
  input = {
    kb_layout = "de",
    kb_variant = "",
    kb_model = "",
    kb_options = "custom:rctrl_mod4",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = 0,

    repeat_rate = 35,
    repeat_delay = 200,

    touchpad = {
      natural_scroll = false,
    },
  },
})


--------------
--- CURSOR ---
--------------

hl.config({
  cursor = {
    inactive_timeout = 30,
    no_hardware_cursors = true,
  },
})


---------------------
--- DEVICES ---
---------------------

-- Disable every touchpad regardless of its hardware-specific name.
-- udev identifies touchpads reliably, while Hyprland needs the normalized device name.
local function disable_touchpads()
  local events = io.popen("printf '%s\\n' /sys/class/input/event*")

  if events == nil then
    return
  end

  for event in events:lines() do
    local properties = io.popen(
      "udevadm info --query=property --path=" .. event .. " 2>/dev/null"
    )

    if properties ~= nil then
      local is_touchpad = false

      for line in properties:lines() do
        if line == "ID_INPUT_TOUCHPAD=1" then
          is_touchpad = true
          break
        end
      end

      properties:close()

      if is_touchpad then
        local name_file = io.open(event .. "/device/name", "r")

        if name_file ~= nil then
          local name = name_file:read("*l")
          name_file:close()

          if name ~= nil then
            name = name:lower():gsub("[ ,]", "-")

            hl.device({
              name = name,
              enabled = false,
            })
          end
        end
      end
    end
  end

  events:close()
end

disable_touchpads()

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})


---------------------
--- KEYBINDINGS ---
---------------------

local mainMod = "SUPER"

-- Launch applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(reloadWaybar))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(snip))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exit())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap windows with mainMod + H/J/K/L
hl.bind(mainMod .. " + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.window.swap({ direction = "right" }))

-- wofi - Password menu
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/wofi/passmenu.sh"))
-- wofi - One-time password menu
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/wofi/otpmenu.sh"))
-- wofi - Open the radio menu.
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/wofi/radio.sh"))
-- rofimoji - Emoji picker
hl.bind(
  mainMod .. " + period", hl.dsp.exec_cmd("rofimoji --selector wofi --action clipboard"))

-- brightnesctl - control screen brightness
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl set 5%+"),
  { repeating = true, locked = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl set 5%-"),
  { repeating = true, locked = true }
)

-- Toggle the dropdown terminal.
hl.bind("F12", function()
  local workspace = hl.get_workspace("special:dropdown")

  if workspace == nil then
    hl.dispatch(hl.dsp.exec_cmd(dropdownTerminal))
  else
    hl.dispatch(hl.dsp.workspace.toggle_special("dropdown"))
  end
end)

-- Toggle VimWiki Notes dropdown
hl.bind(mainMod .. " + N", function()
  local workspace = hl.get_workspace("special:vimwiki")

  if workspace == nil then
    hl.dispatch(hl.dsp.exec_cmd(vimwikiTerminal))
  else
    hl.dispatch(hl.dsp.workspace.toggle_special("vimwiki"))
  end
end)


-------------------
--- WORKSPACES ---
-------------------

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

---------------------
--- VOLUME CONTROL ---
---------------------

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true }
)

-- Move and resize windows with mainMod + LMB/RMB
hl.bind(
  mainMod .. " + mouse:272",
  hl.dsp.window.drag(),
  { mouse = true }
)

hl.bind(
  mainMod .. " + mouse:273",
  hl.dsp.window.resize(),
  { mouse = true }
)


---------------------
--- WINDOW RESIZE ---
---------------------

-- Resize the active window with mainMod + SHIFT + arrow keys.
hl.bind(
  mainMod .. " + SHIFT + left",
  hl.dsp.window.resize({ x = -20, y = 0, relative = true })
)

hl.bind(
  mainMod .. " + SHIFT + right",
  hl.dsp.window.resize({ x = 20, y = 0, relative = true })
)

hl.bind(
  mainMod .. " + SHIFT + up",
  hl.dsp.window.resize({ x = 0, y = -20, relative = true })
)

hl.bind(
  mainMod .. " + SHIFT + down",
  hl.dsp.window.resize({ x = 0, y = 20, relative = true })
)


-------------------------
--- WINDOW RULES ---
-------------------------

hl.window_rule({
  match = {
    class = ".*",
  },
  suppress_event = "maximize",
})
-- Configure the dropdown terminal.
hl.window_rule({
  name = "dropdown-terminal",
  match = {
    class = "^dropdown-terminal$",
  },
  workspace = "special:dropdown",
  float = true,
  size = { "(monitor_w*0.6)", "(monitor_h*0.7)" },
  center = true,
})
-- Configure the VimWiki dropdown window.
hl.window_rule({
  name = "vimwiki-terminal",
  match = {
    class = "^vimwiki-terminal$",
  },
  workspace = "special:vimwiki",
  float = true,
  size = { "(monitor_w*0.6)", "(monitor_h*0.7)" },
  center = true,
})


-----------------
--- SWALLOWING ---
-----------------

hl.config({
  misc = {
    enable_swallow = true,
    swallow_regex = "^OnTop$",
  },
})
