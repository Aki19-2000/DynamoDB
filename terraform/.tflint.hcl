# Example of updated TFLint configuration
plugin "aws" {
  enabled = true
  version = "v0.25.0"  # Specify the plugin version if needed
}

# Example for rule configuration
rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_security_group_rule_missing_type" {
  enabled = false  # Disable rule, or enable as needed
}

# Define exclusions for files or directories if needed
exclude = [
  "modules/*",  # Example: Exclude all modules from being linted
  "test/*"      # Example: Exclude test directories
]
