// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaagyxvnqzbdmlsmzzpaqzam7brue7q47qsvl6j6c5eh56lotfa7avq"
}
variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaaxvygocvioxxuaregix7w4bnpl65ai6oucjqry2nhebdcrqtdextq"
}
variable "fingerprint" {
  default = "04:cd:31:f8:b4:87:e1:3c:c8:5d:3d:2d:ed:8e:1a:d0"
}
variable "private_key_path" {
  default = "/home/osboxes/Downloads/oci_api_key.pem"
}
variable "region" {
  default = "us-ashburn-1"
}

variable "compartment_ocid" {
  default = "ocid1.compartment.oc1..aaaaaaaaww75w4q5jgq3jywvetwsqvyyvmbjmgk3qqsybfkczveg6f3ulixa"
}
variable "ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChxoFiag1NBiaedOAmgGfuNhHJdjf658plFZHjboZ20PMZ6Ozzu9nrQHSp7b0X5DjrpHiPRsn25qTaFsI7LisRWxD41y/NVYmHHMZc2dDGUdTPtXG5QApg3EWm/1rS83qtGpj2z0qGQsRtKDm5ssT/V6l7z1ym0reFRq2j61TCnb//oaOpHD8ByV4xwaJrgEys0XOFSa4/5b2VRQ5vYYQ8wTNluvp3+OE3TI3OgLLYqUg8Fxtr0eFJ0cwAfEFX8U+yAq60Pl+00c1VN2an8vta1lTTYLntfnGUcdoFrGkH+Lqj7JMR1Xqd9rxW8mbFzX9mp76p72+WFxJ0abGCNV87"
}
variable "ssh_private_key" {
  default = "/home/osboxes/Downloads/oci_api_key.pem"
}

# Choose an Availability Domain
variable "availability_domain" {
  default = "2"
}

# DBSystem specific 
variable "db_system_shape" {
  default = "VM.Standard2.1"
}

variable "cpu_core_count" {
  default = "2"
}

variable "db_edition" {
  default = "ENTERPRISE_EDITION_HIGH_PERFORMANCE"
}

variable "db_admin_password" {
  default = "BEstrO0ng_#12"
}

variable "db_name" {
  default = "aTFdb"
}

variable "db_version" {
  default = "12.2.0.1"
}

variable "db_home_display_name" {
  default = "MyTFDBHome"
}

variable "db_disk_redundancy" {
  default = "HIGH"
}

variable "db_system_display_name" {
  default = "MyTFDBSystem"
}

variable "hostname" {
  default = "myoracledb"
}

variable "host_user_name" {
  default = "opc"
}

variable "n_character_set" {
  default = "AL16UTF16"
}

variable "character_set" {
  default = "AL32UTF8"
}

variable "db_workload" {
  default = "OLTP"
}

variable "pdb_name" {
  default = "pdbName"
}

variable "data_storage_size_in_gb" {
  default = "256"
}

variable "license_model" {
  default = "LICENSE_INCLUDED"
}

variable "node_count" {
  default = "1"
}

variable "data_storage_percentage" {
  default = "40"
}

variable "ssh_public_key_file" {
  default = "./publicKey"
}

//variable "jcs_public_ip" {
//  default = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
//}