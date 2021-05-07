# frozen_string_literal: true

require_relative '../../../../lib/jira/issue_checklist/client'

RSpec.describe 'Jira::IssueChecklist::Client' do
  let(:jira) { Jira::IssueChecklist::Client.new }

  context '/project/IC/components' do
    before do
      body = File.read('./spec/fixtures/jira/components.json')
      stub_request(:get, /herocoders.atlassian.net/).to_return(
        status: 201, body: body, headers: { 'Content-Type': 'application/json' }
      )
    end

    describe 'components' do
      it 'returns a list of components' do
        components = jira.components
        expect(components.map { |c| c['self'].include?('component') }).to be_all
      end
    end

    describe 'components_without_lead' do
      it 'returns a list of components without lead' do
        components = jira.components_without_lead
        expect(components.map { |c| !c.key?('lead') }).to be_all
      end
    end
  end

  describe 'issues_by(component_names)' do
    before do
      body = File.read('./spec/fixtures/jira/issues.json')
      stub_request(:get, /herocoders.atlassian.net/).to_return(
        status: 201, body: body, headers: { 'Content-Type': 'application/json' }
      )
    end

    it 'returns a list of issues' do
      component_names = ['Data analysis', 'Infrastructure', 'Marketplace']
      issues = jira.issues_by(component_names)
      expect(issues.is_a?(Array)).to be_truthy
      expect(issues).to be_any
    end

    it 'returns an empty array without component names' do
      issues = jira.issues_by([])
      expect(issues).to be_empty
    end
  end
end
