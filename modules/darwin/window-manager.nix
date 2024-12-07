{
pkgs,
...
}:
{
	services.yabai = {
		enable = false;
		package = pkgs.yabai;
		enableScriptingAddition = true;
		config = {
			focus_follows_mouse          = "autoraise";
			mouse_follows_focus          = "off";
			window_placement             = "second_child";
			window_opacity               = "off";
			window_opacity_duration      = "0.0";
			window_topmost               = "on";
			window_shadow                = "float";
			active_window_opacity        = "1.0";
			normal_window_opacity        = "1.0";
			split_ratio                  = "0.50";
			auto_balance                 = "on";
			mouse_modifier               = "fn";
			mouse_action1                = "move";
			mouse_action2                = "resize";
			layout                       = "bsp";
			top_padding                  = 4;
			bottom_padding               = 4;
			left_padding                 = 4;
			right_padding                = 4;
			window_gap                   = 4;
		};

		extraConfig = ''
				# rules
				yabai -m rule --add app='System Preferences' manage=off
		'';
	};

	services.skhd = {
		enable = false;
		package = pkgs.skhd;
		skhdConfig = ''
			# focus window
			alt - h : yabai -m window --focus west || yabai -m display --focus west
			alt - j : yabai -m window --focus south || yabai -m display --focus south
			alt - k : yabai -m window --focus north || yabai -m display --focus north
			alt - l : yabai -m window --focus east || yabai -m display --focus east

			# swap windows
			alt + shift - h : yabai -m window --swap west || $(yabai -m window --display west; yabai -m display --focus west)
			alt + shift - j : yabai -m window --swap south || $(yabai -m window --display south; yabai -m display --focus south)
			alt + shift - k : yabai -m window --swap north || $(yabai -m window --display north; yabai -m display --focus north)
			alt + shift - l : yabai -m window --swap east || $(yabai -m window --display east; yabai -m display --focus east)

		  alt + ctrl - h : yabai -m window west --resize right:-20:0 2> /dev/null || yabai -m window --resize right:-20:0
		  alt + ctrl - j : yabai -m window north --resize bottom:0:20 2> /dev/null || yabai -m window --resize bottom:0:20
		  alt + ctrl - k : yabai -m window south --resize top:0:-20 2> /dev/null || yabai -m window --resize top:0:-20
		  alt + ctrl - l : yabai -m window east --resize left:20:0 2> /dev/null || yabai -m window --resize left:20:0

			ctrl + alt - f : yabai -m window --grid 1:1:0:0:1:1

			# float / unfloat window and center on screen
			alt - f : yabai -m window --toggle float;\
								yabai -m window --grid 1:1:0:0:1:1

      alt - z : yabai -m window --toggle zoom-fullscreen

			alt - r : yabai -m space --rotate 90

			alt - m : yabai -m space --mirror y-axis
		'';
	};

	services.sketchybar = {
		enable = false;
		package = pkgs.sketchybar;
		config = /* bash */ ''
			#!/usr/bin/env bash

			export FONT="JetBrainsMono Nerd Font"

      yabai -m config menubar_opacity 0.0 # disable menubar
      yabai -m config external_bar all:22:0

			sketchybar --bar height=36 \
				blur_radius=100 \
				position=top \
				padding_left=10 \
				padding_right=10 \
				color=0x15000010 \
				shadow=on

			sketchybar --default updates=when_shown \
				drawing=on \
				icon.font="$FONT:Regular:18.0" \
				icon.color=0xffffffff \
				label.font="$FONT:Light:18.0" \
				label.color=0xffffffff \
				label.padding_left=4 \
				label.padding_right=4 \
				icon.padding_left=4 \
				icon.padding_right=4


			# --- RIGHT --- #

			# datetime
			sketchybar --add item clock right \
				--set clock update_freq=1 \
				--set clock script="sketchybar --set clock label=\"$(date '+%a %d %b %H:%M')\"" \
				--set clock background.padding_right=10

			# Add battery percentage
			sketchybar --add item battery right \
				--set battery icon="" \
				--set battery update_freq=120 \
				--set battery script="sketchybar --set battery label=\"$(pmset -g batt | grep -Eo '\d+%')\"" \
				--set battery background.padding_left=10


			# --- LEFT --- #
			#
			# Apple logo
			sketchybar --add item apple.logo left \
			--set apple.logo icon="󰀵" \
			--set apple.logo icon.font="$FONT:Bold:26.0" \
			--set apple.logo background.padding_left=10 \
			--set apple.logo background.padding_right=0

			# Add the currently running app
			sketchybar --add item front_app left \
				--set front_app script="sketchybar --set front_app label=\$(osascript -e 'tell application \"System Events\" to name of first application process whose frontmost is true')" \
				--set front_app icon.drawing=off \
				--set front_app background.padding_left=0 \
				--set front_app background.padding_right=10 \
				--subscribe front_app front_app_switched

			sketchybar --update
		'';
	};
}
