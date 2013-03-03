class StaticController < ApplicationController
  def index
  end
  def help
    add_crumb I18n.t('misc.help'), help_path
  end
end
