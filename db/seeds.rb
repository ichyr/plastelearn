# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


course = Course.create title: "KVPV 13", description: "Lorem ipsum doler odor!"

parts = []
1.upto(10) { |t| 
	
	parts << { title: "Module #{t}", 
						 description: "#{t}:::Lorem ipsum doler odor!",
						 course_id: course.id }

}

parts = Part.create(parts)


parts.each { |part| 

	homeworks = []
	1.upto(rand(15)) { |t| 
		homeworks << { description: "Here to be my new homework! Mio number #{t}",
									 user_id: 1	 }
	}

	homeworks = Homework.create(homeworks)

	part.homeworks  = homeworks
	part.save

}