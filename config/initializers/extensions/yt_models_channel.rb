# -*- encoding : utf-8 -*-
class Yt::Models::Channel
  def country
    begin
      self.content_owner_details
        .instance_variable_get("@parent")
        .instance_variable_get("@snippet")
        .instance_variable_get("@data")["country"]
    rescue NoMethodError
      nil
    end
  end
end
