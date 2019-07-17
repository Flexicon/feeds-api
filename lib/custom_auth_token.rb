# frozen_string_literal: true

# Overrides Knock::AuthToken to provide the raw token to the from_token_payload method
class CustomAuthToken < ::Knock::AuthToken
  def entity_for(entity_class)
    entity_class.from_token_payload @payload, @token
  end
end
