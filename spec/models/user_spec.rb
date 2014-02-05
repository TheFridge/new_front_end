require 'spec_helper'

describe User do

  it "must have an email" do 
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end
end
