require 'faker'

task :console do
  exec "irb -r ./app.rb"
end

namespace :db do
  task :seed do
    require_relative 'app'

    chef_ids = (1..20).map do
      Chef.create(first_name:  Faker::Name.first_name,
                  last_name:   Faker::Name.last_name,
                  birthday:    Date.today - rand(20..50)*365,
                  email:       Faker::Internet.email,
                  phone:       Faker::PhoneNumber.phone_number)[:id]
    end

    meats = %w(Chicken Fish Beef Pork Steak Shrimp Ribs Sirloin Tuna)
    types = %w(Burger Sandwich Pizza Pasta Tacos Burritos Lasagna Masala and\ Noodles with\ Potatoes)

    meats.each do |meat|
      types.each do |type|
        Meal.create(name: "#{meat} #{type}", chef_id: chef_ids.sample)
      end
    end

    puts 'done'
  end

  task :setup do
    require_relative 'app'

    print "Creating database at #{MiniActiveRecord::Model.filename}..."

    MiniActiveRecord::Model.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )

    MiniActiveRecord::Model.execute(<<-SQL)
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name varchar(255),
        chef_id INTEGER NOT NULL,
        created_at datetime NOT NULL,
        updated_at datetime NOT NULL
      );
    SQL

    puts 'done'
  end

  task :drop do
    File.delete('./db/chefs.db') if File.exist?('./db/chefs.db')
  end
end
