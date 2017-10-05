class Hazard < ActiveRecord::Base
    belongs_to :user
    validates :description, presence: true
    validates :image, presence: true
    
    def humanize_time
        self.created_at.strftime("%A, %B %d")  
    end
end