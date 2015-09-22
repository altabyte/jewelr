class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  # Get the locale for this request.
  def locale
    I18n.locale
  end

  #---------------------------------------------------------------------------
  private

  # Set the locale for this request.
  # Make sure to set config.i18n.available_locales = [:en, :zh] in application.rb
  def set_locale
    locale = I18n.default_locale
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
    locale = I18n.default_locale unless I18n.locale_available?(locale)
    locale = current_user.locale if current_user && current_user.locale && I18n.locale_available?(current_user.locale)
    locale = params[:locale] if params[:locale] && I18n.locale_available?(params[:locale])
    I18n.locale = locale
    #gon.locale = I18n.locale  # Set javascript variable to be used in views
  end
end
