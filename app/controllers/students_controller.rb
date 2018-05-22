class StudentsController < ApplicationController
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token

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
		tick(@student)	
	end

	def destroy
  		@student = Student.find(params[:id])
  		@student.destroy
 
  		redirect_to students_path
	end

	def update
		@student = Student.find(params[:id])

		tick(@student)

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def feed
		@student = Student.find(params[:id])

		@student.hunger += 4
		@student.health -= 1
		@student.updated_at = Time.now

		@student.save

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def sleep
		@student = Student.find(params[:id])

		@student.energy += 6
		@student.health += 1

		@student.updated_at = Time.now

		@student.save

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end

	end

	def exercise
		@student = Student.find(params[:id])

		@student.energy -= 6
		@student.health += 5

		@student.updated_at = Time.now

		@student.save

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end

	end

	def bath
		@student = Student.find(params[:id])

		@student.energy += 1
		@student.health += 2

		@student.updated_at = Time.now

		@student.save

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def tick(student)
		delta = Time.now - student.last_page_refresh

		if delta > 30

			while delta > 30 do
				student.mood -= 2
				student.hunger -= 2
				student.health -= 2
				student.energy -= 2

				delta -= 30
			end

			student.last_page_refresh = Time.now

			student.save
		end
	end

	private
  		def student_params
    		params.require(:student).permit(:name, :age, :gender, :bachelor_degree, :coefficient, :cash, :mood, :hunger, :health, :energy, :last_active)
  		
	end
end