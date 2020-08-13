class CreateViewers < ActiveRecord::Migration[5.0]
  def change
    create_table :viewers do |t|
      t.references :user, foreign_key: true
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
