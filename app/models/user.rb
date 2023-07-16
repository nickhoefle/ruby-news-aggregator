# app/models/user.rb
class User < ApplicationRecord
  # Include Clearance modules for authentication
  include Clearance::User

  # Add a column to store blocked sources as an array
  serialize :blocked_sources, Array

  # Validation example: Ensure unique email addresses
  validates :email, uniqueness: true

  # Add any additional validations or associations as needed
end
