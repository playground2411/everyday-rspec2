class HomeController < ApplicationController
  # これでこのcontrollerの中では認証をスキップできるんだね
  skip_before_action :authenticate_user!

  def index
  end
end
