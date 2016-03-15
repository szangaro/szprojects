# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Profile.destroy_all
User.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

#puts Profile.methods

Profile.create! [
{ first_name: "Carly", last_name: "Fiorina", birth_year: 1954, gender: "female"},
{ first_name: "Donald", last_name: "Trump", birth_year: 1946, gender: "male"},
{ first_name: "Ben", last_name: "Carson", birth_year: 1951, gender: "male"},
{ first_name: "Hillary", last_name: "Clinton", birth_year: 1947, gender: "female"}
]

profiles = Profile.all.to_a
profiles.each do |prof|
	nuser = User.create username: prof.last_name, password_digest: prof.first_name
end

users = User.all.to_a
users.each do |nuser|
		mylist = TodoList.create list_name: "todo_list_for_#{nuser.username}", list_due_date: Date.today + 1.year, user_id: nuser.id
end

mylist = TodoList.all.to_a 
mylist.each do |list|
	5.times do |n|
		myitem = TodoItem.create title: "Item #{n} for list #{list.list_name}", description: "this is an item created #{Time.now}", completed: false, due_date: Date.today + 1.year
		list.todo_items << myitem
	end
end


