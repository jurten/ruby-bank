class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = :es
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403.html", formats: [:html], status: 403, layout: false
  end



end
