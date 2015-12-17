require_relative 'app'

def assert(truthy) # Metodo que regresa el error "Tests failded" a menos que cumpla con la condicion de ser verdadero
  raise "Tests failed" unless truthy
end

# chef = Chef.find(1)

# Este es un ejemplo de test ya que los nombres de los chefs son aleatorios, este test muy probablemente fallará
# assert chef[:first_name] == 'Ferran'
# assert chef[:last_name] == 'Adria'

# Probando initialize
# chef_initialize = Chef.new(first_name: 'Miriam', last_name: 'Ruiz', email: "miriam@mail.com", phone: 123456789, birthday: "1234-12-4", created_at: Time.now, updated_at: Time.now)
# assert chef_initialize[:first_name] == 'Miriam'

# Probando all
# meal_all = Meal.new
# assert meal_all

# Probando create
# Ya no se utiliza .new xq ya esta creado dentro del metodo, solo se llama a .create con los atributos del objeto
# chef_create = Chef.create(first_name: 'Montse', last_name: 'Armas', email: "mont@mail.com", phone: 9876543, birthday: "1989-10-4", created_at: Time.now, updated_at: Time.now) 
# assert chef_create[:last_name] == 'Armas'

# Probando where
p Chef.where("first_name = ?", 'Montse')

puts "finished"
