module Architects
  module ApiDocs
    class Example
      attr_reader :source

      def initialize(attributes={})
        @source = Hashie::Mash.new(attributes)
        load_from_disk
      end

      def method_missing meth, *args, &blk
        if source.respond_to?(meth)
          return source.send(meth,*args,&blk)
        end

        super
      end

      def response_status
        requests.first && requests.first.response_status
      end

      def response_headers options={}
        headers = requests.first && requests.first.response_headers
        return headers.slice(*(Array(options[:only]))) if headers && options[:only]
        headers
      end

      def request_body_as_json
        Rack::Utils.parse_nested_query(request_body)
      end

      def request_body
        body = requests.first && requests.first.request_body
        URI.unescape(body) unless body.nil?
      end

      def request_http_method
        requests.first && requests.first.request_method
      end

      def read?
        request_http_method == "GET"
      end

      def write?
        %w{PUT PATCH DELETE POST}.include?("#{request_http_method}")
      end

      def formatted_request_path
        path = requests.first && requests.first.request_path
        path && URI.decode(path)
      end

      def response
        response_body = requests.first && requests.first.response_body

        begin
          response_body && JSON.parse(response_body)
        rescue JSON::ParserError
          response_body
        end
      end

      def last_modified_at
        File.mtime(path)
      end

      def load_from_disk
        config = from_disk
        source.deep_merge!(config)
      end

      def path
        Architects.docs_dir.join("#{ source.link }")
      end

      def from_disk
        json = IO.read(path)
        JSON.parse(json)
      end

      def exists?
        File.exists?(path)
      end
    end
  end
end
