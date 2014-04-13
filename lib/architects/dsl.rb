require 'rspec_api_documentation' unless defined?(RspecApiDocumentation)
require 'rspec_api_documentation/dsl'

def self.feature(*args, &block)
  options = if args.last.is_a?(Hash) then args.pop else {} end
  options[:api_doc_dsl] = :feature
  options[:resource_name] = args.first
  options[:document] ||= :all
  args.push(options)
  describe(*args, &block)
end

module Architects::DSL

end

require 'architects/dsl/feature' unless defined?(Architects::DSL::Feature)

RSpec.configuration.include Architects::DSL::Feature, :api_doc_dsl => :feature
RSpec.configuration.backtrace_exclusion_patterns << %r{lib/architects/dsl\.rb}
