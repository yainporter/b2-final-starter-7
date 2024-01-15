class CouponsController < ApplicationController
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
    if coupon.save
      redirect_to merchant_coupons_path(params[:merchant_id])
    else
      flash[:alert] = "Coupon not created: #{coupon.errors.full_messages.join(", ")}"
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:coupon, :amount_off, :percent, :unique_code, :merchant_id)
  end
end
