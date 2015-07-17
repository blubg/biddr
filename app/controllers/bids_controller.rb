class BidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @auction = Auction.find params[:auction_id]
    @bid = @auction.bids.new
  end

  def create
    @auction = Auction.find params[:auction_id]
    @bid = @auction.bids.new(bids_params)
    @bid.auction = @auction
    @bid.user = current_user
    respond_to do |format|
      if @auction.user == current_user
        format.html {redirect_to @auction, alert: "You can't bid on your own Auction!"}
        format.js { @bid.errors.add("You can't bid on your own Auction!")
          render
        }
      elsif @bid.save
        if @bid.amount >= @auction.reserve_price
          @auction.meet_reserve
          @auction.save
        end
        format.html {redirect_to auction_path(@auction), notice: "Bid successfully created!"}
        format.js { render }
      else
        flash[:alert] = "Could not create bid"
        format.js { render }
      end
    end
  end

  private

  def bids_params
    params.require(:bid).permit(:amount)
  end
end
