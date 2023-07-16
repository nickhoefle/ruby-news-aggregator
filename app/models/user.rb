class User < ApplicationRecord
  # Include Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add an attribute to store the blocked sources
  serialize :blocked_sources, Array
end
