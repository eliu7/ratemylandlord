class ApplicationController < ActionController::Base
include GoogleHelper

  protect_from_forgery with: :exception

  CLIENT_ID = '91567460252.apps.googleusercontent.com'
  CLIENT_SECRET = 'tNP3BE7y53BLKTp0mtd-ZWqW'
  CLIENT_SCOPE = 'https://www.googleapis.com/auto/userinfo.email'
end
