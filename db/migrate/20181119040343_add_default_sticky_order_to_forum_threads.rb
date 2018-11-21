class AddDefaultStickyOrderToForumThreads < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :forum_threads, :sticy_order, 100
  end
end
