class ChangeDataSexToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :sex, :string
  end
end
