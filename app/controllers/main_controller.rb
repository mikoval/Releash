class MainController < ApplicationController
  before_filter :check_for_mobile
    layout :resolve_layout

  def home
  end
end
