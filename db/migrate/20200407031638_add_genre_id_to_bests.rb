class AddGenreIdToBests < ActiveRecord::Migration[5.2]
  def change
    add_column :bests, :genre_id, :integer
  end
end
