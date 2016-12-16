class RemoveGenre3FromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :genre_3, :string
  end
end
