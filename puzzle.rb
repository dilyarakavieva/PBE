puts "Acerca una tarjeta al lector (o escribe algo en el teclado)..."

input = gets.chomp  # Lee una línea de entrada 

# Convierte la entrada (que se asume como número decimal) a hexadecimal
decimal_value = input.to_i  # Convierte la entrada a un número entero decimal
hex_input = decimal_value.to_s(16).upcase.rjust(8, '0')  # Convierte a hexadecimal y asegura 8 caracteres
hex_input = hex_input.scan(/.{2}/).reverse.join  # Invierte el orden de los bytes

# Imprime la información leída y la representación hexadecimal
puts "Información leída desde el lector (o teclado): #{input}"
puts "Información en hexadecimal: #{hex_input}"
