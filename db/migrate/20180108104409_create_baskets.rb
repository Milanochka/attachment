class CreateBaskets < ActiveRecord::Migration[5.1]
  def change
    create_table :baskets do |t|
      t.string :name_user
      t.timestamps
    end
  end
end
