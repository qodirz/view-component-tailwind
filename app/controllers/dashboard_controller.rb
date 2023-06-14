class DashboardController < ApplicationController
  def index; end

  def buttons; end

  def alerts; end

  def attributes; end

  def avatar
    @image_url = ActionController::Base.helpers.asset_path('avatar.png')
  end
end
