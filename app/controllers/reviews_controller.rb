class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @review = current_user.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to place_path(@review.place), notice: 'Review sukses dibuat.' }
        #format.json { render :show, status: :created, location: @review }
      else
        #format.html { render :new }
        #format.json { render json: @place.errors, status: :unprocessable_entity }
        #redirect_to place_path(@review.place), notice: "Ada sesuatu yang salah!"
        format.html {redirect_to place_path(@review.place), notice: "Ada sesuatu yang salah!" }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to place_path(@review.place), notice: 'Review sukses diedit.' }
        format.json { render :show, status: :ok, location: @place }
      else
        #format.html { render :edit }
        #format.json { render json: @place.errors, status: :unprocessable_entity }
        redirect_to place_path(@review.place), notice: "Ada sesuatu yang salah!"
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to place_path(@review.place), notice: 'Review sukses dihapus.' }
      #format.json { head :no_content }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :place_id, :score)
  end
end
