class NotesController < ApplicationController
  before_action :set_claim

  # GET /notes
  # GET /notes.json
  def index
    @notes = @claim.notes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:claim_id])
    end

end
