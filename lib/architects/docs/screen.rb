module Architects
  module Docs
    class Screen
      attr_reader :source

      def initialize(attributes={})
        @source = Hashie::Mash.new(attributes)
        load_from_disk
      end

      def data_sources
        try(:[],:data_sources) || Hashie::Mash.new({})
      end

      def transitions
        try(:[],:transitions) || Hashie::Mash.new({})
      end

      def references
        try(:[],:references) || Hashie::Mash.new({})
      end

      def annotation_images
        list = try(:[], :annotation_images)
        list.nil? ? [screen.image] : Array(list)
      end

      def annotations
        Array(try(:[],:annotations))
      end

      def acceptance_criteria
        Array(try(:[],:acceptance_criteria))
      end

      def display_conditions
        Array(try(:[],:display_conditions))
      end

      def get_transition_link transition
        (@transition_links ||= {}).fetch(transition) do
          case
          when !transitions.nil? && transitions.send(transition)
            reference = transitions.send(transition)
            screen = Architects::Docs.find_screen(reference)
            link = screen.id
            description = screen.title
          end

          @transition_links[transition] = {
            description: description,
            link: link
          }
        end
      end

      def get_reference_link api_doc_reference
        (@reference_links ||= {}).fetch(api_doc_reference) do
          case
          when !references.nil? && references.send(api_doc_reference)
            reference = references.send(api_doc_reference)
            link = Architects::ApiDocs.find_example(reference.link)
            description = references.description || link.description
          end

          @reference_links[api_doc_reference] = {
            link: link,
            description: description
          }
        end
      end

      def method_missing meth, *args, &blk
        if source.respond_to?(meth)
          return source.send(meth,*args,&blk)
        end

        super
      end

      def last_modified_at
        File.mtime(path)
      end

      def load_from_disk
        config = from_disk
        source.deep_merge!(config)
      end

      def screen_type
        source.respond_to?('screen_type') ? source.screen_type : Architects.configuration.screen_type
      end

      def path
        Architects.root.join("#{ source.id }.json")
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
