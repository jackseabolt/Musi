class RemoveGenre2FromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :genre_2, :string
  end
end
