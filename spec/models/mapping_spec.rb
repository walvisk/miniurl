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

  context "when no og_url provided" do
    it "raises an error" do
      mapping = Mapping.new(key: SecureRandom.alphanumeric(8))
      expect { mapping.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "when invalid og_url provided" do
    it "raises an error" do
      mapping = Mapping.new(key: SecureRandom.alphanumeric(8), og_url: "just text")
      expect { mapping.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "key parameter" do
    context "when no key provided" do
      it "raises an error" do
        mapping = Mapping.new(og_url: "https://github.com/rspec/rspec-rails")
        expect { mapping.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when key more then 8 characters" do
      it "raises an error" do
        mapping = Mapping.new(og_url: "https://github.com/rspec/rspec-rails", key: SecureRandom.alphanumeric(9))
        expect { mapping.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when create record but key already exist" do
      it "raises an error" do
        key = SecureRandom.alphanumeric(8)

        mapping = Mapping.new(og_url: "https://github.com/rspec/rspec-rails", key: key)
        mapping.save!

        mapping2 = Mapping.new(og_url: "https://github.com/rspec/rspec-rails", key: key)
        expect { mapping2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
