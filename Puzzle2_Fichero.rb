#trabajamos con fichero 
require_relative 'Puzzle_Leer_Fichero.rb'
require 'io/console'

def leer_uid
 puts "Introduce el UID de la tarjeta:"
 uid = ""

# Leer tecla por tecla SIN eco
 STDIN.noecho do
  while true
    char = STDIN.getch  # Captura una tecla sin eco
    break if char == "\r"  # Romper al pulsar Enter (puedes ajustar a "\n" si hace falta)
    uid += char
   end
 end
 return uid
end

# main
uid_leido = leer_uid
archivo = 'datos.txt'
datos = leer_identificadores_y_nombres(archivo)
comparar_identificadores(uid_leido, datos)
leer_identificadores_y_nombres(archivo)

