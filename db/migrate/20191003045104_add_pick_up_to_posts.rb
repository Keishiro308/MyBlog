class AddPickUpToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :pick_up, :boolean
  end
end
