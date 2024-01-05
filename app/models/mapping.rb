class Mapping < ApplicationRecord
  after_initialize :set_default_hit_count

  private def set_default_hit_count
    self.hit_count = 0
  end
end
