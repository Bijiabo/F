class AddFluxReferenceToFluxComments < ActiveRecord::Migration
  def change
    add_reference :flux_comments, :fluxes
  end
end
