class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
private  
    DUsers = {"admin" => "paatrunt"}  
    def digest_authenticate  
        realm = "application"  
        authenticate_or_request_with_http_digest(realm) do |name|  
        DUsers[name]  
    end  
  end
end
