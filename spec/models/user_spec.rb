require 'spec_helper'

describe User do
  let(:user) { User.new }

  it "should have an email" do
    user.email = "whatever@whatever.com"
    user.email.should eq("whatever@whatever.com")
  end

  it "should encrypt its password" do
    user.password = "abcd"
    user.encrypted_password.should_not eq("abcd")
  end


end
