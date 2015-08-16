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


# 1. Create admin user
user_adm = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user_adm.email

DESCRIPTION_LONG = "Lorem Ipsum jest tekstem stosowanym jako przykładowy wypełniacz w przemyśle poligraficznym. Został po raz pierwszy użyty w XV w. przez nieznanego drukarza do wypełnienia tekstem próbnej książki. Pięć wieków później zaczął być używany przemyśle elektronicznym, pozostając praktycznie niezmienionym. Spopularyzował się w latach 60. XX w. wraz z publikacją arkuszy Letrasetu, zawierających fragmenty Lorem Ipsum, a ostatnio z zawierającym różne wersje Lorem Ipsum oprogramowaniem przeznaczonym do realizacji druków na komputerach osobistych, jak Aldus PageMaker"
DESCRIPTION_SHORT = "Lorem ipsum doler odor!"
ENROLLMENT_KEY = "changeme"

COURSES_COUNT = 11
PARTS_COUNT = 11

# 2. Create 11 courses
(1..COURSES_COUNT).each { |t|
  course = Course.create  title: "Course #{t}",
                 short_description: DESCRIPTION_SHORT,
                 description: DESCRIPTION_LONG,
                 enrollment_key: ENROLLMENT_KEY,
                 documentation: DESCRIPTION_LONG

  # 3. Create 11 modules for each course
  parts = []
  (1..PARTS_COUNT).each { |r|       
      parts << { title: "Module #{t} :: #{r}", 
                 description: DESCRIPTION_LONG,
                 course_id: course.id,
                 status: PART_STATUSES[:ACTIVE]
               }
  }
  parts = Part.create(parts)
}

# 4. Create (11.13) users as students for 1 course
# 5. Make 5 teachers for 1 course
# 6. Make 1 owner of 1 course
course = Course.find(1)
cus = CreateUserService.new
crs = CreateRegistryService.new

(1..18).each { |index| 
  user = cus.call "user#{index}@example.com", "User #{index}"
  if(index == 1) 
    crs.call course.id, user.id, USER_COURSE_ROLES[:OWNER]
  elsif index > 1 && index < 5
    crs.call course.id, user.id, USER_COURSE_ROLES[:TEACHER]
  else
    crs.call course.id, user.id, USER_COURSE_ROLES[:STUDENT]
  end  
}

crs.call 1, user_adm.id, USER_COURSE_ROLES[:OWNER]


# 7. Create dummy homework with 2 attachments
HOMEWORK_DESCRIPTION = "#{DESCRIPTION_LONG} 120 x 240 - Vertical Banner<br><br><img src='/images/banners/black_120x240.gif' alt='' border='0' height='240' width='120'><img src='/images/banners/grey_120x240.gif' alt='' border='0' height='240' width='120'><img src='/images/banners/white_120x240.gif' alt='' border='0' height='240' width='120'>"
a = Attachment.create! description: "1. #{DESCRIPTION_SHORT}"
b = Attachment.create! description: "2. #{DESCRIPTION_SHORT}"
c = Attachment.all

# 8. Each student will have (4..11) modules done for a course
student_ids = Registry.select(:user_id)
                     .where("role = ?", USER_COURSE_ROLES[:STUDENT])
                     .map(&:user_id)

MINIMUM_NUMBER = 5
for_seed = PARTS_COUNT - MINIMUM_NUMBER

homeworks = []
student_ids.each { |sid| 
  count = 4 + rand(for_seed)

  (1..count).each { |e|
    homeworks << { description: HOMEWORK_DESCRIPTION,
                   user_id: sid,
                   part_id: e
                 }
  }
}

Homework.create!(homeworks)

temp = Homework.find(1)
temp.attachments = c
temp.save!

# 9. Each homework should have comments
COMMENT_TEXT = "This is totally awesome! LOrem LoreM LOREM!"

homeworks = Homework.all

data = []
homeworks.each { |homework| 
  0.upto(rand(20)) { |temp| 
    comment_instance = {text: COMMENT_TEXT,
                        user_id: user_adm.id,
                        homework_id: homework.id }
    data << comment_instance
  }
}
Comment.create(data)  

(1..10).each { |num|
  temp = Post.create user_id: 1, parent_id: 0, content: "Heading of the topic #{num}", course_id: course.id

  (1..10).each { |n| 
    Post.create user_id: 1, parent_id: temp.id, content: DESCRIPTION_LONG, course_id: course.id
  }
}
