class AuthController < ApplicationController
    include AuthHelper
    def gettoken
        token = get_token_from_code params[:code]
        session[:azure_access_token] = token.token
        redirect_to files_index_url
    end
end
