module Graphable
  extend ActiveSupport::Concern

  def split_values_and_labels(dataset)
    payload = {}
    payload[:labels] = []
    payload[:data] = []
    dataset.each do |duple|
      payload[:labels] << duple[0]
      payload[:data]   << duple[1]
    end
    payload
  end
end
