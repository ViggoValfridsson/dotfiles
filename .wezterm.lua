local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Padding
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- Font
config.font_size = 11
config.font = wezterm.font "JetBrainsMono NF"
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Colors
config.color_scheme = "Catppuccin Mocha"
config.default_cursor_style = "SteadyBar"
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.75,
}

-- Window
config.window_decorations = "NONE"
-- config.enable_wayland = false

-- Tab bar
config.enable_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

-- Misc
config.scrollback_lines = 10000
config.audible_bell = "Disabled"

-- Tables
config.key_tables = {
  resize_mode = {
    { key = "h",      action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "j",      action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { key = "k",      action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    { key = "l",      action = wezterm.action.AdjustPaneSize { "Right", 5 } },

    -- exit
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  },
  split_mode = {
    -- splits
    { key = "h",      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "v",      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "h",      mods = "CTRL|SHIFT",                                                     action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "v",      mods = "CTRL|SHIFT",                                                     action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

    -- exit
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  }
}


-- Keybindings
config.keys = {
  -- Pane navigation (hjkl)
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down" },
  { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },

  -- Split panes
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateKeyTable {
      name = "split_mode",
      one_shot = true,
    }
  },

  -- Close pane
  { key = "q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- Pane navigation
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateKeyTable {
      name = "resize_mode",
      one_shot = false,
    }
  },
  { key = "z", mods = "CTRL|SHIFT", action = "TogglePaneZoomState" },
  { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.RotatePanes "Clockwise", },
  { key = "m", mods = "CTRL|SHIFT", action = wezterm.action.PaneSelect { mode = "SwapWithActive", }, },

  -- Tabs
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  {
    key = "r",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.ShowTabNavigator, pane)

      -- after switching, prompt rename
      window:perform_action(
        wezterm.action.PromptInputLine {
          description = "Rename tab:",
          action = wezterm.action_callback(function(win, _, line)
            if line then
              win:active_tab():set_title(line)
            end
          end),
        },
        pane
      )
    end),
  },
  -- CTRL SHIFT x closes tab by default
  -- Tabs navigation
  { key = "j",      mods = "CTRL|SHIFT|ALT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "k",      mods = "CTRL|SHIFT|ALT", action = wezterm.action.ActivateTabRelative(1) },
  { key = "phys:1", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(0) },
  { key = "phys:2", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(1) },
  { key = "phys:3", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(2) },
  { key = "phys:4", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(3) },
  { key = "phys:5", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(4) },
  { key = "phys:6", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(5) },
  { key = "phys:7", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(6) },
  { key = "phys:8", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(7) },
  { key = "phys:9", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(8) },
  { key = "phys:0", mods = "CTRL|SHIFT",     action = wezterm.action.ActivateTab(9) },
  { key = "e",      mods = "CTRL|SHIFT",     action = wezterm.action.ShowTabNavigator }
}

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
  position = "bottom",
  max_width = 32,
  padding = {
    left = 1,
    right = 1,
    tabs = {
      left = 1,
      right = 1,
    },
  },
  separator = {
    space = 1,
    left_icon = wezterm.nerdfonts.fa_long_arrow_right,
    right_icon = wezterm.nerdfonts.fa_long_arrow_left,
    field_icon = wezterm.nerdfonts.indent_line,
  },
  modules = {
    workspace = {
      enabled = true,
      icon = wezterm.nerdfonts.cod_window,
      color = 8,
    },
    zoom = {
      enabled = true,
      icon = wezterm.nerdfonts.md_fullscreen,
      color = 4,
    },
    tabs = {
      active_tab_fg = 9,
      active_tab_bg = "#8aadf4",
      inactive_tab_fg = 8,
      inactive_tab_bg = "transparent",
      new_tab_fg = 8,
      new_tab_bg = "transparent",
    },
    hostname = {
      enabled = true,
      icon = wezterm.nerdfonts.cod_server,
      color = 8,
    },
    clock = {
      enabled = true,
      icon = wezterm.nerdfonts.md_calendar_clock,
      format = "%Y-%m-%d %H:%M",
      color = 5,
    },
    -- Disabled modules
    username = {
      enabled = false,
      icon = wezterm.nerdfonts.fa_user,
      color = 6,
    },
    pane = {
      enabled = false,
      icon = wezterm.nerdfonts.cod_multiple_windows,
      color = 7,
    },
    leader = {
      enabled = false,
      icon = wezterm.nerdfonts.oct_rocket,
      color = 2,
    },
    cwd = {
      enabled = false,
      icon = wezterm.nerdfonts.oct_file_directory,
      color = 7,
    },
    ssh = {
      enabled = false,
      icon = wezterm.nerdfonts.md_ssh,
      color = 5,
    },
    spotify = {
      enabled = false,
      icon = wezterm.nerdfonts.fa_spotify,
      color = 3,
      max_width = 64,
      throttle = 15,
    },
  },
})

return config
