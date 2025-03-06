puts "Acerca una tarjeta al lector (o escribe algo en el teclado)..."

input = gets.chomp  # Lee una línea de entrada 

# Convierte la entrada (que se asume como número decimal) a hexadecimal
hex_input = input.to_i.to_s(16).upcase.rjust(8, '0').scan(/.{2}/).reverse.join

# Imprime la información leída y la representación hexadecimal
puts "Información leída desde el lector (o teclado): #{input}"
puts "Información en hexadecimal: #{hex_input}"
