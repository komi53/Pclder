class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
	  t.string :title
	  t.string :cpu_name
	  t.string :cooler_name
	  t.string :motherboard_name
	  t.string :memory_name
	  t.string :gpu_name
	  t.string :storage_name
	  t.string :case_name
	  t.string :power_supply_name
	  t.string :other
	  t.text :pc_introduction
	  t.string :value
      t.string :tag_list
      t.string :post_image_id
      t.timestamps
    end
  end
end
