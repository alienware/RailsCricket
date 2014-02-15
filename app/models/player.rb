class Player < ActiveRecord::Base
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :matches

	serialize :statistics, Hash
end
