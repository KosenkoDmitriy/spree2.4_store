# This migration comes from spree_shopomob (originally 20140611141355)
class CreateSpreeCategoriesShops < ActiveRecord::Migration
  def change
    create_table :spree_categories_shops do |t|

      t.timestamps
    end
  end
end
