class User < ActiveRecord::Base
  attr_accessible :email, :password
  CIPHER = Gibberish::AES.new(ENV["GIBBERISH"])

  def subscriptions
    request = HTTParty.get(
      "https://api.feedbin.me/v2/subscriptions.json",
      :basic_auth => auth
    )
    if request.response.code == "200"
      request.parsed_response
    else
      []
    end
  end

  def password=(password)
    self.encrypted_password = CIPHER.enc(password)
  end
  
  private

  def auth
    {
      :username => email,
      :password => password
    }
  end

  def password
    CIPHER.dec(self.encrypted_password)
  end

end
