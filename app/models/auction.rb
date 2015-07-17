class Auction < ActiveRecord::Base
  include AASM

  validates :title, :details, :end_date, presence: true
  validates :reserve_price, numericality: {greater_than: 1}

  after_create :set_default_for_current_price
  has_many :bids, dependent: :destroy
  has_one :winning_bid

  belongs_to :user

  aasm do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end
    event :win do
      transitions from: :published, to: :won
    end
    event :reserve_failed do
      transitions from: :published, to: :reserve_not_met
    end
    event :cancel do
      transitions from: :published, to: :cancelled
    end
  end

  def set_default_for_current_price
    self.current_price = 0
    self.save
  end

  def user_first_name
    user.first_name if user
  end

  def highest_bid
    bids.maximum("amount")
  end

end
