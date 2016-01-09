class RemoveFluxReferenceToFluxComments < ActiveRecord::Migration
  def change
    remove_reference :flux_comments, :fluxes
    add_reference :flux_comments, :flux
  end
end
