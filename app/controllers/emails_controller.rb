class EmailsController < ApplicationController
  before_action :set_claim_and_email

  layout "claim_detail"

  # GET /emails
  # GET /emails.json
  def index
    @emails = @claim.emails
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = @claim.emails.new
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = @claim.emails.new(email_params)

    respond_to do |format|
      if @email.save
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render action: 'show', status: :created, location: @email }
      else
        format.html { render action: 'new' }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_and_email
      @claim = Claim.find(params[:claim_id])
      @email = @claim.emails.find(params[:id]) unless params[:id].nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:subject, :body, :from, :to)
    end

end
