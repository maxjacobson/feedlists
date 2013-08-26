class User < ActiveRecord::Base
  attr_accessible :email, :password
  validates_uniqueness_of :email
  validates_presence_of :email, :encrypted_password
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
    if password.present?
      # because gibberish throws an error when password isn't present
      self.encrypted_password = CIPHER.enc(password)
    end
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
