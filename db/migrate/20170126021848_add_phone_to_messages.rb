class AddPhoneToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :phone_id, :integer
  end
end
