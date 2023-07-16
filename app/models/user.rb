class User < ApplicationRecord
  # Include Clearance modules for authentication
  include Clearance::User

  serialize :blocked_sources, Array

  def block_source(source)
    self.blocked_sources << source
    self.save
  end

  def unblock_source(source)
    self.blocked_sources.delete(source)
    self.save
  end

  def source_blocked?(source)
    self.blocked_sources.include?(source)
  end

  # Validation example: Ensure unique email addresses
  validates :email, uniqueness: true

end
