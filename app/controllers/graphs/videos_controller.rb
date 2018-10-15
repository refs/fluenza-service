# -*- encoding : utf-8 -*-

class Graphs::VideosController < Graphs::ApplicationController
  include Graphable

  def views_fluctuation
    video = Video.find(params[:id])
    data = video.views_fluctuation
    payload = split_values_and_labels(data)
    render json: payload, head: :ok
  end

  def likes_fluctuation
    video = Video.find(params[:id])
    data = video.likes_fluctuation
    payload = split_values_and_labels(data)
    render json: payload, head: :ok
  end
end
