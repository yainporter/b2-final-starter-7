require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :coupon }
    it { should validate_presence_of :amount_off}
    it { should validate_presence_of :unique_code}
    # How do I validate percent?
    it { should validate_inclusion_of(:percent).in_array([true, false]) }

  end
end
