class RenameSettingsTableToUserConfigurations < ActiveRecord::Migration
  def change
    rename_table :settings, :user_configurations
  end
end
