class Coupon < ApplicationRecord
  has_many :invoices
  validates_presence_of :coupon,
                        :amount_off,
                        :unique_code
  validates :unique_code, uniqueness: {case_sensitive: false}
  validates_inclusion_of :percent, in: [true, false]

  enum status: [:active, :inactive]

  def successful_transactions
    invoices.joins(:transactions).where("transactions.result = ?", "1").count
  end

  def percent?
    percent
  end
end
