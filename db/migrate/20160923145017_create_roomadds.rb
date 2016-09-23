class CreateRoomadds < ActiveRecord::Migration
  def change
    create_table :roomadds do |t|
      t.string :room_no
      t.string :size
      t.string :location
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
