module Utility
	def say(words)
		puts "> #{words}"
	end
end


class Database
	include Utility
	attr_accessor :student_db, :user
	def initialize
		@student_db = {}
	end

	def welcome_message
		say 'Welcome to the Student Grade Database'
		say 'You may enter student grade information or display student standings.'
		say ''
		say "You may enter data or display data:"
	end

	def process(input)
		begin
			if input == '1'
				say "How many student grades are you inputting?"
				input_amount = gets.chomp.to_i
				begin
					say "Please enter student name: "
					student_name = gets.chomp
					say "Please enter student grade: "
					student_grade = gets.chomp.to_i
					student_db[student_name] = student_grade
					input_amount -= 1
				end until input_amount == 0
			elsif input == "2"
				if student_db.length == 0
					say "There is no data to display."
				elsif student_db.length > 0 
          student_array = student_db.sort_by {|_key, value| value}.reverse
					student_array.each do |name,grade|
						say "Name: #{name.capitalize} || Grade: #{grade}"
            say ""
					end
				end
			end
			say "Press '1' to add more data |-| Press '2' to display data"
			say "Type 'exit' to end program"
			input = gets.chomp.downcase
		end until input == "exit"
	end
end

class Admin
	include Utility
	def initialize
		@name = "Admin"
	end

	def admin_input
		say "Press '1' to enter data"
		say "Press '2' to display data"
		@admin_input = gets.chomp
	end
end

class Db_engine
	include Utility
	attr_accessor :user, :db
	def initialize
		@user = Admin.new
		@db = Database.new
	end

	def run
		db.welcome_message
		begin
			db.process(user.admin_input)
		end
	end	
end

Db_engine.new.run