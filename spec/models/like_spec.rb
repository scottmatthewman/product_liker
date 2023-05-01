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
end
