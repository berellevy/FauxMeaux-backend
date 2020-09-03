class ChangeLockedDefaultToLocked < ActiveRecord::Migration[6.0]
  def change
    change_column_default :views, :locked, 'locked'
  end
end
