class ChangeHazardsTable < ActiveRecord::Migration[4.2]

  def change
    add_reference :hazards, :user
  end

end