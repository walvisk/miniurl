class Mapping < ApplicationRecord
  validates :hit_count, presence: true
  validates :key, presence: true, length: { is: 8 }, uniqueness: true
  validates :og_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  after_initialize :set_default_hit_count

  private def set_default_hit_count
    self.hit_count = 0
  end
end
