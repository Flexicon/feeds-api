# frozen_string_literal: true

# User model serialization in profile context
class ProfileSerializer < AppSerializer
  attributes :email, :name, :picture
end
