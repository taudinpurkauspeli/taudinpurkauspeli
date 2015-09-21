class AddFlashNoticeAndFlashAlertToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :flash_notice, :string
    add_column :log_entries, :flash_alert, :string
  end
end
