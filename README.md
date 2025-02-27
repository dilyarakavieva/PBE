# Lector de Tarjetas y Conversión de Entrada a Hexadecimal

Este proyecto es un script simple en **Ruby** que simula la lectura de una tarjeta o entrada desde el teclado, y convierte esa entrada en **decimal** a su correspondiente representación en **hexadecimal**. 
Este tipo de código podría ser útil para leer de tarjetas o códigos numéricos.

## Descripción

El script le pide al usuario que ingrese un número que simula la lectura de una tarjeta (o un número desde el teclado) y convierte esa entrada de **decimal** a **hexadecimal**. El programa también muestra cómo invertir los bytes de la cadena hexadecimal para ajustarse a ciertos formatos de tarjetas. 

Este código puede ser utilizado en sistemas que requieren leer identificadores o códigos desde un lector de tarjetas y convertirlos a un formato hexadecimal, como en el caso de algunos sistemas de control de acceso o identificación.

## Características

- Convierte un número decimal (simulando un código de tarjeta) a hexadecimal.
- Invierte el orden de los bytes del valor hexadecimal para cumplir con el formato de algunos lectores de tarjetas.Porque en nuestro caso ha convertido el codigo incorrecto y tuvimos que "invertir el orden".
- Muestra tanto la entrada en decimal como en hexadecimal.

## El codigo:

-- Lee lo que el lector de tarjetas emula como entrada de teclado
-input = gets.chomp  # Lee una línea de entrada y elimina el salto de línea al final
-- Convierte la entrada (que se asume como número decimal) a hexadecimal
-decimal_value = input.to_i  # Convierte la entrada a un número entero decimal
-hex_input = decimal_value.to_s(16).upcase.rjust(8, '0')  # Convierte a hexadecimal y asegur>
-hex_input = hex_input.scan(/.{2}/).reverse.join
-- Imprime la información leída y la representación hexadecimal
-puts "Información leída desde el lector (o teclado): #{input}"
-puts "Información en hexadecimal: #{hex_input}"


## El uso:

-- Antes del todo tienes que asegurarte que en tu ordenador esta cargado lenguaje ruby:
ruby -v
-- Hay que crear el fichero .rb para guardar el codigo:
nano puzzle.rb
-- Ejecutamos el codigo 
sudo ruby puzzle.rb

## Ejemplo del uso:

Acerca una tarjeta al lector (o escribe algo en el teclado)...
0067385523
Información leída desde el lector (o teclado): 0067385523
Información en hexadecimal: B3380404
