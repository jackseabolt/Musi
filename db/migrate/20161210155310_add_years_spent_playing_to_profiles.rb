class AddYearsSpentPlayingToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :years_spent_playing, :integer
  end
end
