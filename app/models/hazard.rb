class Hazard < ActiveRecord::Base
    belongs_to :user
    
    def humanize_time
        self.created_at.strftime("%A, %B %d")  
    end
end