# -*- encoding : utf-8 -*-

module SeriesAbsolutes
  extend ActiveSupport::Concern

  def group_absolutes(target)
    raw_data = []
    target = account_snapshots.order('created_at DESC').map(&target.to_sym)
    dates = account_snapshots.order('created_at DESC').map(&:created_at)
    dates.each_with_index do |date, i|
      raw_data[i] = [date, target[i]]
    end
    raw_data
  end

  def format_absolutes(raw_data)
    raw_data.each_with_index do |el, i|
      formatted_date = el[0].strftime('%-d/%-m/%y')
      raw_data[i][0] = formatted_date
    end
  end
end
