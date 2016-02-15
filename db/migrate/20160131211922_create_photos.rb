class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.boolean :published, default: false
      t.timestamps null: false
    end
  end
end
