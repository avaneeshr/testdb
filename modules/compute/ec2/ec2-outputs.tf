output "instance_id" {
  value = "${join(",", aws_instance.instance.*.id)}"

  #value = "${aws_instance.instance.*.id}"
}

output "private_ip" {
  description = "Private IP of instance"
  value       = "${join("", aws_instance.instance.*.private_ip)}"
}

output "instance_count" {
  value = "${var.instance_count}"
}