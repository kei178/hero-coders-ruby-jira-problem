# frozen_string_literal: true

require_relative './lib/jira/issue_checklist/client'
require_relative './lib/jira/issue_checklist/formatter'

# Fetch data from the Issue Checklist project
jira = Jira::IssueChecklist::Client.new
components = jira.components_without_lead
component_names = components.map { |c| c['name'] }
issues = jira.issues_by(component_names)

# Print data in a human-readable form
formatter = Jira::IssueChecklist::Formatter.new(components, issues)
formatter.print
