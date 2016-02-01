module AuthHelper
# App's client ID. Register the app in Application Registration Portal to get this value.
CLIENT_ID = '893c69a7-1a0d-45bb-9673-da40f216dfbc'
# App's client secret. Register the app in Application Registration Portal to get this value.
CLIENT_SECRET = '1P4EaYGJCSs1oFEpiIRDB8FfwnJWQ1bTmp5Va3ydC7o='
# App's redirect url...where you want authorization codes returned
REDIRECT_URI = 'http://localhost:3000/authorize'

# Generates the login URL for the app.
def get_login_url
   client = OAuth2::Client.new(CLIENT_ID,
       CLIENT_SECRET,
       :site => 'https://login.microsoftonline.com',
       :authorize_url => '/common/oauth2/authorize',
       :token_url => '/common/oauth2/token')

   login_url = client.auth_code.authorize_url(
       :redirect_uri => REDIRECT_URI, :resource => 'https://graph.microsoft.com')
end

def get_token_from_code(auth_code)
   client = OAuth2::Client.new(CLIENT_ID,
       CLIENT_SECRET,
       :site => 'https://login.microsoftonline.com',
       :authorize_url => '/common/oauth2/authorize',
       :token_url => '/common/oauth2/token')

   token = client.auth_code.get_token(auth_code,
       :redirect_uri => REDIRECT_URI, :resource => 'https://graph.microsoft.com')
end
end
