package infraguard.rules.solution.metadata_ros_composer_check

import rego.v1

# Rule metadata with i18n support
rule_meta := {
	"id": "rule:solution:metadata-ros-composer-check",
	"name": {
		"en": "Template Metadata ALIYUN::ROS::Composer Check",
		"zh": "模板 Metadata ALIYUN::ROS::Composer 检查",
	},
	"severity": "low",
	"description": {
		"en": "Template must have Metadata.ALIYUN::ROS::Composer configured. The value must be a dictionary (object).",
		"zh": "模板必须配置 Metadata.ALIYUN::ROS::Composer。该值必须是字典（对象）类型。",
	},
	"reason": {
		"en": "ALIYUN::ROS::Composer is missing or invalid. It must be configured as a dictionary.",
		"zh": "ALIYUN::ROS::Composer 缺失或格式无效。必须配置为字典类型。",
	},
	"recommendation": {
		"en": "Configure Metadata.ALIYUN::ROS::Composer as a dictionary (object).",
		"zh": "将 Metadata.ALIYUN::ROS::Composer 配置为字典（对象）类型。",
	},
	"resource_types": [],
}

# Check if ALIYUN::ROS::Composer exists and is valid
has_valid_composer if {
	# Check if Metadata exists
	input.Metadata != null
	
	# Check if ALIYUN::ROS::Composer exists in Metadata
	composer := object.get(input.Metadata, "ALIYUN::ROS::Composer", null)
	composer != null
	
	# Must be an object (dictionary)
	is_object(composer)
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
	
	# Check if ALIYUN::ROS::Composer is missing
	object.get(input.Metadata, "ALIYUN::ROS::Composer", null) == null
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata", "ALIYUN::ROS::Composer"],
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
	
	# Check if ALIYUN::ROS::Composer exists
	composer := object.get(input.Metadata, "ALIYUN::ROS::Composer", null)
	composer != null
	
	# Check if ALIYUN::ROS::Composer is not an object
	not is_object(composer)
	
	result := {
		"id": rule_meta.id,
		"resource_id": "",
		"violation_path": ["Metadata", "ALIYUN::ROS::Composer"],
		"meta": {
			"severity": rule_meta.severity,
			"reason": rule_meta.reason,
			"recommendation": rule_meta.recommendation,
		},
	}
}

