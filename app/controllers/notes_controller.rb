class NotesController < ApplicationController

  # GET /notes
  # GET /notes.json
  def index
    @emails = @claim.notes
  end

end
