class AddLockedToViews < ActiveRecord::Migration[6.0]
  def change
    add_column :views, :locked, :boolean, default: true
  end
end
