class Player < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  # Get all players excluding the default "Admin" player
  def self.find_all
    Player.all.where.not(name: "Admin").order(wins: :desc)
  end
end
