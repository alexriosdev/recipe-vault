class CreateIngridients < ActiveRecord::Migration[4.2]
  def change
    create_table :ingridients do |t| 
      t.string :name
    end
  end
end