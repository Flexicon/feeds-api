# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true
      t.string :email, null: false
      t.string :name
      t.string :picture

      t.timestamps
    end
  end
end
