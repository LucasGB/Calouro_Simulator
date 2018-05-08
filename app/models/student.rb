class Student < ApplicationRecord
	belongs_to :user
	before_save :set_defaults unless :persisted?

	def set_defaults
		self.coefficient ||= 0.0
		self.cash = 100.0
		self.mood = 100
		self.hunger = 100
		self.health = 100
		self.energy = 100
	end
end