class User < ActiveRecord::Base
  attr_accessible :email, :password
  CIPHER = Gibberish::AES.new(ENV["GIBBERISH"])

  def subscriptions
    HTTParty.get(
      "https://api.feedbin.me/v2/subscriptions.json",
      :basic_auth => auth
    )
  end

  def password=(password)
    self.encrypted_password = CIPHER.enc(password)
  end
  
  private
  
  def password
    CIPHER.dec(self.encrypted_password)
  end
  
  def auth
    {
      :username => email,
      :password => password
    }
  end

end