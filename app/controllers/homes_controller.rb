class HomesController < ApplicationController
  def index
    @photos = Photo.all
  end
end
