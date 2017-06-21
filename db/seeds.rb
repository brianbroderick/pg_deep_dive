# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = ::Gender.pluck(:name).reduce([]) do |list, name|
  list << { name: name, email: "#{name}@example.com" }
  list
end

::MultiInsert.call(users, { model: ::User, ignore_attributes: ["id"], page_size: 1_000 })

User.limit(500).each do |user|
  1.upto(rand(4)) do     
    Login.create(login_attempts: 1, user_id: user.id)
  end
end

