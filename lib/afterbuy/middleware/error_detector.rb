module Afterbuy
  module Middleware
    class ErrorDetector < Net::HTTP

      def call(env)
        @app.call(env).on_complete do |env|
          unless (200..299).include? env[:status]
            raise APIError, env[:body]
          end
        end
      end

    end
  end
end
