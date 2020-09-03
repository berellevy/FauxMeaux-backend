class AddAdIdToView < ActiveRecord::Migration[6.0]
  def change
    add_column :views, :ad_id, :integer
    add_foreign_key :views, :ads

  end
end
