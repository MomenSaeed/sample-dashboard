class VendorsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  # GET /vendors
  def index
    @vendors = Vendor.all.includes(:products)
    render json: @vendors if request.env['PATH_INFO'].split('/')[1] == "api"
  end

  # GET /vendors/1
  def show
    render json: @vendor if request.env['PATH_INFO'].split('/')[1] == "api"
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
  end

  # POST /vendors
  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to @vendor, notice: 'Vendor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vendors/1
  def update
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: 'Vendor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vendors/1
  def destroy
    @vendor.destroy
    redirect_to vendors_url, notice: 'Vendor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      begin
        @vendor = Vendor.find(params[:id])
      rescue => e
        render json: e, status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def vendor_params
      params.require(:vendor).permit(:name, :phone)
    end
end
