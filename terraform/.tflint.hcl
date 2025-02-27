# .tflint.hcl

# Set to true to enable or false to disable specific checks.
# The 'enabled' block is for enabling/disabling particular linter rules.
enabled_rules = ["aws_instance_invalid_type", "aws_security_group_rule_missing_type", "terraform_unused_variables"]

# Exclude certain directories from being linted
exclude = [
  "modules/*",  # Exclude all modules from being linted
  "test/*"      # Exclude test directories
]

# Enable or disable specific resource types linting
# Example: Disable checking for unused variables in AWS resources
disable_rules = [
  "aws_security_group_rule_missing_type"
]

# Configure the directory for Terraform modules, e.g., if you store them in a specific location
module_paths = [
  "modules/*"
]

# Enable specific linters, here we are enabling the `terraform_unused_variables` rule
rule "terraform_unused_variables" {
  enabled = true
}

# You can set specific configurations for some rules
rule "aws_instance_invalid_type" {
  enabled = true
  type = "t2.micro"  # You can specify your own preferred types
}

# Example of setting a custom severity level for a rule
rule "aws_security_group_rule_missing_type" {
  severity = "error"  # You can set 'error', 'warning', or 'info' for different severities
}
