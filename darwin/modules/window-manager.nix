{
	pkgs,
	...
}:
{
	services.yabai = {
		enable = true;
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
		enable = true;
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

			ctrl + cmd - h : yabai -m window west --resize right:-20:0 2> /dev/null || yabai -m window --resize right:-20:0
			ctrl + cmd - j : yabai -m window north --resize bottom:0:20 2> /dev/null || yabai -m window --resize bottom:0:20
			ctrl + cmd - k : yabai -m window south --resize top:0:-20 2> /dev/null || yabai -m window --resize top:0:-20
			ctrl + cmd - l : yabai -m window east --resize left:20:0 2> /dev/null || yabai -m window --resize left:20:0

			ctrl + alt - f : yabai -m window --grid 1:1:0:0:1:1

			# float / unfloat window and center on screen
			alt - f : yabai -m window --toggle float;\
								yabai -m window --grid 1:1:0:0:1:1

			alt - r : yabai -m space --rotate 90

			alt - m : yabai -m space --mirror y-axis
		'';
	};

	# services.sketchybar = {
	# 	enable = true;
	# 	package = pkgs.sketchybar;
	# 	config = /* bash */ ''
	# 		#!/usr/bin/env bash
	#
	# 		# Initialize sketchybar
	# 		sketchybar --bar \
	# 		height=32 \
	# 		position=top \
	# 		padding_left=10 \
	# 		padding_right=10 \
	# 		color=0xff1e1e2e \
	# 		blur_radius=0
	#
	# 		# Default values
	# 		sketchybar --default \
	# 		icon.font="JetBrainsMono Nerd Font:Bold:24.0" \
	# 		icon.color=0xffffffff \
	# 		label.font="JetBrainsMono Nerd Font:Bold:24.0" \
	# 		label.color=0xffffffff \
	# 		padding_left=5 \
	# 		padding_right=5
	#
	# 		# Clock item
	# 		sketchybar --add item clock right \
	# 		--set clock \
	# 		update_freq=1 \
	# 		script="echo \"%d/%m %H:%M\""
	#
	# 		# Battery item
	# 		sketchybar --add item battery right \
	# 		--set battery \
	# 		update_freq=120 \
	# 		script="sketchybar --set \$NAME label=\"$(pmset -g batt | grep -Eo '\d+%')\""
	#
	# 		# CPU usage item
	# 		sketchybar --add item cpu right \
	# 		--set cpu \
	# 		update_freq=2 \
	# 		script="sketchybar --set \$NAME label=\"$(top -l 1 | grep -o '[0-9.]* idle' | cut -d' ' -f1 | awk '{print 100-$1\"%\"}')\""
	#
	# 		# Start sketchybar
	# 		sketchybar --update
	# 	'';
	# };
}
