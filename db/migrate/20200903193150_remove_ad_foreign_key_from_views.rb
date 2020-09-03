class RemoveAdForeignKeyFromViews < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :views, :ads
  end
end
