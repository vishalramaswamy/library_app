class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :location
      t.string :size
      t.string :status

      t.timestamps null: false
    end
  end
end
