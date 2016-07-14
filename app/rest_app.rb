module Rest
  class App

    def self.instance
      @instance ||= Rack::Builder.new do
        run Rest::App.new
      end.to_app
    end

    def call(env)
      # api
      response = Rest::API.call(env)

      # Serve error pages or respond with API response
      case response[0]
      when 404, 500
        response[0]
      else
        response
      end

    end
  end
end
