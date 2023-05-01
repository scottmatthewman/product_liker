# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like do
  it { is_expected.to validate_presence_of(:article_id) }
  it { is_expected.to validate_numericality_of(:article_id).only_integer.is_greater_than(0) }

  describe '.count_for' do
    it 'returns the number of likes for the given article' do
      article_id = 1_234
      create_list(:like, 43, article_id:)

      expect(described_class.count_for(article_id)).to eq(43)
    end

    it 'returns 0 when there are no likes for the given article' do
      article_id = 9_876

      expect(described_class.count_for(article_id)).to eq(0)
    end
  end

  describe '.all_counts' do
    it 'returns a hash of article IDs and their like counts' do
      create_list(:like, 43, article_id: 1_234)
      create_list(:like, 12, article_id: 5_678)

      all_counts = described_class.all_counts

      expect(all_counts).to include(1_234 => 43, 5_678 => 12)
    end

    it 'returns zero for an article ID with no likes' do
      create_list(:like, 43, article_id: 1_234)
      create_list(:like, 12, article_id: 5_678)

      all_counts = described_class.all_counts

      expect(all_counts[9_012]).to eq(0)
    end
  end
end
