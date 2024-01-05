class CreateMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :mappings do |t|
      t.string :og_url
      t.string :key
      t.integer :hit_count

      t.timestamps
    end
    add_index :mappings, :key, unique: true
  end
end
