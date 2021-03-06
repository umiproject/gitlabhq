require 'spec_helper'

describe Gitlab::Database, lib: true do
  # These are just simple smoke tests to check if the methods work (regardless
  # of what they may return).
  describe '.mysql?' do
    subject { described_class.mysql? }

    it { is_expected.to satisfy { |val| val == true || val == false } }
  end

  describe '.postgresql?' do
    subject { described_class.postgresql? }

    it { is_expected.to satisfy { |val| val == true || val == false } }
  end

  describe '.version' do
    context "on mysql" do
      it "extracts the version number" do
        allow(described_class).to receive(:database_version).
          and_return("5.7.12-standard")

        expect(described_class.version).to eq '5.7.12-standard'
      end
    end

    context "on postgresql" do
      it "extracts the version number" do
        allow(described_class).to receive(:database_version).
          and_return("PostgreSQL 9.4.4 on x86_64-apple-darwin14.3.0")

        expect(described_class.version).to eq '9.4.4'
      end
    end
  end
end
