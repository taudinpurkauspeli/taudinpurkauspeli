class AddFlashNoticeAndFlashAlertToLogEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :log_entries, :flash_notice, :string
    add_column :log_entries, :flash_alert, :string
  end
end
