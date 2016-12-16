class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :profiles, :location, :city
  end
end
