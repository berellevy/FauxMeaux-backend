class ChangeLockedToStringInViews < ActiveRecord::Migration[6.0]
  def change
    change_column :views, :locked, :string
  end
end
