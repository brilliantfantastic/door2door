class VotersController < ApplicationController
  before_action :set_voter, only: [:show, :edit, :update, :destroy]

  def index
    @voters = Voter.includes(:address).all
  end

  def search
  end

  def results
    @voters = Voter.search params[:q]
  end

  def show
  end

  def new
    @voter = Voter.new
    @voter.build_address
  end

  def edit
    @voter.build_address if @voter.address.nil?
  end

  def create
    @voter = Voter.new(voter_params)

    respond_to do |format|
      if @voter.save
        format.html { redirect_to @voter, notice: 'Voter was successfully created.' }
        format.json { render :show, status: :created, location: @voter }
      else
        format.html { render :new }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @voter.update(voter_params)
        format.html { redirect_to @voter, notice: 'Voter was successfully updated.' }
        format.json { render :show, status: :ok, location: @voter }
      else
        @voter.build_address if @voter.address.nil?
        format.html { render :edit }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @voter.destroy
    respond_to do |format|
      format.html { redirect_to voters_url, notice: 'Voter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_voter
    @voter = Voter.find(params[:id])
  end

  def voter_params
    params.require(:voter).permit(:first_name, :last_name,
                                  :registered,
                                  address_attributes: [:id, :street, :city,
                                                       :zip_code])
  end
end
