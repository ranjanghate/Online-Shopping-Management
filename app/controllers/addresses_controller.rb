class AddressesController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  before_action :authenticate_address!, only: %i(edit update destroy set_primary_address)

  def index
    @addresses = Current.user.addresses
  end

  def new
    @address = Current.user.addresses.new
  end

  def create
    @address = Current.user.addresses.new(address_params)
    if @address.save
      redirect_to user_addresses_path(Current.user), success: "Address added successfully"
    else
      flash.now[:danger] = "Failed to add address"
      render :new
    end
  end

  def set_primary_address
    Current.user.update(default_address_id: @address.id)
    respond_to do |format|
      format.html { redirect_to user_addresses_path(Current.user), success: "Primary Address Set" }
      format.json { head :no_content }
      format.js { flash.now[:success] = "Primary address Set" }
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to user_addresses_path(Current.user), success: "Address Updated"
    else
      flash.now[:danger] = "Failed to update address"
      render :edit
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to user_addresses_path(Current.user), warning: "Address Deleted" }
      format.json { head :no_content }
      format.js   { flash.now[:danger] = "Address Deleted" }
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :code)
  end

  def authenticate_address!
    @address = Current.user.addresses.find_by(id: params[:id])
    redirect_to user_addresses_path, warning: "You are trying to access invalid address" if @address.blank?
  end
end
