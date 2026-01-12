package infraguard.rules.solution.security_group_open_ports_except_whitelist

import rego.v1

import data.infraguard.helpers

# Rule metadata with i18n support
rule_meta := {
	"id": "rule:solution:security-group-open-ports-except-whitelist",
	"name": {
		"en": "Security Group Prohibits All Ports from Public Sources",
		"zh": "安全组严禁入规则全网全端口开放",
	},
	"severity": "high",
	"description": {
		"en": "Security group ingress rules must not allow all ports from public sources (0.0.0.0/0 or ::/0), except for ICMP protocol.",
		"zh": "安全组入方向规则严禁允许从公共来源（0.0.0.0/0 或 ::/0）访问所有端口，但 ICMP 协议例外。",
	},
	"reason": {
		"en": "The security group allows access to all ports from all sources (0.0.0.0/0 or ::/0), which exposes all services to the internet and poses a significant security risk. ICMP protocol is allowed as it is commonly used for network diagnostics.",
		"zh": "安全组允许从所有来源（0.0.0.0/0 或 ::/0）访问所有端口，将所有服务暴露到互联网，存在重大安全风险。ICMP 协议例外，因为通常用于网络诊断。",
	},
	"recommendation": {
		"en": "Restrict ingress rules to specific ports and trusted source IP ranges. Never allow all ports (-1/-1) from public sources (0.0.0.0/0 or ::/0).",
		"zh": "将入方向规则限制为特定端口和可信源 IP 范围。严禁允许从公共来源（0.0.0.0/0 或 ::/0）访问所有端口（-1/-1）。",
	},
	"resource_types": ["ALIYUN::ECS::SecurityGroup", "ALIYUN::ECS::SecurityGroupIngress", "ALIYUN::ECS::SecurityGroupIngresses"],
}

# Check if a rule allows all ports from public sources (excluding ICMP protocol)
is_all_ports_public_rule(rule) if {
	# Source is 0.0.0.0/0 (all IPv4)
	rule.SourceCidrIp == "0.0.0.0/0"

	# Policy is accept (default)
	object.get(rule, "Policy", "accept") == "accept"

	# Port range is all ports (-1/-1)
	rule.PortRange == "-1/-1"

	# Protocol is not ICMP (ICMP is allowed)
	lower(object.get(rule, "IpProtocol", "")) != "icmp"
}

is_all_ports_public_rule(rule) if {
	# Source is ::/0 (all IPv6)
	rule.Ipv6SourceCidrIp == "::/0"

	# Policy is accept (default)
	object.get(rule, "Policy", "accept") == "accept"

	# Port range is all ports (-1/-1)
	rule.PortRange == "-1/-1"

	# Protocol is not ICMP (ICMP is allowed)
	lower(object.get(rule, "IpProtocol", "")) != "icmp"
}

# Check SecurityGroup resource for ingress rules
deny contains result if {
	some name, resource in helpers.resources_by_type("ALIYUN::ECS::SecurityGroup")
	some i, rule in resource.Properties.SecurityGroupIngress
	ingress_rule := {
		"IpProtocol": object.get(rule, "IpProtocol", ""),
		"PortRange": rule.PortRange,
		"SourceCidrIp": object.get(rule, "SourceCidrIp", ""),
		"Ipv6SourceCidrIp": object.get(rule, "Ipv6SourceCidrIp", ""),
		"Policy": object.get(rule, "Policy", "accept"),
	}
	is_all_ports_public_rule(ingress_rule)
	result := {
		"id": rule_meta.id,
		"resource_id": name,
		"violation_path": ["Properties", "SecurityGroupIngress", i, "PortRange"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}


# Check SecurityGroupIngress resource
deny contains result if {
	some name, resource in helpers.resources_by_type("ALIYUN::ECS::SecurityGroupIngress")
	props := resource.Properties
	ingress_rule := {
		"IpProtocol": object.get(props, "IpProtocol", ""),
		"PortRange": props.PortRange,
		"SourceCidrIp": object.get(props, "SourceCidrIp", ""),
		"Ipv6SourceCidrIp": object.get(props, "Ipv6SourceCidrIp", ""),
		"Policy": object.get(props, "Policy", "accept"),
	}
	is_all_ports_public_rule(ingress_rule)
	result := {
		"id": rule_meta.id,
		"resource_id": name,
		"violation_path": ["Properties"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}


# Check SecurityGroupIngresses resource
deny contains result if {
	some name, resource in helpers.resources_by_type("ALIYUN::ECS::SecurityGroupIngresses")
	some i, perm in resource.Properties.Permissions
	ingress_rule := {
		"IpProtocol": object.get(perm, "IpProtocol", ""),
		"PortRange": perm.PortRange,
		"SourceCidrIp": object.get(perm, "SourceCidrIp", ""),
		"Ipv6SourceCidrIp": object.get(perm, "Ipv6SourceCidrIp", ""),
		"Policy": object.get(perm, "Policy", "accept"),
	}
	is_all_ports_public_rule(ingress_rule)
	result := {
		"id": rule_meta.id,
		"resource_id": name,
		"violation_path": ["Properties", "Permissions", i, "PortRange"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}


