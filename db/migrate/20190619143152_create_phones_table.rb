# frozen_string_literal: true

class CreatePhonesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.bigint :phone_number_offset
    end

    add_index :phones, :phone_number_offset
  end
end
