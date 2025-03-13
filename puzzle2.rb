require_relative 'puzzletest6.rb'
require 'io/console'

def leer_uid
 puts "Introduce el UID de la tarjeta:"
 uid = ""

 STDIN.noecho do
  while true
    char = STDIN.getch  # elimina eco
    break if char == "\r"  
    uid += char
   end
 end
 return uid
end

# Leer UID
uid_leido = leer_uid

# Llamar a la función que está en el otro archivo
procesar_uid(uid_leido)
