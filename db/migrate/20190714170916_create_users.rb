# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
