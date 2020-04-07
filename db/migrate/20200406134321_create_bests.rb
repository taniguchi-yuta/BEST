class CreateBests < ActiveRecord::Migration[5.2]
  def change
    create_table :bests do |t|
      t.integer :user_id
      t.string :best_name
      t.text :best_image_id
      t.text :recommend
      t.string :genre
      t.text :best_url

      t.timestamps
    end
  end
end
