class RenameGenreIdColumnToBests < ActiveRecord::Migration[5.2]
  def change
  	rename_column :bests, :genre_id, :genre
  end
end
