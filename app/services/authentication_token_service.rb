require 'jwt'

class AuthenticationTokenService
    HMAC_SECRET = "gps_key"
    ALGORITHM_TYPE = 'HS256'

    def self.call
        payload = {"test" => "blah"}

        JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    end
end 