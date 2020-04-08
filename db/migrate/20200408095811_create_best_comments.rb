class CreateBestComments < ActiveRecord::Migration[5.2]
  def change
    create_table :best_comments do |t|
      t.integer :user_id
      t.integer :best_id
      t.string :comment

      t.timestamps
    end
  end
end
