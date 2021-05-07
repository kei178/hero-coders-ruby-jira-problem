# frozen_string_literal: true

module Jira
  module IssueChecklist
    # Print fetched data in a human-readable form
    class Formatter
      attr_reader :components, :issues

      def initialize(components, issues)
        @components = components
        @issues = issues
      end

      # Print components with the number of issue in human-readable form
      def print
        counts = count_issues_by_component
        puts '** Components that does not have `component lead` **'
        components.each do |component|
          puts readable_format(component, counts[component['id']])
        end
      end

      # rubocop:disable Metrics/AbcSize
      def count_issues_by_component
        counts = {}
        components.each { |c| counts[c['id']] = 0 }
        issues.each do |issue|
          next if issue['fields']['components'].nil?

          issue['fields']['components'].each do |component|
            key = component['id']
            counts[key] += 1 if counts.key?(key)
          end
        end
        counts
      end
      # rubocop:enable Metrics/AbcSize

      private

      def readable_format(component, issue_count)
        <<~TEXT
          ---
          ID: #{component['id']}
          Name: #{component['name']}
          Description: #{component['description']}
          Issue Count: #{issue_count}
        TEXT
      end
    end
  end
end
