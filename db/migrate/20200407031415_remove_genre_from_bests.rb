class RemoveGenreFromBests < ActiveRecord::Migration[5.2]
  def change
    remove_column :bests, :genre, :string
  end
end
