class ReplaceLockedWithAdView < ActiveRecord::Migration[6.0]
  def change
    remove_column :views, :locked
    add_column :views, :ad_view, :boolean, null: false, default: false
  end
end
