#----------------------------------------
# 変数
#----------------------------------------
variable "selected_instance_type" {
  type        = string
  description = "Select Instance Type From t4g.nano, t3a.nano, t3.nano, t2.nano"

  validation {
    condition     = contains(["t4g.nano", "t3a.nano", "t3.nano", "t2.nano"], var.selected_instance_type)
    error_message = "Instance type must be one of: t4g.nano, t3a.nano, t3.nano, t2.nano."
  }
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}


variable "ebs_volume_type" {
  type        = string
  description = "EBS volume type to use for EC2 instance"

  validation {
    condition     = contains(["gp2", "gp3", "io1"], var.ebs_volume_type)
    error_message = "Volume type must be one of: gp2, gp3, io1."
  }
}

variable "ebs_volume_size" {
  type        = number
  description = "Select Root Volume Size"

  validation {
    condition = (
      (var.ebs_volume_type == "gp2" || var.ebs_volume_type == "gp3") && var.ebs_volume_size >= 1 && var.ebs_volume_size <= 16000
      ) || (
      var.ebs_volume_type == "io1" && var.ebs_volume_size >= 4 && var.ebs_volume_size <= 16000
    )
    error_message = "For gp2 and gp3, the size must be between 1 and 16000. For io1, the size must be between 4 and 16000."
  }
}

variable "key_name" {
  type        = string
  description = "Key pair to access EC2 instance in ssh"
}

variable "user_data" {}