class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @auctions = Auction.order(updated_at: :desc)
  end

  def show
    @auction = Auction.find(params[:id])
    @bid = Bid.new
  end

  def new
    @auction = Auction.new(end_date: (DateTime.current + 1.day), current_price: 0)
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, notice: "Auction was created!"
    else
      flash[:alert] = "Could not create Auction!"
      render :new
    end
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.update(auction_params)
      redirect_to root_path, notice: "Auction was Deleted"
    end
  end

  private

  def auction_params
    params.require(:auction.permit(:title, :details, :reserve_price, :end_date))
  end

end
