class StudentsController < ApplicationController
	before_action :authenticate_user!

	def index
  		@students = current_user.students
	end

	def new
		@student = Student.new
	end

	def create
		@student = current_user.students.build(student_params)
 
  		if @student.save
  			redirect_to @student
  		else
  			render 'new'
  		end
	end

	def show
		@student = Student.find(params[:id])

		delta = Time.now - @student.last_page_refresh

		if delta > 30

			while delta > 30 do
				@student.mood -= 2
				@student.hunger -= 2
				@student.health -= 2
				@student.energy -= 2

				delta -= 30
			end

			@student.last_page_refresh = Time.now

			@student.save

		end

		

	end

	def destroy
  		@student = Student.find(params[:id])
  		@student.destroy
 
  		redirect_to students_path
	end

	def feed
		@student = Student.find(params[:id])

		@student.hunger += 4
		@student.health -= 1
		@student.updated_at = Time.now

		@student.save

		puts 'FED.'

		redirect_to @student
	end

	def sleep
		@student = Student.find(params[:id])

		@student.energy += 6
		@student.health += 1

		@student.updated_at = Time.now

		@student.save

		puts 'SLEPT.'

		redirect_to @student

	end

	def play
		@student = Student.find(params[:id])

		@student.energy -= 6
		@student.health += 5

		@student.updated_at = Time.now

		@student.save

		puts 'PLAYED.'

		redirect_to @student

	end

	def exercise
		@student = Student.find(params[:id])

		@student.energy += 1
		@student.health += 2

		@student.updated_at = Time.now

		@student.save

		puts 'Exercised.'

		redirect_to @student

	end

	def bath
		@student = Student.find(params[:id])

		@student.energy += 1
		@student.health += 2

		@student.updated_at = Time.now

		@student.save

		puts 'PLAYED.'

		redirect_to @student

	end

	private
  		def student_params
    		params.require(:student).permit(:name, :age, :gender, :bachelor_degree, :coefficient, :cash, :mood, :hunger, :health, :energy, :last_active)
  		
	end
end