# frozen_string_literal: true

require_relative './lib/jira/issue_checklist/client'

# Fetch data from the Issue Checklist project
jira = Jira::IssueChecklist::Client.new
# puts "--"
puts JSON.pretty_generate(jira.components_without_lead.count)
# puts "--"
puts JSON.pretty_generate(jira.issues)

# Print data in a human-readable form