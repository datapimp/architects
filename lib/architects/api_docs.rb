module Architects
  module ApiDocs
    class << self
      def find_example example
        resource_map.fetch(example.gsub('.json',''))
      end

      def example_ids
        @example_ids ||= resources.map(&:id)
      end

      def resource_map
        resources
        @resource_map
      end

      def resources
        @resource_map = {}

        @resources = Hashie::Mash.new(index.resources.inject({}) do |memo,resource|
          memo[resource.name] = resource.examples.map do |example|
            id = example[:id] = example.link.gsub('.json','')
            @resource_map[id] = Architects::ApiDocs::Example.new(example)
            @resource_map[id]
          end

          memo
        end)
      end

      def examples_for_resource resource_name
        resources.fetch(resource_name)
      end

      def resource_names
        resources.keys
      end

      def examples
        resources.values.flatten
      end

      def index
        @index_json = JSON.parse IO.read(Architects.docs_dir.join("index.json"))
        @index = Hashie::Mash.new(@index_json)
      end
    end
  end
end

require 'architects/api_docs/example'
