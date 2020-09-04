class AddViewedToViews < ActiveRecord::Migration[6.0]
  def change
    add_column :views, :viewed, :boolean, default: false
  end
end
