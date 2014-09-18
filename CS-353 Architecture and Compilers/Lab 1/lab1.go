package main

import (
	"strconv"
	"bytes"
	"github.com/mattn/go-gtk/gtk"
	"github.com/mattn/go-gtk/glib"
	)

func reverse(input string) string {
    runes := []rune(input)
    input_size := len(input)
    for index, value := range input {
		runes[input_size-1-index] = value
	}
    return string(runes)
}

func lowers(input string) string {
	var buffer bytes.Buffer
	for _, value := range input {
		if (value>64 && value<91) {
			value = value + 32
		}
		buffer.WriteString(string(value))
	}
	return buffer.String()
}

func caps(input string) string {
	var buffer bytes.Buffer
	for _, value := range input {
		if (value>96 && value<123) {
			value = value - 32
		}
		buffer.WriteString(string(value))
	}
	return buffer.String()
}

func string_to_int(input string, base_string string) int {
	integer := 0
	base := char_to_int(base_string)
    for _, value := range input {
		integer = integer * base
		current_int := char_to_int(string(value))
		integer = integer + current_int
	}
	return integer
}

func int_to_string(integer int, base int) string {
	var buffer bytes.Buffer
	for integer != 0 {
		int_mod_base := integer%base
		next_char := ""
		if (int_mod_base > 9) {
			next_char = int_to_char(int_mod_base)
		} else {
			next_char = strconv.Itoa(int_mod_base)
		}
		buffer.WriteString(next_char)
		integer = integer / base
	}
	number := reverse(buffer.String())
	for i := 0; i < len(number); i++ {
		if number[0] == 48 {
			number = number[1:]
		} else {
			break
		}
	}
	return number
}

func int_to_char(input int) string {
	return string(input+87)
}

func char_to_int(input string) int {
	char := int32(input[0])
	if (char>64 && char<91) {
		char = char + 32
	}
	if (char>96 && char<123) {
		return int(char - 87)
	} else {
		value, _ := strconv.Atoi(input)
		return value
	}
}

func main() {
	gtk.Init(nil)
	window := gtk.NewWindow(gtk.WINDOW_TOPLEVEL)
    window.SetPosition(gtk.WIN_POS_CENTER)
    window.SetTitle("Lab 1")
    window.Connect("destroy",
				   func(ctx *glib.CallbackContext) {
						gtk.MainQuit()
				   },
	"Window destroyed")
	
	all_boxes := gtk.NewVBox(false, 0)
	base_conversion_box := gtk.NewHBox(false, 0)
	
	left_label_vbox := gtk.NewVBox(false, 5)
	number_entry_label := gtk.NewLabel("Input:")
	output_number_label := gtk.NewLabel("Output:")
	left_label_vbox.PackStart(number_entry_label, true, true, 0)
	left_label_vbox.PackStart(output_number_label, true, true, 0)
	
	left_input_vbox := gtk.NewVBox(false, 5)
	number_entry := gtk.NewEntry()
	output_number := gtk.NewEntry()
	left_input_vbox.PackStart(number_entry, true, true, 0)
	left_input_vbox.PackStart(output_number, true, true, 0)
	
	middle_label_vbox := gtk.NewVBox(false, 5)
	base_entry_label := gtk.NewLabel("Input base:")
	output_number_base10_label := gtk.NewLabel("Output (base 10):")
	middle_label_vbox.PackStart(base_entry_label, true, true, 0)
	middle_label_vbox.PackStart(output_number_base10_label, true, true, 0)
	
	middle_input_vbox := gtk.NewVBox(false, 5)
	base_entry := gtk.NewEntry()
	output_number_base10 := gtk.NewEntry()
	middle_input_vbox.PackStart(base_entry, true, true, 0)
	middle_input_vbox.PackStart(output_number_base10, true, true, 0)
	
	right_box :=  gtk.NewVBox(false, 5)
	output_base_box := gtk.NewHBox(false, 5)
	base_output_entry_label := gtk.NewLabel("Output base:")
	base_output_entry := gtk.NewEntry()
	base_output_entry.SetWidthChars(4)
	output_base_box.PackStart(base_output_entry_label, true, true, 0)
	output_base_box.PackStart(base_output_entry, true, true, 0)
	calculate_button := gtk.NewButtonWithLabel("Calculate")
	right_box.PackStart(output_base_box, true, true, 0)
	right_box.PackStart(calculate_button, true, true, 0)
	
	base_conversion_box.PackStart(left_label_vbox, true, true, 5)
	base_conversion_box.PackStart(left_input_vbox, true, true, 5)
	base_conversion_box.PackStart(middle_label_vbox, true, true, 5)
	base_conversion_box.PackStart(middle_input_vbox, true, true, 5)
	base_conversion_box.PackStart(right_box, true, true, 5)

	calculate_button.Clicked(func() {
		starting_number := number_entry.GetText()
		starting_base := base_entry.GetText()
		integer := string_to_int(starting_number, starting_base)
		output_number_base10.SetText(strconv.Itoa(integer))
		converted_number := int_to_string(integer, char_to_int(base_output_entry.GetText()))
		output_number.SetText(converted_number)
	})

	string_conversion_box := gtk.NewHBox(false, 5)
	input_label := gtk.NewLabel("Input string:")
	input_string := gtk.NewEntry()
	caps_label := gtk.NewLabel("Captial:")
	all_caps := gtk.NewEntry()
	lower_label := gtk.NewLabel("Lower case:")
	all_lower :=  gtk.NewEntry()
	convert_button := gtk.NewButtonWithLabel("Convert")
	string_conversion_box.PackStart(input_label, true, true, 0)
	string_conversion_box.PackStart(input_string, true, true, 0)
	string_conversion_box.PackStart(caps_label, true, true, 0)
	string_conversion_box.PackStart(all_caps, true, true, 0)
	string_conversion_box.PackStart(lower_label, true, true, 0)
	string_conversion_box.PackStart(all_lower, true, true, 0)
	string_conversion_box.PackStart(convert_button, true, true, 0)
	
	convert_button.Clicked(func() {
		string_to_convert := input_string.GetText()
		all_caps.SetText(caps(string_to_convert))
		all_lower.SetText(lowers(string_to_convert))
	})

	all_boxes.PackStart(base_conversion_box, true, true, 0)
	all_boxes.PackStart(gtk.NewHSeparator(), true, true, 10)
	all_boxes.PackStart(string_conversion_box, true, true, 0)
	window.Add(all_boxes)
    window.ShowAll()
    gtk.Main()
}
