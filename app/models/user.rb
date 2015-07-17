class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bids, dependent: :destroy
  has_many :auctions, dependent: :destroy
  has_many :winning_bids, dependent: :nullify

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    else
      email
    end
  end

  def handle
    "@#{first_name}_#{last_name}".downcase
  end


end
