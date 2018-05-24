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
		@student.mood += 2
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
		@student.mood += 2

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
		@student.mood += 2

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
		@student.mood += 2

		@student.updated_at = Time.now

		@student.save

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def tick(student)
		hungerRate = 0
		hygieneRate = 0
		energyRate = 0
		moodRate = 0
		healthRate = 0

		delta = Time.now - student.last_page_refresh

		if student.mood > 75
			hungerRate = 2
			hygieneRate = 2
			energyRate = 2
			moodRate = 2
			healthRate = 2
			student.icon = "happy"
		elsif student.mood <= 75 and student.mood > 50
			hungerRate = 3
			hygieneRate = 3
			energyRate = 3
			moodRate = 3
			healthRate = 3
			student.icon = "shy"
		elsif student.mood <= 50 and student.mood > 25
			hungerRate = 4
			hygieneRate = 4
			energyRate = 4
			moodRate = 4
			healthRate = 4
			student.icon = "sad"
		elsif student.mood <= 25 and student.mood > 0
			hungerRate = 5
			hygieneRate = 5
			energyRate = 5
			moodRate = 5
			healthRate = 5
			student.icon = "dead"
		end

		if delta > 5

			while delta > 5 do
				student.mood -= moodRate * Random.rand(0.5..2.0)
				student.hunger -= hungerRate * Random.rand(0.5..1.5)
				student.health -= healthRate * Random.rand(0.5..3)
				student.energy -= energyRate * Random.rand(0.5..1.5)

				delta -= 5
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