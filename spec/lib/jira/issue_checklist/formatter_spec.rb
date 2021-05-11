# frozen_string_literal: true

require_relative '../../../../lib/jira/issue_checklist/formatter'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Jira::IssueChecklist::Formatter' do
  let(:components) do
    json = File.read('./spec/fixtures/jira/components.json')
    JSON.parse(json)
  end

  let(:issues) do
    json = File.read('./spec/fixtures/jira/issues.json')
    JSON.parse(json)['issues']
  end

  let(:formatter) { Jira::IssueChecklist::Formatter.new(components, issues) }

  describe 'print' do
    it 'prints outputs to the console' do
      output = <<~TEXT
        ** Components that does not have `component lead` **
        ---
        ID: 10105
        Name: Data analysis
        Description: Insights into customer usage, tracking, analytics, metabase, etc.
        Issue Count: 9
        ---
        ID: 10104
        Name: Infrastructure
        Description: Heroku, Google Cloud, Sentry, and other tooling related stuff
        Issue Count: 9
        ---
        ID: 10103
        Name: Marketplace
        Description: Everything related to our marketplace listings
        Issue Count: 6
        ---
        ID: 10106
        Name: OpenID
        Description:#{' '}
        Issue Count: 0
      TEXT
      expect { formatter.print }.to output(output).to_stdout
    end

    it 'prints not found message when componets are empty' do
      formatter = Jira::IssueChecklist::Formatter.new([], issues)
      output = <<~TEXT
        ** Components that does not have `component lead` **
        Not found
      TEXT
      expect { formatter.print }.to output(output).to_stdout
    end
  end

  describe 'count_issues_by_component' do
    it 'returns issue counts by component' do
      counts = formatter.count_issues_by_component
      expect(counts['10105']).to eq(9)
      expect(counts['10104']).to eq(9)
      expect(counts['10103']).to eq(6)
    end
  end
end
# rubocop:enable Metrics/BlockLength
