# frozen_string_literal: true

require 'json'
require 'net/http'

module Jira
  module IssueChecklist
    # Client to fetch data from the Issue Checklist project
    class Client
      BASE_URL = 'https://herocoders.atlassian.net/rest/api/3'
      PROJECT = 'IC'

      def components
        fetch "#{BASE_URL}/project/IC/components"
      end

      def components_without_lead
        components.reject { |c| c.key?('lead') }
      end

      def issues_by(components)
        return [] if components.empty?

        jql = <<~JQL
          project='#{PROJECT}' AND component IN (#{components.join(', ')})
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
