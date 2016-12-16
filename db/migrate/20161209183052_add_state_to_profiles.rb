class AddStateToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :state, :string
  end
end
