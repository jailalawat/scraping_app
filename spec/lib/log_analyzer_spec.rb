# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/shared_examples/page_views'

RSpec.describe LogAnalyzer do
  describe 'initialization without the log file' do
    it 'raises file cant be blank error' do
      log_analyzer = described_class.new('')
      expect(log_analyzer.valid?).to eq(false)
      expect(log_analyzer.errors.full_messages.to_sentence).to eq("File can't be blank")
    end

    it 'raises file not found error' do
      log_analyzer = described_class.new('/fixtures/test.log')
      expect(log_analyzer.valid?).to eq(false)
      expect(log_analyzer.errors.full_messages.to_sentence).to eq('File not found')
    end

    it 'raises invalid file error' do
      log_analyzer = described_class.new('spec/fixtures//test.txt')
      expect(log_analyzer.valid?).to eq(false)
      expect(log_analyzer.errors.full_messages.to_sentence).to eq('File is invalid')
    end
  end

  context 'analyze and execute the log file' do
    let(:file_path) { 'spec/fixtures/sample.log' }
    let(:log_analyzer) { described_class.new(file_path) }
    before { log_analyzer.analyze }

    describe '#analyze' do
      let(:expected_datas) do
        {
          "/contact"=>["184.123.665.067", "184.123.665.067", "543.910.244.929"], 
          "/home"=>["184.123.665.067", "235.313.352.950", "316.433.849.805", "316.433.849.805"], 
          "/about/2"=>["444.701.448.104", "444.701.448.104", "836.973.694.403", "836.973.694.403", "836.973.694.403"]
        }
      end

      it 'analyze the data correctly' do
        expect(log_analyzer.datas).to eq(expected_datas)
      end
    end

    describe '#most_page_views' do
      before { log_analyzer.analyze }
      let(:expected_datas) do
        { "/about/2"=> 10, "/home"=> 8, "/contact"=> 6 }
      end

      include_examples 'Page views', 'most_page_views'

      it 'should stub most_page_views' do
        log_analyzer1 = double('log_analyzer1')
        allow(log_analyzer1).to receive(:most_page_views) { expected_datas }

        expect(log_analyzer.most_page_views).to eq(log_analyzer1.most_page_views)
      end
    end

    describe '#most_uniq_page_views' do
      before { log_analyzer.analyze }
      let(:expected_datas) do
        {"/about/2"=>2, "/contact"=>2, "/home"=>3}
      end

      include_examples 'Page views', 'unique_page_views'
    end
  end
end
