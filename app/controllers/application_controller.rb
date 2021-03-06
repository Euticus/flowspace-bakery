class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include CableReady::Broadcaster
  protect_from_forgery with: :exception

  before_action :basic_authenticate

  private

  def basic_authenticate
    return if Rails.env.test?

    authenticate_or_request_with_http_basic do |username, password|
      username == 'bake' && password == 'somecookies'
    end

  end

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ `/Mobile|webOS)` && `(request.user_agent !~ /iPad/`)
    end
  end
  helper_method :mobile_device?
end
