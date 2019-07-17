# frozen_string_literal: true

def fetch_public_key
  jwks_raw = Net::HTTP.get URI("#{Rails.application.credentials.auth0[:domain]}.well-known/jwks.json")
  Array(JSON.parse(jwks_raw)['keys']).first['x5c'].first
end

Knock.setup do |config|
  ## Expiration claim
  ## ----------------
  ##
  ## How long before a token is expired. If nil is provided, token will
  ## last forever.
  ##
  ## Default:
  # config.token_lifetime = 1.day

  ## Audience claim
  ## --------------
  ##
  ## Configure the audience claim to identify the recipients that the token
  ## is intended for.
  ##
  ## Default:
  config.token_audience = -> { Rails.application.credentials.auth0[:api_audience] }

  ## If using Auth0, uncomment the line below
  # config.token_audience = -> { Rails.application.secrets.auth0_client_id }

  ## Signature algorithm
  ## -------------------
  ##
  ## Configure the algorithm used to encode the token
  ##
  ## Default:
  config.token_signature_algorithm = 'RS256'

  ## Signature key
  ## -------------
  ##
  ## Configure the key used to sign tokens.
  ##
  ## Default:
  config.token_secret_signature_key = -> { Rails.application.credentials.auth0[:client_secret] }

  ## If using Auth0, uncomment the line below
  # config.token_secret_signature_key = -> { JWT.base64url_decode Rails.application.secrets.auth0_client_secret }

  ## Public key
  ## ----------
  ##
  ## Configure the public key used to decode tokens, if required.
  ##
  ## Default:
  config.token_public_key = OpenSSL::X509::Certificate.new(Base64.decode64(fetch_public_key)).public_key

  ## Exception Class
  ## ---------------
  ##
  ## Configure the exception to be used when user cannot be found.
  ##
  ## Default:
  # config.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'
end
