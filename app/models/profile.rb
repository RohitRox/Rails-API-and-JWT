class Profile < ActiveRecord::Base
  belongs_to :user

  before_save :set_default_avatar_url

  DEFAULT_AVATARS =
  %w(
      http://lorempixel.com/output/people-q-c-120-120-5.jpg
      http://lorempixel.com/output/food-q-c-120-120-9.jpg
      http://lorempixel.com/output/technics-q-c-120-120-7.jpg
      http://lorempixel.com/output/city-q-c-120-120-4.jpg
      http://lorempixel.com/output/nature-q-c-120-120-6.jpg
      http://lorempixel.com/output/animals-q-c-120-120-8.jpg
    )

  def as_json(options)
    super({:except => [:id]}.merge(options))
  end

  private
    def set_default_avatar_url
      unless self.avatar_url.present?
        self.avatar_url = DEFAULT_AVATARS.sample
      end
    end
end
