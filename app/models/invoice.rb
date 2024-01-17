class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :coupon, optional: :true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_with_coupon
    total_revenue_with_coupon = 0
    if !coupon_id
      total_revenue_with_coupon = total_revenue
    else
      total_revenue_with_coupon = discount_total
    end
    total_revenue_with_coupon
  end

  private

  def discount_total
    coupon = Coupon.find(coupon_id)
    if coupon.active? && coupon.percent?
      total_revenue_with_coupon = total_revenue - discount_percent(coupon)
    elsif coupon.active? && !coupon.percent?
      total_revenue_with_coupon = total_revenue - coupon.amount_off
    end
  end

  def discount_percent(coupon)
    total_revenue * (coupon.amount_off * 0.01)
  end
end
