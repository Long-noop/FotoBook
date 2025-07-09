module Users
  module Albums
    class LikesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_Album

      def create
        current_user.likes.create(likeable: @album)
        @album.reload
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to users_Albums_path }
        end
      end

      def destroy
        current_user.likes.find_by(likeable: @album)&.destroy
        @album.reload
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to users_Albums_path }
        end
      end

      private

      def set_Album
        @album = Album.find(params[:album_id])
      end
    end
  end
end
