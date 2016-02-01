class FilesController < ApplicationController
    def index
        token = session[:azure_access_token]
        #logger.info = token
        if token
            # If a token is present in the session, call into graph
            conn = Faraday.new(:url => 'https://graph.microsoft.com') do |faraday|
                # Outputs to the console
                faraday.response :logger
                # Uses the default Net::HTTP adapter
                faraday.adapter  Faraday.default_adapter
            end
        
            # Get files for the user
            response = conn.get do |request|
                request.url '/v1.0/me/drive/root/children'
                request.headers['Authorization'] = "Bearer #{token}"
                request.headers['Accept'] = "application/json"
            end
        
            # Assign the resulting value to the @files
            # variable to make it available to the view template.
            @files = JSON.parse(response.body)['value']
        else
            # If no token, redirect to the root url so user
            # can sign in.
            logger.info 'Empty'
            redirect_to root_url
        end
    end
end
