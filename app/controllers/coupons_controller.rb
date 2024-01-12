class CouponsController < ApplicationController
  def index
    @coupons = Coupon.find(params[:id])
  end
end
