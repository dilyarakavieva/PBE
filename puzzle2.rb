require_relative 'puzzle1.rb'
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

# main
uid_leido = leer_uid
procesar_uid(uid_leido) # llamar a la función que está en el otro archivo
