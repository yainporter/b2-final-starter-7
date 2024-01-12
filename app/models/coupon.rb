class Coupon < ApplicationRecord
  validates_presence_of :coupon
                        :amount_off
  belongs_to :merchant
end
