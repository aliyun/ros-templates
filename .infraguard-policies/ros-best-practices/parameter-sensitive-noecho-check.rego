package infraguard.rules.solution.parameter_sensitive_noecho_check

import rego.v1

# Rule metadata with i18n support
rule_meta := {
	"id": "rule:solution:parameter-sensitive-noecho-check",
	"name": {
		"en": "Sensitive Parameters Must Have NoEcho",
		"zh": "敏感参数必须配置NoEcho",
	},
	"severity": "high",
	"description": {
		"en": "Template parameters that contain sensitive information (passwords, API keys, secrets) must be protected by either setting NoEcho to true or using valid AssociationProperty values to prevent them from being displayed in plain text.",
		"zh": "包含敏感信息（密码、API 密钥、密钥等）的模板参数必须通过设置 NoEcho 为 true 或使用有效的 AssociationProperty 值来保护，以防止以明文形式显示。",
	},
	"reason": {
		"en": "Sensitive parameters without proper protection (NoEcho or valid AssociationProperty) may be exposed in logs, console output, or API responses, leading to security risks.",
		"zh": "未正确保护（未设置 NoEcho 或有效的 AssociationProperty）的敏感参数可能在日志、控制台输出或 API 响应中暴露，导致安全风险。",
	},
	"recommendation": {
		"en": "For all sensitive parameters (those containing password, apikey, secret, etc.), either set NoEcho to true or use valid AssociationProperty values such as ALIYUN::ECS::Instance::Password, ALIYUN::Bailian::ApiKey::ApiKeyInfo, or ALIYUN::DashScope::ApiKey.",
		"zh": "为所有敏感参数（包含 password、apikey、secret 等的参数）设置 NoEcho 为 true，或使用有效的 AssociationProperty 值（如 ALIYUN::ECS::Instance::Password、ALIYUN::Bailian::ApiKey::ApiKeyInfo 或 ALIYUN::DashScope::ApiKey）。",
	},
	"resource_types": [],
}

# Sensitive keywords to detect in parameter names
sensitive_keywords := [
	"password",
	"passwd",
	"pwd",
	"secret",
	"apikey",
	"api_key",
	"accesskey",
	"access_key",
	"secretkey",
	"secret_key",
	"token",
	"credential",
	"privatekey",
	"private_key",
]

# Check if a parameter name contains sensitive keywords (case-insensitive)
is_sensitive_parameter(param_name) if {
	some keyword in sensitive_keywords
	contains(lower(param_name), lower(keyword))
}

# Valid AssociationProperty values for sensitive parameters
valid_association_properties := [
	"ALIYUN::ECS::Instance::Password",
	"ALIYUN::Bailian::ApiKey::ApiKeyInfo",
	"ALIYUN::DashScope::ApiKey",
]

# Check if a parameter has NoEcho set to true
has_noecho(param_def) if {
	object.get(param_def, "NoEcho", false) == true
}

has_noecho(param_def) if {
	object.get(param_def, "NoEcho", false) == "true"
}

# Check if a parameter has valid AssociationProperty
has_valid_association_property(param_def) if {
	assoc_prop := object.get(param_def, "AssociationProperty", "")
	assoc_prop in valid_association_properties
}

# Check if a sensitive parameter is properly protected
# A parameter is protected if it meets any of the following conditions:
# 1. NoEcho is set to true
# 2. AssociationProperty is one of the valid values
is_protected_parameter(param_def) if {
	has_noecho(param_def)
}

is_protected_parameter(param_def) if {
	has_valid_association_property(param_def)
}

# Check template Parameters
deny contains result if {
	# Check if Parameters exist in input
	input.Parameters != null
	
	# Iterate through all parameters
	some param_name, param_def in input.Parameters
	
	# Check if parameter is sensitive
	is_sensitive_parameter(param_name)
	
	# Check if parameter is not properly protected
	not is_protected_parameter(param_def)
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Parameters", param_name],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

