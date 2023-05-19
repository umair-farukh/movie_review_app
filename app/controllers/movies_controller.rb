class MoviesController < ApplicationController
  def index
    @actor = params[:actor]
    @movies = Movies::Fetch.new(@actor).call
    @actor = nil if params[:reset].present?
  end
end