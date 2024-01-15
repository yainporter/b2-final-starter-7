require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
  end
  describe "validations" do
    it { should validate_presence_of :coupon }
    it { should validate_presence_of :amount_off}
    it { should validate_presence_of :unique_code}
    subject { Coupon.new(coupon: "Welcome", amount_off: 20, merchant_id: @merchant1.id, unique_code: "welcome2056", percent: true) }
    it { should validate_uniqueness_of(:unique_code).case_insensitive}
    # How do I validate percent?
    it { should validate_inclusion_of(:percent).in_array([true, false]) }

  end
end
