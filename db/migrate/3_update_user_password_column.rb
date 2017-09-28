class UpdateUserPasswordColumn < ActiveRecord::Migration[4.2]
    def change
      rename_column :users, :password, :password_hash  
    end
end