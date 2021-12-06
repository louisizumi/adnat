class RemoveOrganisationIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :organisation_id, foreign_key: true
  end
end
