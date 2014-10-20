# This migration comes from spree_shopomob (originally 20140610162831)
class CreateSpreeCompanies < ActiveRecord::Migration
  def change
    create_table :spree_companies do |t|
      t.string :imageName
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
