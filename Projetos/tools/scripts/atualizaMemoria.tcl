# Load Quartus Prime Tcl Package
package require  ::quartus::insystem_memory_edit

puts stdout ""
puts stdout "Funciona somente com o quartus_stp"
puts stdout ""

set DEV_NAME "@1: 5CE(BA4|FA4) (0x02B050DD)"

set MIF "C:/Users/vitor/Desktop/Z01-Coldzera/Projetos/G-Computador/bin/hack/testeLED.mif"

set JTAG "USB-Blaster \[USB-0\]"

begin_memory_edit -hardware_name $JTAG -device_name $DEV_NAME

update_content_to_memory_from_file -instance_index 0 -mem_file_path $MIF -mem_file_type "mif"

end_memory_edit;
