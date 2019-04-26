// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "TFExampleVCNDBSystem"
  dns_label      = "tfexvcndbsys"
}

resource "oci_core_security_list" "jcs_security_list" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "jcs_security_list"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"

  // Allow all outbound requests
  egress_security_rules = [
    {
      destination = "0.0.0.0/0"
      protocol    = "all"
    },
  ]

  ingress_security_rules = [
     {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 1521
        "max" = 1521
      }
    },
    {
      // Allowing inbound SSH traffic to instances in the subnet from any source
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      // Allowing inbound ICMP traffic of a specific type and code from any source
      protocol = 1
      source   = "0.0.0.0/0"

      icmp_options {
        "type" = 3
        "code" = 4
      }
    },
    {
      // Allowing inbound ICMP traffic of a specific type from within our VCN
      protocol = 1
      source   = "${oci_core_virtual_network.vcn.cidr_block}"

      icmp_options {
        "type" = 3
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 8989
        "max" = 8989
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 80
        "max" = 80
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 7002
        "max" = 7002
      }
    },
    {
      protocol = "all"
      source   = "0.0.0.0/0"
    }

  ]
}

resource "oci_core_subnet" "subnet" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  cidr_block          = "10.1.20.0/24"
  display_name        = "TFExampleSubnetDBSystem"
  dns_label           = "tfexsubdbsys"
  #security_list_ids   = ["${oci_core_virtual_network.vcn.default_security_list_id}"]
  security_list_ids   = ["${oci_core_security_list.jcs_security_list.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn.id}"
  route_table_id      = "${oci_core_route_table.route_table.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_jcs" {
  availability_domain = "${data.oci_identity_availability_domain.ad3.name}"
  cidr_block          = "10.1.30.0/24"
  display_name        = "TFExampleSubnetJCS"
  dns_label           = "tfexsubjcs"
  #security_list_ids   = ["${oci_core_virtual_network.vcn.default_security_list_id}"]
  security_list_ids   = ["${oci_core_security_list.jcs_security_list.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn.id}"
  route_table_id      = "${oci_core_route_table.route_table.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "TFExampleIGDBSystem"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
}

resource "oci_core_route_table" "route_table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  display_name   = "TFExampleRouteTableDBSystem"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.internet_gateway.id}"
  }
}
