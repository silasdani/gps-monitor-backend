require 'jwt'

class AuthenticationTokenService
    HMAC_SECRET = "gps_key"
    ALGORITHM_TYPE = 'HS256'

    def self.call(json)
        payload = {json: json}
        JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    end

    def self.auth(user)
        JWT.encode UserSerializer.new(user).serialized_json, HMAC_SECRET, ALGORITHM_TYPE
    end

    def self.decode(token)
        decoded_token JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
        decoded_token[0]['user_id']
    end
end 