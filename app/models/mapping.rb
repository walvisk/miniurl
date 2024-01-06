class Mapping < ApplicationRecord
  validates :hit_count, presence: true
  validates :key, presence: true, length: { is: 8 }, uniqueness: true
  validates :og_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
