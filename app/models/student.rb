class Student < ApplicationRecord
	belongs_to :user
	after_initialize :set_defaults, if: 'new_record?'

	private
	def set_defaults
		self.mood = 100
		self.hunger = 100
		self.health = 100
		self.energy = 100
		self.last_page_refresh = Time.now()
	end
end