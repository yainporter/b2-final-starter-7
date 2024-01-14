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
    @coupon = Coupon.create!(coupon_params)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:coupon, :amount_off, :percent, :unique_code, :merchant_id)
  end
end
