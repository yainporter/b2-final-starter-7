class CouponsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :update]

  def index
    @coupons = Coupon.all
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new

  end

  def create
    coupon = Coupon.new(coupon_params)
    create_sad_paths(coupon)
  end

  def update
    @coupon = Coupon.find(params[:id])
    if coupon_params.empty?
      @coupon.update(status: params[:coupon][:status])

      render :show
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:coupon, :amount_off, :percent, :unique_code, :merchant_id)
  end

  def create_sad_paths(coupon)
    if Coupon.count >= 5
      redirect_to merchant_coupons_path(params[:merchant_id]), notice: "Coupon not created, you already have 5 or more coupons!"
    elsif coupon.save
      redirect_to merchant_coupons_path(params[:merchant_id]), notice: "New coupon created!"
    else
      flash[:alert] = "Coupon not created: #{coupon.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
