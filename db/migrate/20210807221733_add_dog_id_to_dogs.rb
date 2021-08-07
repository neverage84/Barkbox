class AddDogIdToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :dog_id, :integer
    add_index :dogs, :dog_id
  end
end
