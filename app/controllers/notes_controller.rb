class NotesController < ApplicationController
  before_action :set_claim_and_note

  layout "claim_detail"

  # GET /notes
  # GET /notes.json
  def index
    p 'in the index action'
    @notes = @claim.notes
    @note = @claim.notes.new
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    p 'in the new action'
    @note = @claim.notes.new
    @notes = @claim.notes.order('created_at DESC')
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = @claim.notes.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @claim, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to @claim }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_and_note
      @claim = Claim.find(params[:claim_id])
      @note = @claim.notes.find(params[:id]) unless params[:id].nil?
    end

    def note_params
      params.require(:note).permit(:body)
    end

end
