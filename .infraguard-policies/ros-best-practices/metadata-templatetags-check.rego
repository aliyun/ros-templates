package infraguard.rules.solution.metadata_templatetags_check

import rego.v1

# Rule metadata with i18n support
rule_meta := {
	"id": "rule:solution:metadata-templatetags-check",
	"name": {
		"en": "Template Metadata TemplateTags Check",
		"zh": "模板 Metadata TemplateTags 检查",
	},
	"severity": "medium",
	"description": {
		"en": "Template must have Metadata.TemplateTags configured. The value must be a list of strings, and each element must start with 'acs:' and be in four-part format separated by ':' (acs:segment1:segment2:segment3).",
		"zh": "模板必须配置 Metadata.TemplateTags。该值必须是字符串列表，每个元素必须以 'acs:' 开头，四段式（acs:segment1:segment2:segment3），使用 ':' 分隔。",
	},
	"reason": {
		"en": "TemplateTags is missing or invalid.",
		"zh": "TemplateTags 缺失或格式无效。",
	},
	"recommendation": {
		"en": "Configure Metadata.TemplateTags as a list of strings, each starting with 'acs:' and in four-part format (acs:segment1:segment2:segment3).",
		"zh": "将 Metadata.TemplateTags 配置为字符串列表，每个元素以 'acs:' 开头，四段式格式（acs:segment1:segment2:segment3）。",
	},
	"resource_types": [],
}

# Check if a string is a valid TemplateTag format
# Format: acs:segment1:segment2:segment3 (three segments after 'acs:', four parts total)
is_valid_templatetag(tag) if {
	# Must be a string
	is_string(tag)
	
	# Must start with "acs:"
	startswith(tag, "acs:")
	
	# Split by ':' and check segments
	parts := split(tag, ":")
	
	# Must have exactly 4 parts: "acs" + 3 segments
	count(parts) == 4
	
	# First part must be "acs"
	parts[0] == "acs"
	
	# All segments after "acs" must be non-empty
	parts[1] != ""
	parts[2] != ""
	parts[3] != ""
}

# Get TemplateTags from Metadata (can be in Metadata.TemplateTags or Metadata.ALIYUN::ROS::Interface.TemplateTags)
get_templatetags := tags if {
	tags := object.get(input.Metadata, "TemplateTags", null)
	tags != null
} else := tags if {
	interface_obj := object.get(input.Metadata, "ALIYUN::ROS::Interface", null)
	interface_obj != null
	tags := object.get(interface_obj, "TemplateTags", null)
	tags != null
} else := null

# Check if TemplateTags exists and is valid
has_valid_templatetags if {
	tags := get_templatetags
	tags != null
	
	# Must be an array
	is_array(tags)
	
	# All elements must be valid TemplateTag format
	all_tags_valid(tags)
}

# Check if all tags in the list are valid
all_tags_valid(tags) if {
	count(tags) == count([tag | some tag in tags; is_valid_templatetag(tag)])
}

# Check template Metadata
deny contains result if {
	# Check if Metadata exists
	input.Metadata == null
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

deny contains result if {
	# Check if Metadata exists
	input.Metadata != null
	
	# Check if TemplateTags is missing
	get_templatetags == null
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata", "ALIYUN::ROS::Interface", "TemplateTags"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

deny contains result if {
	# Check if Metadata exists
	input.Metadata != null
	
	# Check if TemplateTags exists
	tags := get_templatetags
	tags != null
	
	# Check if TemplateTags is not an array
	not is_array(tags)
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata", "ALIYUN::ROS::Interface", "TemplateTags"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

deny contains result if {
	# Check if Metadata exists
	input.Metadata != null
	
	# Check if TemplateTags exists and is an array
	tags := get_templatetags
	tags != null
	is_array(tags)
	
	# Check if any tag is invalid - point to the specific invalid tag element
	some i, tag in tags
	not is_valid_templatetag(tag)
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata", "ALIYUN::ROS::Interface", "TemplateTags", i],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

