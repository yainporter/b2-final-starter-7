require "rails_helper"

RSpec.describe "coupon index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
    @merchant3 = Merchant.create!(name: 'Office Space')
    @merchant4 = Merchant.create!(name: 'The Office')
    @merchant5 = Merchant.create!(name: 'Office Improvement')
    @merchant6 = Merchant.create!(name: 'Pens & Stuff')

    @coupon1 = Coupon.create!(coupon: "10% Off!", amount_off: 10, merchant_id: @merchant1.id, unique_code: "10off", percent: true)
    @coupon2 = Coupon.create!(coupon: "Buy one, get one 50% off", amount_off: 50, merchant_id: @merchant1.id, unique_code: "BOGO50", percent: true, status: 0)
    @coupon3 = Coupon.create!(coupon: "Welcome", amount_off: 20, merchant_id: @merchant1.id, unique_code: "welcome20", percent: true)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @item_9 = Item.create!(name: "Whiteboard", description: "Erasable", unit_price: 30, merchant: @merchant3)
    @item_10 = Item.create!(name: "Marker", description: "Erasable", unit_price: 3, merchant: @merchant4)
    @item_11 = Item.create!(name: "Eraser", description: "Felt", unit_price: 6, merchant: @merchant5)
    @item_12 = Item.create!(name: "Sharpie", description: "Permanent", unit_price: 4, merchant: @merchant6)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon1.id)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon2.id)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon_id: @coupon1.id)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon_id: @coupon3.id)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2, coupon_id: @coupon1.id)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2, coupon_id: @coupon2.id)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1, coupon_id: @coupon2.id)
    @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 2, coupon_id: @coupon3.id)
    @invoice_9 = Invoice.create!(customer: @customer_1, status: 2, coupon: @coupon3)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2, created_at: "2012-03-28 14:54:09")
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1, created_at: "2012-03-30 14:54:09")
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-01 14:54:09")
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1, created_at: "2012-04-02 14:54:09")
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1, created_at: "2012-04-03 14:54:09")
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_9.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")
    @ii_12 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_10.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")
    @ii_13 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_11.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")
    @ii_14 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_12.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)
    @transaction9 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_9.id)

    visit merchant_coupons_path(@merchant1.id)
  end

  describe "User Story 1 - Merchant Coupons Index" do
    it "has a list of all my coupon names including their amount off" do
      expect(page).to have_content("Welcome - 20%")
      expect(page).to have_content("Buy one, get one 50% off")
      expect(page).to have_content("10% Off! - 10%")
    end

    it "has a link to each coupon's show page as it's name" do
      expect(page).to have_link("Welcome")
      expect(page).to have_link("Buy one, get one 50% off")
      expect(page).to have_link("10% Off!")

      click_link("Welcome")
      expect(page.current_path).to eq(merchant_coupon_path(@merchant1.id,@coupon3.id))
    end
  end

  describe "User Story 2 - Merchant Coupon Create" do
    it "has a link to create a new coupon" do
      expect(page).to have_link("Create New Coupon")
      click_link("Create New Coupon")
      expect(page.current_path).to eq(new_merchant_coupon_path(@merchant1.id))
    end
  end

  describe "User Story 6 - Merchant Coupon Index Sorted" do
    it "separates active and inactive coupons" do
      coupon1 = Coupon.create!(coupon: "New User", amount_off: 20, merchant_id: @merchant1.id, unique_code: "welcome20", percent: true, status: 0)
      with
    end
  end
end
