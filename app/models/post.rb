class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #            NEVERMIND THE FOLLOWING - Video is a YouTube embed.

  #create separate video column in post model, then add this (uncustomized):
  # has_attached_file :video, styles: {
  #       :medium => {
  #         :geometry => "640x480",
  #         :format => 'mp4'
  #       },
  #       :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10}
  #   }, :processors => [:transcoder]
  #   validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
