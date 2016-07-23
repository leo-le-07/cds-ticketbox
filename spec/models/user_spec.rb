require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { FactoryGirl.build :user }

  it "is valid with correct name, email, password" do
    expect(valid_user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryGirl.build :user, name: nil
    user.valid?
    expect(user.errors[:name]).to include "can't be blank"
  end

  it "is invalid without an email" do
    user = FactoryGirl.build :user, email: nil
    user.valid?
    expect(user.errors[:email]).to include "can't be blank"
  end

  it "is invalid with a wrong email format" do
    user = FactoryGirl.build :user, email: "myemail.com"
    user.valid?
    expect(user.errors[:email]).to include "Email format is not correct"
  end

  it "is invalid when email has already been taken" do
    valid_user.save!
    new_user = FactoryGirl.build :user, email: valid_user.email
    new_user.valid?
    expect(new_user.errors[:email]).to include "has already been taken"
  end

  it "is invalid without a password" do
    user = FactoryGirl.build :user, password: nil
    user.valid?
    expect(user.errors[:password]).to include "can't be blank"
  end
end
