class AddAgeToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :age, :integer
    add_column :profiles, :status, :string
    add_column :profiles, :location, :string
    add_column :profiles, :bio, :string
    add_column :profiles, :primary_instrument, :string
    add_column :profiles, :second_instrument, :string
    add_column :profiles, :third_instrument, :string
    add_column :profiles, :name, :string
  end
end
