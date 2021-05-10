# frozen_string_literal: true

require 'json'
require 'net/http'

module Jira
  module IssueChecklist
    # Client to fetch data from the Issue Checklist project
    class Client
      BASE_URL = 'https://herocoders.atlassian.net/rest/api/3'
      PROJECT_NAME = 'IC'
      RESULTS_PER_PAGE = 50

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

        fetch_all_pages("#{BASE_URL}/search?jql=#{jql}", 'issues')
      end

      private

      def fetch(url)
        uri = URI.parse(url)
        res = Net::HTTP.get(uri)
        JSON.parse(res)
      end

      def fetch_all_pages(url, target_field)
        results = []
        start_at = 0
        loop do
          res = fetch("#{url}&startAt=#{start_at}&maxResults=#{RESULTS_PER_PAGE}")
          total ||= res['total']
          results += res[target_field]
          break if results.count >= total

          start_at = results.count
        end

        results
      end
    end
  end
end
