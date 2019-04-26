// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
# Output the public IP of the instance
output "db_node_public_ip" {
    value = ["${data.oci_core_vnic.db_node_vnic.public_ip_address}"]
}

output "oraclepaas_java_service_instance" "jcs" {
  //value = "${oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url}"
  value = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
}

output "application" "claims" {
	value = "http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:9073/claims/faces/common/pages/Login.xhtml"
}
