class MappingCreationJob < ApplicationJob
  def perform(og_url)
    rand_key = SecureRandom.alphanumeric(8)

    mapping_url = Mapping.new(
      og_url: og_url,
      key: rand_key,
      hit_count: 0
    )
    mapping_url.save!
    mapping_url
  end
end
