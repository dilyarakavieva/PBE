def procesar_uid(input)

hex_input = input.to_i.to_s(16).upcase.rjust(8, '0').scan(/.{2}/).reverse.join
hex_input1 = input.to_i.to_s(16).upcase.rjust(8, '0');
puts "Información leída desde el lector (o teclado): #{input}"
puts "Información en hexadecimal(Little Endian): #{hex_input}"
puts "Información en hexadecimal sin girar(Big Endian): #{hex_input1}"

end

