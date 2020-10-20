class CreateRecipes < ActiveRecord::Migration[4.2]
  def change
    create_table :recipes do |t| 
      t.string :name
      t.string :description
      t.string :instructions
      t.integer :ingridients
    end
  end
end