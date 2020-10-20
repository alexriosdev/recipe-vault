class CreateFavorites < ActiveRecord::Migration[4.2]
  def change
    create_table :favorites do |t| 
      t.references :user
      t.references :recipe
    end
  end
end