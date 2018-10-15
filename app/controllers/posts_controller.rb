# -*- encoding : utf-8 -*-

class PostsController < ApplicationController
  def index
    @influencer = Influencer.friendly.find(params[:influencer_id])
    @posts = @influencer
      .account
      .posts
      .order('published_at DESC')
      .paginate(:page => params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
end
