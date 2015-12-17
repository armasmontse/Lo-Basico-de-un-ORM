require_relative 'app'

def assert(truthy)
  raise "Tests failed" unless truthy
end

chef = Chef.find(1)

# Este es un ejemplo de test ya que los nombres de los chefs son aleatorios, este test muy probablemente fallará
# assert chef[:first_name] == 'Ferran'
# assert chef[:last_name] == 'Adria'

# Probando initialize
chef_initialize = Chef.new(first_name: 'Miriam', last_name: 'Ruiz', email: "miriam@mail.com", phone: 123456789, birthday: "1234-12-4", created_at: Time.now, updated_at: Time.now)
assert chef_initialize[:first_name] == 'Miriam'







puts "finished"
