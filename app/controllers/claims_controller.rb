class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:index]

  layout :choose_layout

  # GET /claims
  # GET /claims.json
  def index
    if params[:search].blank?
      @claims = Claim.all.order('created_at DESC').limit(20).offset(@page * 20)
    else
      @claims = Claim.search(params[:search])
    end
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
  end

  # GET /claims/new
  def new
    @claim = Claim.new
  end

  # GET /claims/1/edit
  def edit
  end

  # POST /claims
  # POST /claims.json
  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        format.html { redirect_to edit_claim_path(@claim), notice: 'Claim was successfully created.' }
        format.json { render action: 'show', status: :created, location: @claim }
      else
        format.html { render action: 'new' }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claims/1
  # PATCH/PUT /claims/1.json
  def update
    puts "\n\r in the update action \n\r\n\r"
    puts "\n\r this is the claim", @claim
    puts @claim.status

    respond_to do |format|
      puts @claim.status

      if @claim.update(claim_params)
        # puts "\n\r this is the claim", @claim
        puts @claim.status
        if @claim.status == 'settled'
          @claim.settlement_date = DateTime.now
          puts DateTime.now
          @claim.save
        end

        format.html { redirect_to claims_path, notice: 'Claim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    @claim.destroy
    respond_to do |format|
      format.html { redirect_to claims_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:claim_id, :claimant_name, :postcode, :policy_no, :status, :settlement_amount, :settlement_date)
    end

    def set_page
      @page = params[:page].to_i || 0
    end

    def choose_layout
      if ["edit", "new"].include?(params[:action])
        'claim_detail'
      else
        'application'
      end
    end
end
