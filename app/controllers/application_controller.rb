class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    add_flash_types :error

  config.time_zone = 'Eastern Time (US & Canada)'
  config.active_record.default_timezone = 'Eastern Time (US & Canada)'
end
