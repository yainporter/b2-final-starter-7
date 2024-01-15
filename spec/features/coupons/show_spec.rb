require "rails_helper"

RSpec.describe "coupon show" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    @coupon1 = Coupon.create!(coupon: "10% Off!", amount_off: 10, merchant_id: @merchant1.id, unique_code: "10off", percent: true)
    @coupon2 = Coupon.create!(coupon: "Buy one, get one 50% off", amount_off: 50, merchant_id: @merchant1.id, unique_code: "BOGO50", percent: true)
    @coupon3 = Coupon.create!(coupon: "Welcome", amount_off: 20, merchant_id: @merchant1.id, unique_code: "welcome20", percent: true)

    visit merchant_coupon_path(@merchant1.id, @coupon1.id)
  end

  describe "User Story 3 - Merchant Coupon Show Page" do
    it "displays the coupon's name and code" do
      expect(page).to have_content("10% Off! Coupon Details")
      expect(page).to have_content("Code: 10OFF")

      visit merchant_coupon_path(@merchant1.id, @coupon2.id)

      expect(page).to have_content("Buy one, get one 50% off Coupon Details")
      expect(page).to have_content("Code: BOGO50")
    end

    it "displays the coupon's percent/dollar off value" do
      expect(page).to have_content("Coupon Value: 10 percent off")

      visit merchant_coupon_path(@merchant1.id, @coupon2.id)

      expect(page).to have_content("Coupon Value: 50 percent off")
    end

    it "displays coupon's status (active or inactive)" do
      coupon2 = Coupon.create!(coupon: "Buy one, get one 50% off", amount_off: 50, merchant_id: @merchant1.id, unique_code: "BOGO50", percent: true, status: 0, transactions: 5)

      expect(page).to have_content("Coupon Status: inactive")

      visit merchant_coupon_path(@merchant1.id, coupon2.id)

      expect(page).to have_content("Coupon Status: active")
    end

    it "displays how many times the coupon has been used" do
      coupon2 = Coupon.create!(coupon: "Buy one, get one 50% off", amount_off: 50, merchant_id: @merchant1.id, unique_code: "BOGO50", percent: true, status: "active", transactions: 5)

      expect(page).to have_content("Successful transactions: 0")

      visit merchant_coupon_path(@merchant1.id, coupon2.id)

      expect(page).to have_content("Successful transactions: 5")
    end
  end
end
