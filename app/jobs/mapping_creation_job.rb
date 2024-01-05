require 'securerandom'
class MappingCreationJob < ApplicationJob
  def perform(og_url)
    mapping_url = Mapping.new(
      og_url: og_url,
      key: generate_key,
    )

    mapping_url.save!
    mapping_url
  end

  private def generate_key
    rand_key = generate_random_key
    loop do
      break unless Mapping.exists?(key: rand_key)
      rand_key = generate_random_key
    end

    rand_key
  end
  private def generate_random_key
    SecureRandom.alphanumeric(8)
  end
end
