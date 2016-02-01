class HomeController < ApplicationController
    include AuthHelper
    def index
        @login_url = get_login_url
    end
end
