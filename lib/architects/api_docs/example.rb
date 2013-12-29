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

      def response
        response_body = requests.first && requests.first.response_body
        response_body && JSON.parse(response_body)
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
