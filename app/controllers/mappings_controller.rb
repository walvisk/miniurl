require 'securerandom'

class MappingsController < ApplicationController
  def create
    original_url = mappings_param[:og_url]
    rand_key = SecureRandom.alphanumeric(8)

    mapping_url = Mapping.new(
      og_url: original_url,
      key: rand_key,
      hit_count: 0
    )

    if mapping_url.valid?
      mapping_url.save!
      render :json => {:root_url => root_url, :key => mapping_url.key}
    else
      head :bad_request
    end
  end

  private def mappings_param
    params.require(:mapping).permit(:og_url)
  end
end
