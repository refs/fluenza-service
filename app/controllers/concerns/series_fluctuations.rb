# -*- encoding : utf-8 -*-

module SeriesFluctuations
  extend ActiveSupport::Concern

  def group_fluctuations(target)
    account_snapshots
        .group("DATE_TRUNC('day', created_at)")
        .sum(target.to_sym)
        .sort
        .reverse
  end

  def format_fluctuations(base, raw_data)
    raw_data.each_with_index do |el, i|
      variation = base - el[1].to_i
      formatted_date = raw_data[i][0].strftime('%-d/%-m/%y')
      raw_data[i][0] = formatted_date
      raw_data[i][1] = variation
      base -= variation
    end
  end
end
