# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dogs = [
  {
    user_id: 1,
    name: 'Bowie',
    description: 'Bowie dances when he walks'
  },
  {
    user_id: 1,
    name: 'Brownie',
    description: 'Brownie only sits pretty'
  },
  {
    user_id: 1,
    name: 'Jax',
    description: '',
  },
  {
    user_id: 1,
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys'
  },
  {
    user_id: 1,
    name: 'Pete',
    description: 'Pete has a best friend named Lua'
  },
  {
    user_id: 2,
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all'
  },
    {
    user_id: 2,
    name: 'Britta',
    description: 'Britta has two different colored eyes'
  },
  {
    user_id: 2,
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity'
  },
  {
    user_id: 2,
    name: 'Stella',
    description: 'Stella loves to dig'
  },
  {
    user_id: 2,
    name: 'Tonks',
    description: 'Tonks loves to run'
  },
]



user = User.new
user.email = 'test@example.com'
user.password = '123456'
user.password_confirmation = '123456'
user.save!

user = User.new
user.email = 'test2@example.com'
user.password = '123456'
user.password_confirmation = '123456'
user.save!

dogs.each do |dog|
  dog = Dog.find_or_create_by(user_id: dog[:user_id], name: dog[:name], description: dog[:description])
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
