# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "1@1, 10groups, 10post,"

create_account = User.create(email: "1@1", password:"123123")

create_jos = for i in 1..5 do
  Group.create!(title: "group no.#{i}", description: "created by #{i} group for something", user_id:"1")
end

create_jos = for i in 1..9 do
  create_jos = for k in 1..5 do
  Post.create!(content: "#{i} post for something", user_id:"1",group_id:"#{k}")
end
end
