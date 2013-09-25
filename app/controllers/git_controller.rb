class GitController < ApplicationController
  def pull
    @result=`cd #{APP_CONFIG['git_path']} && git pull 2>&1`
  end

  def log
    @result=`cd #{APP_CONFIG['git_path']} && git log 2>&1`
  end
end
