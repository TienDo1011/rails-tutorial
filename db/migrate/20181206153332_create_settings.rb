class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :should_notify, default: true

      t.timestamps null: false
    end
  end
end
