class StudentsController < ApplicationController
	before_action :authenticate_user!

	def index
  		@students = Student.all
	end

	def new
		@student = Student.new
	end

	def create
		@student = Student.new(student_params)
 
  		if @student.save
  			redirect_to @student
  		else
  			render 'new'
  		end
	end

	def show
		@student = Student.find(params[:id])
	end

	def destroy
  		@student = Student.find(params[:id])
  		@student.destroy
 
  		redirect_to students_path
	end

	private
  		def student_params
    		params.require(:student).permit(:name, :age, :gender, :bachelor_degree)
  		end
end
