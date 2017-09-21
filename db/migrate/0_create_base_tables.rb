class CreateBaseTables < ActiveRecord::Migration[4.2]

  def change
    create_table :hazards do |t|
      t.string :description
      t.string :image
      t.string :coordinates
      t.timestamps
    end

  end

end