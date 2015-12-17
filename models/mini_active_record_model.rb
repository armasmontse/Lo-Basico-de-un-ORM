module MiniActiveRecord
  class InvalidAttributeError < StandardError; end
  class NotConnectedError < StandardError; end

  class Model

    attr_reader :attributes, :old_attributes

    # e.g., Chef.new(id: 1, first_name: 'Steve', last_name: 'Rogers', ...)
    def initialize(attributes = {})
      attributes.symbolize_keys!
      raise_error_if_invalid_attribute!(attributes.keys)

      # This defines the value even if it's not present in attributes
      @attributes = {}
      self.class.attribute_names.each do |name| #self era un objeto, para llamar a la clase lo hicimos self.class, asì sabemos que va a obtener cualquiera de las dos clases (Chef o Meal)
        @attributes[name] = attributes[name]
      end

      @old_attributes = @attributes.dup
    end

    def self.all
      MiniActiveRecord::Model.execute("SELECT * FROM self").map do |row|
        self.class.new(row)
      end
    end

    def self.create(attributes) # Create crea en memoria y guarda en la base de datos, recibe los mismos atributos en forma de hash que initialize
      record = self.new(attributes)
      record.save # Llama al metodo .save de abajo para guardar en base de datos

      record
    end

    def save # Metodo de instancia que guarda en base de datos
      if new_record?
        results = insert!
      else
        results = update!
      end

      # When we save, remove changes between new and old attributes
      @old_attributes = @attributes.dup

      results
    end








    def self.inherited(klass)
    end

    def self.database=(filename)
      @filename = filename
      @connection = SQLite3::Database.new(@filename)

      # Return the results as a Hash of field/value pairs
      # instead of an Array of values
      @connection.results_as_hash  = true

      # Automatically translate data from database into
      # reasonably appropriate Ruby objects
      @connection.type_translation = true
    end

    def self.filename
      @filename
    end

    def self.connection
      @connection
    end

    def self.execute(query, *args)
      raise NotConnectedError, "You are not connected to a database." unless connected?

      prepared_args = args.map { |arg| prepare_value(arg) }
      MiniActiveRecord::Model.connection.execute(query, *prepared_args)
    end

    def self.connected?
      !self.connection.nil?
    end

    def self.attribute_names
      @attribute_names
    end

    def self.attribute_names=(attribute_names)
      @attribute_names = attribute_names
    end

    def self.last_insert_row_id
      MiniActiveRecord::Model.connection.last_insert_row_id
    end

    def valid_attribute?(attribute)
      self.class.attribute_names.include? attribute
    end

    def raise_error_if_invalid_attribute!(attributes)
      # This guarantees that attributes is an array, so we can call both:
      #   raise_error_if_invalid_attribute!("id")
      # and
      #   raise_error_if_invalid_attribute!(["id", "name"])
      Array(attributes).each do |attribute|
        unless valid_attribute?(attribute)
          raise InvalidAttributeError, "Invalid attribute for #{self.class}: #{attribute}"
        end
      end
    end

    def to_s
      attribute_str = self.attributes.map { |key, val| "#{key}: #{val.inspect}" }.join(', ')
      "#<#{self.class} #{attribute_str}>"
    end


    private

    def self.prepare_value(value)
      case value
      when Time, DateTime, Date
        value.to_s
      else
        value
      end
    end

  end

end
