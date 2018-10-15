# -*- encoding : utf-8 -*-
module ApplicationHelper
  def show_svg(path)
    File.open("public/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
