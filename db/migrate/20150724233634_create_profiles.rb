class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :avatar_url
      t.text :bio
      t.references :user, index: true, foreign_key: true
      t.text :location

      t.timestamps null: false
    end
  end
end
