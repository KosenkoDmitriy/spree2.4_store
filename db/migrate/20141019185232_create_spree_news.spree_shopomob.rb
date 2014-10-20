# This migration comes from spree_shopomob (originally 20140125080512)
class CreateSpreeNews < ActiveRecord::Migration
  def change
    create_table :spree_news do |t|
      t.string :imgName
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
