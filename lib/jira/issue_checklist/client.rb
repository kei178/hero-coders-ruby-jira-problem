# frozen_string_literal: true

require 'json'
require 'net/http'

module Jira
  module IssueChecklist
    # Client to fetch data from the Issue Checklist project
    class Client
      BASE_URL = 'https://herocoders.atlassian.net/rest/api/3'
      PROJECT_NAME = 'IC'

      def components
        fetch("#{BASE_URL}/project/IC/components")
      end

      def components_without_lead
        components.reject { |c| c.key?('lead') }
      end

      def issues_by(component_names)
        return [] if component_names.empty?

        component_names.map! { |name| "'#{name}'" }
        jql = <<~JQL
          project='#{PROJECT_NAME}' AND component IN (#{component_names.join(', ')})
        JQL

        fetch("#{BASE_URL}/search?jql=#{jql}")['issues']
      end

      private

      def fetch(url)
        uri = URI.parse(url)
        res = Net::HTTP.get(uri)
        JSON.parse(res)
      end
    end
  end
end
