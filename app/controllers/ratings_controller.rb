class RatingsController < ApplicationController

	after_action :verify_authorized

  def update
    @rating = Rating.find(params[:id])
    @homework = @rating.homework

    authorize @homework.part.course

    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end