require 'byebug'

class Student
	attr_reader :first_name, :last_name, :courses

	def initialize(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
		@courses = []
	end

	def name
		"#{@first_name} #{@last_name}"
	end

	def enroll(course)
		#debugger
		if has_conflict?(course)
			raise_error
		else
			@courses << course
			course.students << self
		end
	end

	def course_load
		@course_load = Hash.new(0)

		courses.each { |course| @course_load[course.department] += course.credits }

		@course_load
	end

	def has_conflict?(course)
		@courses.each { |enrolled_course| return true if enrolled_course.conflicts_with?(course) }
		false
	end

	def raise_error
		begin
			error = Exception.new("Error! Conflicting course schedule")
		rescue error => e
			puts e.inspect
		end
	end

end
