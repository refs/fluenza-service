# -*- encoding : utf-8 -*-

class Graphs::PostsController < Graphs::ApplicationController
  include Graphable

  def likes_fluctuation
    post = Post.find(params[:id])
    data = post.ig_likes_fluctuation
    payload = split_values_and_labels(data)
    render json: payload, head: :ok
  end
end
