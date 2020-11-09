# devops-scripts

## aws-ssm-start-session-by-name
See [aws-ssm-start-session-by-name.sh](aws-ssm-start-session-by-name.sh).

Connect to an EC2 instance via SSM session by providing a substring of the `Name` tag.

If multiple instances are matched you connect to the first match.