# This migration comes from spree_shopomob (originally 20140125080520)
class CreateSpreeSms < ActiveRecord::Migration
  def change
    create_table :spree_sms do |t|
      t.string :to
      t.text :from
      t.string :text
      t.string :userapp
      t.boolean :delivered

      t.timestamps
    end
  end
end
