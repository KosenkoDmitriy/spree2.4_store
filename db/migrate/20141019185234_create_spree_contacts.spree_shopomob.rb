# This migration comes from spree_shopomob (originally 20140125114223)
class CreateSpreeContacts < ActiveRecord::Migration
  def change
    create_table :spree_contacts do |t|
      t.string :imageName
      t.string :key
      t.string :value
      t.string :prefix
      t.string :contact_type

      t.timestamps
    end
  end
end
