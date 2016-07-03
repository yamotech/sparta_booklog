class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(
      book_id: params[:book_id],
      uzer_id: current_user.id,
      body: review_params["body"]
    )
    if @review.save
      redirect_to book_url(@review.book)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end
end
