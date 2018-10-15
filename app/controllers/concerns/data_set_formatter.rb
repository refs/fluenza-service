module DataSetFormatter
  extend ActiveSupport::Concern

  # Items
  def item_data_set(dataset)
    payload = {}
    payload[:labels] = []
    payload[:data] = []
    dataset.each do |duple|
      payload[:labels] << duple[0]
      payload[:data]   << duple[1]
    end
    payload
  end

  # Compound of items (a.k.a: campaign)
  def campaign_data_set(dataset)
    payload = {}
    payload[:labels] = []
    payload[:data] = []
    dataset.map do |ds|
      tmp_labels = []
      tmp_data = []
      ds.shift
      ds.each do |duple|
        duple.flatten.select do |el|
          tmp_labels << el if el.class == String
          tmp_data << el if el.class == Fixnum
        end
        payload[:labels] << tmp_labels.reverse
        payload[:data] << tmp_data.reverse
      end
    end
    payload[:labels] = payload[:labels].sort_by(&:length).reverse[0]
    campaign_add_padding(payload)
    payload
  end

  def campaign_add_padding(payload)
    return if payload[:data].empty?
    max_length = 0
    payload[:data].each {|ds| max_length = ds.length if ds.length > max_length }
    payload[:data].each do |ds|
      (ds.length + 1).upto(max_length) { |_| ds.unshift(0) } if ds.length < max_length
    end
    expand_with_zeros(payload)
  end

  def expand_with_zeros(payload)
    campaign = Campaign.find(params[:id])
    last_payload_date = Date.strptime(payload[:labels].last, '%d/%m/%y')
    end_campaign_date = campaign.end_date.to_date
    last_payload_date.upto(end_campaign_date) do |date|
      payload[:labels] << date.strftime('%d/%m/%y')
      payload[:data].each { |d| d << 0 }
    end
    normalize_before_send(payload)
  end

  def normalize_before_send(payload)
    payload[:labels].each_with_index do |e, i|
      tmp = e.split('/')
      tmp.pop
      payload[:labels][i] = tmp.join('/')
    end
  end
end
