# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
  before_action :user_is_admin, except: [:profile]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @youtube_auth_url = Yt::Account.new(
      scopes: YOUTUBE_SCOPES,
      redirect_uri: YOUTUBE_REDIRECT_URI).authentication_url
    @instagram_auth_url = Instagram.authorize_url(
      redirect_uri: INSTAGRAM_REDIRECT_URI
    )
  end

  def profile
    @profile = current_user.profile
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to root_path if @user.destroy
  end

  private

  def user_is_admin
    redirect_to root_path unless current_user.has_role?(:admin)
  end
end
