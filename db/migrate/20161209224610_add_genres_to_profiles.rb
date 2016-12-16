class AddGenresToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :genres, :string
  end
end
