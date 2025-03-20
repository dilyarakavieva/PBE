require 'gtk3'
require_relative 'puzzle1.rb'

class RFIDApp
  def initialize
    @window = Gtk::Window.new("Lector RFID con GTK")
    @window.set_default_size(400, 150)
    @window.signal_connect("destroy") { Gtk.main_quit }

    @rfid_buffer = ""  # Almacena la lectura temporalmente

    # Captura eventos de teclado en la ventana
    @window.add_events(Gdk::EventMask::KEY_PRESS_MASK)
    @window.signal_connect("key-press-event") { |_, event| on_key_pressed(event) }

    @label = Gtk::Label.new("Escanea tu tarjeta RFID...")
    @window.add(@label)

    @window.show_all
  end

  def on_key_pressed(event)
    keyval = event.keyval
    char = event.string
 if keyval == Gdk::Keyval::KEY_Return
      unless @rfid_buffer.empty?
        uid = @rfid_buffer  # Guardar UID antes de limpiar
        puts "RFID Detectado: #{uid}"
        @label.text = "Último RFID: #{uid}"
        procesar_uid(uid)  # Llamar a la función para procesar el UID
        @rfid_buffer = ""  # Limpiar buffer para la siguiente lectura
      end
    elsif char.match?(/[a-zA-Z0-9]/)  # Filtrar solo caracteres válidos
      @rfid_buffer += char
    end
  end

  def procesar_uid(input)
     input = input.gsub(/^0+/, '')  # Elimina ceros iniciales, porque si no van saliendo errores
    # Convertir la entrada a número entero (manejar errores si la entrada no es válida)
    begin
      decimal_input = Integer(input) # Convierte a número entero
    rescue ArgumentError
      puts "Error: El UID '#{input}' no es un número válido."
      return
    end

    # Convertir a hexadecimal (Big Endian y Little Endian)
    hex_input_big = decimal_input.to_s(16).upcase.rjust(8, '0')  # Big Endian
    hex_input_little = hex_input_big.scan(/../).reverse.join  # Little Endian

    #     procesar_uid(decimal_input)-- no pude
    # Mostrar en la ventana GTK
    @label.text = "UID: #{input}\nBig Endian: #{hex_input_big}\nLittle Endian: #{hex_input_little}"
  end
end

Gtk.init
RFIDApp.new
Gtk.main
