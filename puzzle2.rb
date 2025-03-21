require 'gtk3'

class RFIDApp
  def initialize
    # variable para acumular los caracteres leídos
    @rfid_buffer = ""

    # ventana 
    @window = Gtk::Window.new("rfid_gtk.rb")
    @window.set_default_size(400, 100)
    @window.signal_connect("destroy") { Gtk.main_quit }

    # EventBox (con Label) y el botón
    vbox = Gtk::Box.new(:vertical, 5)
    vbox.margin = 5
    @window.add(vbox)

    # EventBox para poder cambiar el color de fondo
    @event_box = Gtk::EventBox.new
    vbox.pack_start(@event_box, expand: true, fill: true, padding: 0)

    # label inicial
    @label = Gtk::Label.new("Please, login with your university card")
    @label.override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1)) # Texto en blanco
    @event_box.add(@label)

    # Botón Clear
    clear_button = Gtk::Button.new(label: "Clear")
    clear_button.signal_connect("clicked") { clear_display }
    vbox.pack_start(clear_button, expand: false, fill: false, padding: 0)

    # capturar eventos de teclado
    @window.add_events(Gdk::EventMask::KEY_PRESS_MASK)
    @window.signal_connect("key-press-event") { |_, event| on_key_pressed(event) }

    # fondo azul
    set_background_color(@event_box, 0, 0, 1) # Azul
    @window.show_all
  end

  # para capturar el UID
  def on_key_pressed(event)
    keyval = event.keyval
    char = event.string

    if keyval == Gdk::Keyval::KEY_Return
      unless @rfid_buffer.empty?
        uid = @rfid_buffer
        procesar_uid(uid)
        @rfid_buffer = ""  # Limpia el buffer
      end
    elsif char.match?(/[a-zA-Z0-9]/)
      @rfid_buffer += char
    end
  end

  # el UID capturado
  def procesar_uid(uid)
    # Elimina ceros iniciales
    input = uid.gsub(/^0+/, '')

    # convertir la entrada a número entero
    begin
      decimal_input = Integer(input)
    rescue ArgumentError
      puts "Error: El UID '#{input}' no es un número válido."
      @label.text = "Error: UID inválido."
      return
    end

    # convertir a hexadecimal (Big Endian y Little Endian)
    hex_input_big = decimal_input.to_s(16).upcase.rjust(8, '0')  # Big Endian
    hex_input_little = hex_input_big.scan(/../).reverse.join     # Little Endian

    # mostrar en la etiqueta
    @label.text = "UID Decimal: #{decimal_input}\n"\
                  "Hex Big Endian: #{hex_input_big}\n"\
                  "Hex Little Endian: #{hex_input_little}"

    # fondo rojo
    set_background_color(@event_box, 1, 0, 0)
  end

  # botón clear
  def clear_display
    @rfid_buffer = ""
    @label.text = "Please, login with your university card"
    set_background_color(@event_box, 0, 0, 1) # Azul
  end

  # para cambiar el color de fondo de un EventBox
  def set_background_color(widget, r, g, b)
    widget.override_background_color(:normal, Gdk::RGBA.new(r, g, b, 1))
  end
end

Gtk.init
RFIDApp.new
Gtk.main
