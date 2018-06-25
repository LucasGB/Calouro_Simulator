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

		if @student.icon != "dead"
			tick(@student)
		end
	end

	def destroy
  		@student = Student.find(params[:id])
  		@student.destroy
 
  		redirect_to students_path
	end

	def ranking
		@students = Student.order(:coefficient)
	end

	def update
		@student = Student.find(params[:id])

		if @student.icon != "dead"
			tick(@student)
		end

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def feed
		@student = Student.find(params[:id])

		if @student.icon != "dead"

			@student.hunger += 4
			@student.health -= 1
			@student.mood += 2
			@student.updated_at = Time.now

			if @student.hunger > 100
				@student.hunger = 100
				@student.health = 50
			end
			if @student.health > 100
				@student.health = 100
			end	
			if @student.mood > 100
				@student.mood = 100
			end

			@student.save
		end
	
		respond_to do |format|
    		format.html
    		format.json { render json: @student }
    	end
	end

	def cure
		@student = Student.find(params[:id])

		if @student.icon != "dead"
			@student.energy += 2
			@student.health += 5
			@student.mood += 3

			if @student.energy > 100
				@student.energy = 100
			end
			if @student.health > 100
				@student.health = 20
			end
			if @student.mood > 100
				@student.mood = 100
			end

			@student.updated_at = Time.now

			@student.save
		end

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def play
		@student = Student.find(params[:id])
	end

	def convert_points
		@student = Student.find(params[:id])

		puts 'shashasa', params[:id]
		@student.mood += params[:mood].to_i
		@student.energy -= params[:energy].to_i

		if @student.mood > 100
			@student.mood = 100
		end
		if @student.energy < 0
			@student.energy = 0
		end

		@student.updated_at = Time.now
		@student.save

		redirect_to student_path(@student)
	end

	def sleep
		@student = Student.find(params[:id])

		if @student.icon != "dead"

			@student.energy += 6
			@student.health += 1
			@student.mood += 2

			if @student.energy > 100
				@student.energy = 100
			end
			if @student.health > 100
				@student.health = 100
			end
			if @student.mood > 100
				@student.mood = 100
			end

			@student.updated_at = Time.now

			@student.save
		end

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end

	end

	def exercise
		@student = Student.find(params[:id])

		if @student.icon != "dead"

			@student.energy -= 6
			@student.health += 5
			@student.mood += 2

			if @student.health > 100
				@student.health = 100
			end
			if @student.mood > 100
				@student.mood = 100
			end

			@student.updated_at = Time.now

			@student.save
		end

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end

	end

	def bath
		@student = Student.find(params[:id])

		if @student.icon != "dead"

			@student.energy += 1
			@student.hygiene += 10
			@student.health += 2
			@student.mood += 2

			if @student.energy > 100
				@student.energy = 100
			end
			if @student.health > 100
				@student.health = 100
			end
			if @student.mood > 100
				@student.mood = 100
			end
			if @student.hygiene > 100
				@student.hygiene = 100
			end

			@student.updated_at = Time.now

			@student.save
		end

		respond_to do |format|
      		format.html
      		format.json { render json: @student }
      	end
	end

	def study
		@student = Student.find(params[:id])

		if @student.icon != "dead"

			@student.energy += 10
			@student.hygiene += 5
			@student.health += 3
			@student.mood += 5
			@student.coefficient += 0.01

			if @student.energy > 100
				@student.energy = 100
			end
			if @student.health > 100
				@student.health = 100
			end
			if @student.mood > 100
				@student.mood = 100
			end
			if @student.hygiene > 100
				@student.hygiene = 100
			end
			if @student.coefficient > 1.0
				@student.coefficient = 1.0
			end

			@student.updated_at = Time.now

			@student.save
		end

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

		if student.mood <= 0 or student.health <= 0
			student.icon = "dead"
			student.mood = 0
			student.health = 0
			student.hygiene = 0
			student.hunger = 0
			student.energy = 0
		elsif student.health <= 50 and student.health > 0
			hungerRate = 10
			hygieneRate = 10
			energyRate = 10
			moodRate = 20
			healthRate = 10
			student.icon = "sick"
		elsif student.health <= 25 and student.health > 0
			hungerRate = 20
			hygieneRate = 20
			energyRate = 20
			moodRate = 30
			healthRate = 20
			student.icon = "sick"
		elsif student.mood > 75
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
		elsif student.mood <= 25
			hungerRate = 5
			hygieneRate = 5
			energyRate = 5
			moodRate = 5
			healthRate = 5
			student.icon = "cry"
		end

		delta = Time.now - student.last_page_refresh

		if delta > 5

			while delta > 5 do


				student.mood -= moodRate * Random.rand(0.5..2.0)
				student.hunger -= hungerRate * Random.rand(0.5..1.5)
				student.health -= healthRate * Random.rand(0.5..3)
				student.hygiene -= hygieneRate * Random.rand(0.5..3)
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