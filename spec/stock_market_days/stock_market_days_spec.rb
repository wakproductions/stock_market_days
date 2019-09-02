require 'spec_helper'
require 'stock_market_days'

describe StockMarketDays do

  context '#is_market_day?' do
    subject { described_class.is_market_day?(date) }

    context 'is a market day' do
      let(:date) { Date.new(2022,1,5) }

      it { is_expected.to be_truthy }
    end

    context 'is Martin Luther King Day' do
      let(:date) { Date.new(2022,1,17) }

      it { is_expected.to be_falsey }
    end

    context 'is Presidents Day' do
      let(:date) { Date.new(2023,2,20) }

      it { is_expected.to be_falsey }
    end

    context 'is Thanksgiving' do
      let(:date) { Date.new(2023,11,23) }

      it { is_expected.to be_falsey }
    end

    context 'is Christmas (observed)' do
      let(:date) { Date.new(2027,12,24) }

      it { is_expected.to be_falsey }
    end
  end

  context '#market_days_between' do
    subject { described_class.market_days_between(begin_date, end_date) }

    context 'pure trading days' do
      let(:begin_date) { Date.new(2020,4,20) }
      let(:end_date) { Date.new(2020,5,27) }

      it { is_expected.to eql(26) }
    end

    context 'end date on a weekend' do
      let(:begin_date) { Date.new(2020,4,20) }
      let(:end_date) { Date.new(2020,5,31) }

      it { is_expected.to eql(28) }
    end

    context 'end date is less than begin date' do
      let(:begin_date) { Date.new(2020,5,31) }
      let(:end_date) { Date.new(2020,4,20) }

      it { expect { subject }.to raise_error }
    end
  end

end