class AddLockVersionToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :lock_version, :integer
  end
end
