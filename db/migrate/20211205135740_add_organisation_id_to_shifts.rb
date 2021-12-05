class AddOrganisationIdToShifts < ActiveRecord::Migration[6.1]
  def change
    add_reference :shifts, :organisation, foreign_key: true
  end
end
