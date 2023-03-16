class HashtagCount < ApplicationRecord
  belongs_to :hashtag

  def self.generate_ranking(count, start_data, end_data)
    ranking = HashtagCount
              .where(date: start_data..end_data)
              .order(count: :desc)
              .limit(count)
    return ranking
  end
end
