# This migration comes from spree_shopomob (originally 20140610162826)
class CreateSpreeShops < ActiveRecord::Migration
  def change
    create_table :spree_shops do |t|
      t.string :imageName
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
