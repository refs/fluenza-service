module ResourceData
  include ActiveSupport::Concern

  def views_fluctuation
    return [] if !self.video_snapshots.any?
    base = self.view_count
    views_from_snapshots = group_and_sum_video_attribute("view_count")
    series_formatter(base, views_from_snapshots).reverse
  end

  def likes_fluctuation
    return [] if !self.video_snapshots.any?
    base = self.like_count
    likes_from_snapshots = group_and_sum_video_attribute("like_count")
    series_formatter(base, likes_from_snapshots).reverse
  end

  def ig_likes_fluctuation
    return [] if !self.post_snapshots.any?
    base = self.like_count
    likes_from_snapshots = group_and_sum_post_attribute("like_count")
    series_formatter(base, likes_from_snapshots).reverse
  end

  private

  def group_and_sum_video_attribute(target)
    self.video_snapshots
      .group("DATE_TRUNC('day', created_at)")
      .sum(target.to_sym)
      .sort
      .reverse
  end

  def group_and_sum_post_attribute(target)
    self.post_snapshots
      .group("DATE_TRUNC('day', created_at)")
      .sum(target.to_sym)
      .sort
      .reverse
  end

  def series_formatter(base, raw_data)
    # pls fix me im 1 ugly line
    first_date = (Date.parse(raw_data[-1][0].strftime("%-y/%-m/%d")) - 1.day).strftime("%-d/%-m/%y")
    raw_data.each_with_index do |el, i|
      variation = base - el[1].to_i
      formatted_date = el[0].strftime("%-d/%-m/%y")
      raw_data[i][0] = formatted_date
      raw_data[i][1] = variation
      base -= variation
    end
    base_point = [first_date, base]
    raw_data.append(base_point)
  end
end
