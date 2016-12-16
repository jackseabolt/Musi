class RemoveGenre4FromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :genre_4, :string
  end
end
