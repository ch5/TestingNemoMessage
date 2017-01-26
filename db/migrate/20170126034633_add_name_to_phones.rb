class AddNameToPhones < ActiveRecord::Migration[5.0]
  def change
    add_column :phones, :name, :string
  end
end
