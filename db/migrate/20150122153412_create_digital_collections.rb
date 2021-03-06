class CreateDigitalCollections < ActiveRecord::Migration
  def change
    create_table :digital_collections do |t|
      t.string :collection_alias
      t.string :name
      t.string :thumbnail_url
      t.text :description

      t.timestamps
    end
  end
end
