require 'gtk3'

class RFIDApp

   # cambia el color de fondo del widget usando valores RGB (0-1)
  def set_background_color(widget, r, g, b)
    widget.override_background_color(:normal, Gdk::RGBA.new(r, g, b, 1))
  end

  # reset
  def reset_view
    @rfid_buffer = ""
    @label.text = "Please, login with your university card"
    set_background_color(@event_box, 0, 0, 1)  # Fondo azul
  end

  # maneja el teclado
  def handle_key(event)
    char = event.string
    if event.keyval == Gdk::Keyval::KEY_Return
      process_rfid(@rfid_buffer) unless @rfid_buffer.empty?
      @rfid_buffer = ""
   elsif char.match?(/[a-zA-Z0-9]/)
      @rfid_buffer += char
    end
  end
  
  def initialize
    # para acumular caracteres del UID
    @rfid_buffer = ""
    
    # crear ventana principal
    @window = Gtk::Window.new("RFID Reader")
    @window.set_default_size(400, 100)
    @window.signal_connect("destroy") { Gtk.main_quit }

    # el área de visualización y el botón
    vbox = Gtk::Box.new(:vertical, 5)
    vbox.margin = 5
    @window.add(vbox)

    # EventBox para permitir cambiar el color de fondo
    @event_box = Gtk::EventBox.new
    vbox.pack_start(@event_box, expand: true, fill: true, padding: 0)

    # label para mostrar mensajes y resultados
    @label = Gtk::Label.new("Please, login with your university card")
    @label.override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))  # Texto en blanco
    @event_box.add(@label)

    # botón "Clear" para reiniciar la visualización
    clear_button = Gtk::Button.new(label: "Clear")
    clear_button.signal_connect("clicked") { reset_view }
    vbox.pack_start(clear_button, expand: false, fill: false, padding: 0)

    # capturar eventos de teclado para leer el UID
    @window.add_events(Gdk::EventMask::KEY_PRESS_MASK)
    @window.signal_connect("key-press-event") { |_, event| handle_key(event) } 

    # fondo azul
    set_background_color(@event_box, 0, 0, 1) # para cambiar el color del fondo
    @window.show_all
  end


  # elimina ceros iniciales, convierte a decimal y hexadecimal
  def process_rfid(uid)
    clean_uid = uid.gsub(/^0+/, '') # eliminamos los ceros
    begin
      dec = Integer(clean_uid) #los convertimos a decimal
    rescue ArgumentError
      @label.text = "Error: Invalid UID."
      return
    end

    hex_big = dec.to_s(16).upcase.rjust(8, '0')   # Big Endian
    hex_little = hex_big.scan(/../).reverse.join  # Little Endian

    @label.text = "UID Decimal: #{dec}\nHex Big: #{hex_big}\nHex Little: #{hex_little}"
    set_background_color(@event_box, 1, 0, 0)  # fondo rojo
  end
 
end

Gtk.init
RFIDApp.new
Gtk.main
