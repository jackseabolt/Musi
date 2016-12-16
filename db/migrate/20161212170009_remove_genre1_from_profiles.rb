class RemoveGenre1FromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :genre_1, :string
  end
end
