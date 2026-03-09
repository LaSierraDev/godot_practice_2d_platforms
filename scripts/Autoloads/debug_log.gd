extends Node

enum LogType { INFO, WARNING, ERROR, SUCCESS }

func log_rich(message: String, log_type: LogType = LogType.INFO) -> void:
	var color: Color = Color.WHITE
	var icon: String = "•"
	
	match log_type:
		LogType.INFO:
			color = Color(0.5, 0.8, 1.0) # lightblue
			icon = "ℹ"
		LogType.WARNING:
			color = Color.YELLOW
			icon = "⚠"
		LogType.ERROR:
			color = Color.RED
			icon = "⛔"
		LogType.SUCCESS:
			color = Color.GREEN
			icon = "✔"
	
	var hex_color: String = color.to_html() 
	print_rich("[color=%s]%s %s %s[/color]" % [hex_color, icon, message, icon])
