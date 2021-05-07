## Solutions

- `./lib/jira/issue_checklist/client.rb`: Fetch data from the Issue Checklist project
- `./lib/jira/issue_checklist/formatter.rb`: Print fetched data in a human-readable form

## Run

The following command prints a list of components that don't have a "component lead", along with the number of issues from the Issue Checklist project to the console.

```
ruby main.rb
```

## Test

```
rspec
```

## Problem to solve:

Please create Ruby code that uses Jira REST API to retrieve data from the Issue Checklist project, and outputs in human-readable form (to the console or a file) a list of components that don't have a "component lead", along with the number of issues from the Issue Checklist project which belongs to the component.

### Requirements:

- Please use the REST API endpoints listed above (don't use other endpoints)
- Please use as few resources as possible and optimize the code to perform as few API requests as possible
- You can use Ruby and any external gems that will help you achieve the task
- The quality of the solution should be “production” like
- Tests are always welcome but not required
- Please send the source code as a link to GitHub, or any other service of your choice
- Please attach the output/answer produced by your code as an attachment