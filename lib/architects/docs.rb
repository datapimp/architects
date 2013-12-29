module Architects
  module Docs
    class << self
      def find_screen id
        resource_map.fetch(id.gsub('.json',''))
      end

      def screen_ids
        @screen_ids = resources.map(&:id)
      end

      def resource_map
        resources
        @resource_map
      end

      def resources
        @resource_map = {}

        @resources = Hashie::Mash.new(index.screens.inject({}) do |memo,resource|
          category, list = resource

          memo[category] = list.map do |screen|
            screen[:category] = category
            id = screen[:id] = screen.link.gsub('.json','')
            @resource_map[id] = Architects::Docs::Screen.new(screen)
            @resource_map[id]
          end

          memo
        end)
      end

      def screens_for_category resource_name
        resources.fetch(resource_name)
      end

      def category_names
        index.screens.keys
      end

      def screens
        resources.values.flatten
      end

      def index
        @index_json = JSON.parse IO.read(Architects.root.join("index.json"))
        @index = Hashie::Mash.new(@index_json)
      end
    end
  end
end

require 'architects/docs/screen'
