class HomeController < ApplicationController
  def index; end

  def show
    key = params[:key]
    mapping = Mapping.find_by(key: key)
    mapping.increment!(:hit_count)

    @short_url = "#{root_url}#{key}"
    @hit_count = mapping.reload.hit_count
    @og_url = mapping.og_url
  end
end
