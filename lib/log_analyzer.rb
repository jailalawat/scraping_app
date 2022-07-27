# frozen_string_literal: true

require 'active_model'

class LogAnalyzer
  include ActiveModel::Validations

  attr_reader :file, :datas

  validates_presence_of :file
  validate :file_exist?, if: -> { file.present? }
  validate :valid_extension?, if: -> { file.present? }

  def initialize(file)
    @file = file
    @datas = Hash.new { |k, v| k[v] = [] }
  end

  def analyze
    File.open(file, 'r') do |f|
      f.each_line do |line|
        page, ip = line.split
        datas[page] << ip
      end
    end
  end

  def most_page_views
    sort_by_descending_order(count_page_views)
  end

  def unique_page_views
    sort_by_descending_order(count_page_views(true))
  end

  private

  def file_exist?
    errors.add(:file, 'not found') unless File.exist?(file)
  end

  def valid_extension?
    ext = File.extname(file)
    errors.add(:file, 'is invalid') unless %w[.log].include? ext.downcase
  end

  def count_page_views(uniq = false)
    datas.transform_values { |v| (uniq ? v.uniq.size : v.size) }
  end

  def sort_by_descending_order(lists)
    lists.sort_by { |_k, v| -v }.to_h
  end
end
