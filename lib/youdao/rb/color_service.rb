class ColorService
  def self.add_color_to_string(str)
    start = "                    "
    head_attr = "\e[1m\e[4m\e[38;5;123m"
    reset_attr = "\e[0m"

    colored_str = ""
    colored_str += start
    str_arr = str.split "."
    if first = str_arr.shift
      colored_str += (head_attr + first + "." + reset_attr + str_arr.shift + reset_attr)
    else
      colored_str += str
    end
  end
end
