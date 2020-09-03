class ChangeNullToTrueInViewsAds < ActiveRecord::Migration[6.0]
  def change
    change_column :views, :ad_id, :bigint, null: true
  end
end
