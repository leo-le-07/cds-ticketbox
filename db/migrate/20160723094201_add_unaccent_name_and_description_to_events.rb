class AddUnaccentNameAndDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :unaccent_name, :string
    add_column :events, :unaccent_description, :text
  end
end
