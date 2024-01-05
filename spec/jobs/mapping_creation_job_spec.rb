require 'rails_helper'

RSpec.describe MappingCreationJob, type: :job do
  it "should creates valid data" do
    mapping_url = MappingCreationJob.perform_now("https://github.com/walvisk")
    expect(mapping_url.id).not_to be_nil
    expect(mapping_url.og_url).to eq("https://github.com/walvisk")
    expect(mapping_url.hit_count).to eq(0)
  end

  context "when already exist og_url" do
    it "should creates valid data" do
      mapping_url = MappingCreationJob.perform_now("https://github.com/walvisk")
      mapping_url2 = MappingCreationJob.perform_now("https://github.com/walvisk")
      expect(mapping_url2.id).not_to be_nil
      expect(mapping_url2.og_url).to eq("https://github.com/walvisk")
      expect(mapping_url2.hit_count).to eq(0)
    end
  end
end
