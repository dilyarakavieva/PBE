# Función para leer los datos y almacenarlos en un hash
def leer_identificadores_y_nombres(archivo)
  datos = {}
  File.open(archivo, 'r') do |file|
    file.each_line do |line|
      next if line.strip.empty?  # Ignorar líneas vacías

      # Dividimos la línea por la coma y comprobamos si se generaron exactamente 2 elementos
      partes = line.strip.split(',')
      if partes.length == 2
        identificador, nombre = partes
        datos[identificador.strip] = nombre.strip  # Almacenamos el identificador y el nombre
      else
        puts "Formato incorrecto en la línea: '#{line.strip}'"
      end
    end
  end
  datos
end

# Función para comparar el UID con los datos
def comparar_identificadores(input, datos)
  # Compara el identificador directamente

  if datos.key?(input)
    hex_input = input.to_i.to_s(16).upcase.rjust(8, '0').scan(/.{2}/).reverse.join
    hex_input1 = input.to_i.to_s(16).upcase.rjust(8, '0');

    puts "Información en hexadecimal(Little Endian): #{hex_input} pertenece a #{datos[input]}"
    puts "Información en hexadecimal sin girar(Big Endian): #{hex_input1} pertenece a #{datos[input]}"
  else
    puts "No se encontró ninguna coincidencia para el identificador #{input}."
  end
end

# Main

puts "Acerca una tarjeta al lector (o escribe algo en el teclado)..."

# Leer los identificadores y nombres del archivo
archivo = 'datos.txt'  # Nombre del archivo donde están los identificadores y nombres
datos = leer_identificadores_y_nombres(archivo)

input = gets.strip

# Comparar la entrada con los identificadores en el archivo
comparar_identificadores(input, datos)

