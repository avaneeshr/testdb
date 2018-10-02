locals {
	ebs_device_names =  ["xvdf","xvdg", "xvdh", "xvdi", "xvdj", "xvdk", "xvdl", "xvdm", "xvdn", "xvdo", "xvdp"]
	subnet_types = ["private", "private-static"]
}

resource "null_resource" "subnet_type_validate" {
  # If the subnet_type variable doesn't match the regular expression, then count = 1 and the error message is displayed
  count = "${contains(local.subnet_types, 
          var.subnet_type) ? 0: 1}"

  "ERROR: Invalid subnet_type value of \"${var.subnet_type}\". The valid value must be one of the following: ${join(",", local.subnet_types)}. The value is case sensitive." = true
}

resource "null_resource" "ebs_device_count_validate" {
  # If the ebs_count variable exceeds limit, then count = 1 and the error message is displayed
  count = "${length(local.ebs_device_names) >= var.ebs_count ? 0: 1}"

  "ERROR: Invalid ebs_count value of \"${var.ebs_count}\". The valid value must be less than ${length(local.ebs_device_names)}. The value is case sensitive." = true
}

# Get a list of availability zones in the current region
data "aws_availability_zones" "az" {}

resource "aws_instance" "instance" {
	count = "${var.instance_count}"

	ami           = "${var.ami_id}"
	instance_type = "${var.instance_type}"
	key_name      = "${var.key_name}"

	vpc_security_group_ids = "${var.security_group_ids}"

	subnet_id = "${var.subnet_id}"
	tags 			  = "${merge(map(
     									"Name", "${var.instance_name}",
										"asv", "${var.asv}",
      									"lob", "${var.lob}",
										"appname", "${var.appname}",
										"role", "${var.role}",
										"owner", "${var.owner}",
										"valuestream", "${var.valuestream}",
										"uptime", "${var.uptime}", 
										"owner_email", "${var.owner_email}"
   							 ), var.additional_tags)}"

	root_block_device {
      volume_size = "${var.root_disk_size}"
  }

	
    # Optional parameters
	placement_group                      = "${var.placement_group}"
	ebs_optimized                        = "${var.ebs_optimized}"
	disable_api_termination              = "${var.disable_api_termination}"
	instance_initiated_shutdown_behavior = "${var.shutdown_behavior}"
	monitoring                           = "${var.monitoring}"
	private_ip                           = "${var.private_ip}"
	source_dest_check                    = "${var.source_dest_check}"
	user_data                            = "${var.user_data}"
	iam_instance_profile                 = "${var.iam_instance_profile}"
	
	lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ebs_volume" "instance_ebs_volume" {
	count = "${var.ebs_count * var.instance_count}"

	# The following makes all EBS volumes of an instance to be in the same AZ as the instance
	availability_zone = "${aws_instance.instance.*.availability_zone[count.index / var.ebs_count]}"
	size              = "${element(var.ebs_sizes, count.index % var.ebs_count)}"
	type              = "${element(var.ebs_types, count.index % var.ebs_count)}"
	encrypted         = true
	kms_key_id        = "${var.ebs_encryption_key}"
	tags 			  = "${merge(map(
     									 "asv", "${var.asv}",
      									"lob", "${var.lob}",
										"appname", "${var.appname}",
										"role", "${var.role}",
										"owner", "${var.owner}",
										"valuestream", "${var.valuestream}",
										"uptime", "${var.uptime}", 
										"owner_email", "${var.owner_email}"
   							 ), var.additional_tags)}"

	#Optional parameters
	snapshot_id = "${element(var.snapshot_ids, count.index % var.ebs_count)}"
}

resource "aws_volume_attachment" "instance_ebs_attach" {
	count       = "${var.ebs_count * var.instance_count}"
	device_name = "${element(var.ebs_device_names, count.index % var.ebs_count)}"
	volume_id   = "${aws_ebs_volume.instance_ebs_volume.*.id[count.index]}"
	instance_id = "${aws_instance.instance.*.id[count.index / var.ebs_count]}"

	#Optional parameters
	force_detach = "${var.force_detach}"
	skip_destroy = "${var.skip_destroy}"
}