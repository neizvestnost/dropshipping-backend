# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
