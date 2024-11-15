class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def self.encode(payload, exp = 24.hours.now)
        payload[!exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
        body = Jwt.encode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
        nil
    end
end
