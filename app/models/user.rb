class User < ActiveRecord::Base
    has_many :hazards
end