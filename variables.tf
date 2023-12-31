########################
####     Intel      ####
########################

# See policies.md, Intel recommends the 4th Generation Intel® Xeon® Platinum (Sapphire Rapids) based instances.
#Compute Optimized: c7i.large,c7i.xlarge,c7i.2xlarge,c7i.4xlarge,c7i.8xlarge,c7i.12xlarge,c7i.16xlarge,c7i.24xlarge,c7i.48xlarge,c6i.12xlarge,c6i.16xlarge,c6i.24xlarge,c6i.32xlarge,c6i.2xlarge,c6i.8xlarge,c6i.xlarge,c6i.large,c6i.metal,c6i.4xlarge,c6id.12xlarge,c6id.16xlarge,c6id.24xlarge,c6id.32xlarge,c6id.2xlarge,c6id.8xlarge,c6id.xlarge,c6id.large,c6id.metal,c6id.4xlarge,c6in.12xlarge,c6in.16xlarge,c6in.24xlarge,c6in.32xlarge,c6in.2xlarge,c6in.8xlarge,c6in.xlarge,c6in.large,c6in.4xlarge
#Storage Optimized: i4i.16xlarge,i4i.32xlarge,i4i.2xlarge,i4i.8xlarge,i4i.xlarge,i4i.large,i4i.metal,i4i.4xlarge
#General Purpose:  m7i.large,m7i.xlarge,m7i.2xlarge,m7i.4xlarge,m7i.8xlarge,m7i.12xlarge,m7i.16xlarge,m7i.24xlarge,m7i.48xlarge,m7i-flex.large,m7i-flex.xlarge,m7i-flex.2xlarge,m7i-flex.4xlarge,m7i-flex.8xlarge,m6i.12xlarge,m6i.16xlarge,m6i.24xlarge,m6i.32xlarge,m6i.2xlarge,m6i.8xlarge,m6i.xlarge,m6i.large,m6i.metal,m6i.4xlarge,m6id.12xlarge,m6id.16xlarge,m6id.24xlarge,m6id.32xlarge,m6id.2xlarge,m6id.8xlarge,m6id.xlarge,m6id.large,m6id.metal,m6id.4xlarge,m6idn.12xlarge,m6idn.16xlarge,m6idn.24xlarge,m6idn.32xlarge,m6idn.2xlarge,m6idn.8xlarge,m6idn.xlarge,m6idn.large,m6idn.4xlarge,m6in.12xlarge,m6in.16xlarge,m6in.24xlarge,m6in.32xlarge,m6in.2xlarge,m6in.8xlarge,m6in.xlarge,m6in.large,m6in.4xlarge
#Memory Optimized: r6i.12xlarge,r6i.16xlarge,r6i.24xlarge,r6i.32xlarge,r6i.2xlarge,r6i.8xlarge,r6i.xlarge,r6i.large,r6i.metal,r6i.4xlarge,r6id.12xlarge,r6id.16xlarge,r6id.24xlarge,r6id.32xlarge,r6id.2xlarge,r6id.8xlarge,r6id.xlarge,r6id.large,r6id.metal,r6id.4xlarge,r6idn.12xlarge,r6idn.16xlarge,r6idn.24xlarge,r6idn.32xlarge,r6idn.2xlarge,r6idn.8xlarge,r6idn.xlarge,r6idn.large,r6idn.4xlarge,r6in.12xlarge,r6in.16xlarge,r6in.24xlarge,r6in.32xlarge,r6in.2xlarge,r6in.8xlarge,r6in.xlarge,r6in.large,r6in.4xlarge,x2idn.16xlarge,x2idn.24xlarge,x2idn.32xlarge,x2idn.metal,x2iedn.16xlarge,x2iedn.24xlarge,x2iedn.32xlarge,x2iedn.2xlarge,x2iedn.8xlarge,x2iedn.xlarge,x2iedn.metal,x2iedn.4xlarge
#Accelerated Computing:  trn1.32xlarge,trn1.2xlarge
# See more:
# https://aws.amazon.com/ec2/instance-types/ 

#variable "instance_type" {
#  description = "Instance SKU, see comments above for guidance"
#  type        = string
#  default     = "m7i.2xlarge"
#}

variable "instance_config" {
  type = list(object({
    instance_type = string
    tag_name      = string
  }))
  default = [
    {
      instance_type = "m6i.large"
      tag_name      = "bibrani-es-m6i.large"
    },
    {
      instance_type = "m6i.xlarge"
      tag_name      = "bibrani-es-m6i.xlarge"
    },
    {
      instance_type = "m6i.2xlarge"
      tag_name      = "bibrani-es-m6i.2xlarge"
    }
  ]
}


########################
####    Required    ####
########################
variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}



variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  #x86
  default     = "ami-053b0d53c279acc90"
  #arm
  #default     = "ami-0a0c8eebcdd6dcbd0"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = null
}

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = "us-east-1a"
}





variable "host_id" {
  description = "ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = "bibrani-s3-benchmark-report"
}

#variable "instance_name" {
#  type    = string
#  default = "bibrani-m7i-large"
#}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = null
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = "bibrani-us-key"
}


variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = null
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block`"
  type        = list(string)
  default     = null
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = "subnet-45c0a264"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set."
  type        = bool
  default     = false
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags (if enabled it conflicts with root_block_device tags)"
  type        = bool
  default     = true
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}

variable "cpu_core_count" {
  description = "Sets the number of CPU cores for an instance." # This option is only supported on creation of instance type that support CPU Options https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html#cpu-options-supported-instances-values
  type        = number
  default     = null
}

variable "cpu_threads_per_core" {
  description = "Sets the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)."
  type        = number
  default     = null
}