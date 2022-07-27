# frozen_string_literal: true

require_relative 'lib/log_analyzer'
require 'byebug'

log_analyzer = LogAnalyzer.new(ARGV[0])
if log_analyzer.valid?
  log_analyzer.analyze
  puts "Most page views #{log_analyzer.most_page_views}"
  puts "Most uniq page views #{log_analyzer.unique_page_views}"
else
  puts log_analyzer.errors.full_messages.to_sentence
end
