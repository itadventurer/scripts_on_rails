class ApplicationController < ActionController::Base
  protect_from_forgery
  add_crumb I18n.t('misc.home'), '/'
end
