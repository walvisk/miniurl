require 'securerandom'

class MappingsController < ApplicationController
  def create
    original_url = mappings_param[:og_url]
    mapping_url = MappingCreationJob.perform_now(original_url)

    render(json: {root_url: root_url, key: mapping_url.key})
  rescue StandardError
    head :bad_request
  end

  private def mappings_param
    params.require(:mapping).permit(:og_url)
  end
end
