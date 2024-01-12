require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :coupon }
    it { should validate_presence_of :amount_off}
  end
end
