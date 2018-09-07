class NotesController < ApplicationController

  # GET /notes
  # GET /notes.json
  def index
    @notes = @claim.notes
  end

end
