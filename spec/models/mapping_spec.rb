require 'rails_helper'
require 'securerandom'

RSpec.describe Mapping, type: :model do
  it "should creates valid data" do
    mapping = Mapping.new(
      og_url: "https://github.com/rspec/rspec-rails",
      key: SecureRandom.alphanumeric(8),
      hit_count: 0
    )
    mapping.save!
    mapping.reload

    expect(mapping.id).not_to be_nil
    expect(mapping.og_url).to eq("https://github.com/rspec/rspec-rails")
    expect(mapping.hit_count).to eq(0)
  end

  context "when no hit_count provided" do
    it "should creates valid data with 0 hit_count" do
      mapping = Mapping.new(
        og_url: "https://github.com/rspec/rspec-rails",
        key: SecureRandom.alphanumeric(8),
      )

      mapping.save!
      mapping.reload

      expect(mapping.id).not_to be_nil
      expect(mapping.hit_count).to eq(0)
    end
  end
end
