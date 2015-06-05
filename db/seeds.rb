# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rails.application.config.before_configuration do
  env_file = File.join(Rails.root, '.env.yml')
  YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
  end if File.exists?(env_file)
end

  
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


course = Course.create title: "KVPV 13",
                       short_description: "Lorem ipsum doler odor!",
                       description: "Lorem ipsum doler odor!",
                       enrollment_key: "kvpv"

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
                   user_id: 1  }
  }

  homeworks = Homework.create(homeworks)

  part.homeworks  = homeworks
  part.save

}

COMMENT_TEXT = "This is totally awesome! LOrem LoreM LOREM!"

homeworks = Homework.all

homeworks.each { |homework| 
  0.upto(rand(20)) { |temp| 
    comment_instance = Comment.create(text: COMMENT_TEXT, user_id: user.id)
    homework.comments << comment_instance
  }
  homework.save
}


# Part for user cabinet testing

  # create 120 courses
course_list = []
(1..120).each { |n|
  course_list << { title: "Course #{n}", 
                   description: "Lorem ipsum doler odor!",
                   short_description: "Lorem ipsum doler odor!",
                   enrollment_key: "qwe" }
}
Course.create course_list

roles = USER_COURSE_ROLES.values
len = roles.count

  # assign courses to registry
  registry_list = []
Course.select(:id).all.each { |cid|
  cid = cid.id
  registry_list << { user_id: 1, course_id: cid, role: roles[cid % 3] }
}
Registry.create registry_list



# Part for course registries trial

# create 25 users

cus = CreateUserService.new
crs = CreateRegistryService.new
course = Course.find(1)

(1..25).each { |index| 
  user = cus.call "user#{index}@example.com"
  if(index == 1) 
    crs.call course.id, user.id, USER_COURSE_ROLES[:OWNER]
  elsif index > 1 && index < 8
    crs.call course.id, user.id, USER_COURSE_ROLES[:TEACHER]
  else
    crs.call course.id, user.id, USER_COURSE_ROLES[:STUDENT]
  end  
}

# create different registries for course with id = 1