require 'omniauth-oauth2'

module OmniAuth
    module Strategies
        class Dataporten < OmniAuth::Strategies::OAuth2
            option :name, "dataporten"

            option :client_options, {
                    site: "https://auth.dataporten.no",
                    authorize_url: "/oauth/authorization",
                    token_url: "/oauth/token"
            }

            option :redirect_url

            uid { raw_info['user']['userid'] }

            info do
                {
                    name:           raw_info['user']['name'],
                    username:       raw_info['user']['userid'],
                    email:          raw_info['user']['email'],
                    image:          raw_info['user']['profilepicture']
                }
            end

            extra do
                { raw_info: raw_info }
            end

            def raw_info
                @raw_info ||= access_token.get('/userinfo').parsed
            end

            private

            def callback_url
                full_host + script_name + callback_path
            end

            #def request_phase
            #       options[:response_type] ||= 'code'
	        #       super   
            #end
        end
    end
end
