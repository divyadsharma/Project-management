require 'rails_helper'

RSpec.describe Project, type: :model do
  # it {should belong_to(:store_user)}
  it "checks project is invalid without title" do
    project = Project.new()
    expect(project.valid?).to eq(false)
  end
  it "checks project is invalid with title only" do
    address = project.new(fname: "Ankur", lname: "Maheshwari")
    expect(address.valid?).to eq(false)
  end
  it "checks address is valid with all requirements" do
    address = FactoryBot.create(:address)
    expect(address.valid?).to eq(true)
  end
  it "checks zip is invalid with length not equal to 5" do
    address = Address.create(fname: "Ankur", lname: "Maheshwari", organization: "macbick", street1: "IT park", street2: "Bhawarkua", city: "Indore", state: "Arkansas", country: "United States of America", zip: "4200", phone: "9294879024")
    expect(address.valid?).to eq(false)
  end
  it "checks phone no. is invalid with length not equal to 10" do
    address = Address.create(fname: "Ankur", lname: "Maheshwari", organization: "macbick", street1: "IT park", street2: "Bhawarkua", city: "Indore", state: "Arkansas", country: "United States of America", zip: "42001", phone: "9294879")
    expect(address.valid?).to eq(false)
  end
  it "checks the not_deleted scope" do
    address = Address.new(fname: "Ankur", lname: "Maheshwari", organization: "macbick", street1: "IT park", street2: "Bhawarkua", city: "Indore", state: "Arkansas", country: "United States of America", zip: "42001", phone: "9294879024", deleted: false)
    address.save
    expect(Address.not_deleted.include?(address)).to eq(true)
  end
  it "checks for address details in a string" do
    address = Address.new(fname: "Ankur", lname: "Maheshwari", organization: "macbick", street1: "IT park", street2: "Bhawarkua", city: "Indore", state: "Arkansas", country: "United States of America", zip: "42001", phone: "9294879024", deleted: false)
    address.save
    expect(address.to_s).to eq([address.fname + address.lname, address.organization, address.street1, address.street2, address.city, address.state, address.country, address.zip, address.phone].join(', '))
  end
end
