class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :checkActiveTab
  
  http_basic_authenticate_with name: "dhh", password: "secret"
  
protected
  def setActiveTab(tab)
    session[:activeTab] = tab
    @activeTab = tab
  end
private
  def checkActiveTab 
    @activeTab = session[:activeTab] || :inscribed
  end
end
