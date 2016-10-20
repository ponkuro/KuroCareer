class TopController < ApplicationController
  def index
    respond_to do |format|
      if user_signed_in?
        format.html { render :user }
      else
        format.html { render :visitor }
      end
    end
  end
end