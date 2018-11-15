require 'afterbuy/net_http'

module Faraday
  class Adapter
    class AfterbuyHttp < Faraday::Adapter::NetHttp

      def net_http_connection(env)
        Afterbuy::NetHttp.new(env[:url].hostname, env[:url].port || (env[:url].scheme == 'https' ? 443 : 80))
      end

    end
  end
  Adapter.register_middleware afterbuy_http: Faraday::Adapter::AfterbuyHttp
end
