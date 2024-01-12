class Coupon < ApplicationRecord
  validates_presence_of :coupon,
                        :amount_off

end
