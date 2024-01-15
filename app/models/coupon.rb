class Coupon < ApplicationRecord
  validates_presence_of :coupon,
                        :amount_off,
                        :unique_code
  validates :unique_code, uniqueness: {case_sensitive: false}
  validates_inclusion_of :percent, in: [true, false]

end
