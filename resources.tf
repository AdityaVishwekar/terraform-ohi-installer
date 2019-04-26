// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_database_db_system" "test_db_system" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      = "${var.compartment_ocid}"
  cpu_core_count      = "${lookup(data.oci_database_db_system_shapes.test_db_system_shapes.db_system_shapes[0], "minimum_core_count")}"
  database_edition    = "${var.db_edition}"

  db_home {
    database {
      admin_password = "${var.db_admin_password}"
      db_name        = "${var.db_name}"
      character_set  = "${var.character_set}"
      ncharacter_set = "${var.n_character_set}"
      db_workload    = "${var.db_workload}"
      pdb_name       = "${var.pdb_name}"

      db_backup_config {
        auto_backup_enabled = true
      }
    }

    db_version   = "${var.db_version}"
    display_name = "${var.db_home_display_name}"
  }

  disk_redundancy = "${var.db_disk_redundancy}"
  shape           = "${var.db_system_shape}"
  subnet_id       = "${oci_core_subnet.subnet.id}"
  ssh_public_keys = ["${var.ssh_public_key}"]
  display_name    = "${var.db_system_display_name}"

  hostname                = "${var.hostname}"
  data_storage_percentage = "${var.data_storage_percentage}"
  data_storage_size_in_gb = "${var.data_storage_size_in_gb}"
  license_model           = "${var.license_model}"
  node_count              = "${lookup(data.oci_database_db_system_shapes.test_db_system_shapes.db_system_shapes[0], "minimum_node_count")}"

  #To use defined_tags, set the values below to an existing tag namespace, refer to the identity example on how to create tag namespaces
  #defined_tags = "${map("example-tag-namespace-all.example-tag", "originalValue")}"

  freeform_tags = {
    "Department" = "Finance"
  }
}
/*

resource "oci_database_backup" "test_backup" {
  depends_on   = ["oci_database_db_system.test_db_system"]
  database_id  = "${data.oci_database_databases.databases.databases.0.id}"
  display_name = "FirstBackup"
}
*/


resource "oraclepaas_java_service_instance" "jcs" {
  name        = "ohi-app-terraform-test"
  description = "Example Terraformed JCS with OCI DB"

  edition                = "EE"            
  service_version        = "12cRelease213"
  metering_frequency     = "HOURLY"
  bring_your_own_license = true

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChxoFiag1NBiaedOAmgGfuNhHJdjf658plFZHjboZ20PMZ6Ozzu9nrQHSp7b0X5DjrpHiPRsn25qTaFsI7LisRWxD41y/NVYmHHMZc2dDGUdTPtXG5QApg3EWm/1rS83qtGpj2z0qGQsRtKDm5ssT/V6l7z1ym0reFRq2j61TCnb//oaOpHD8ByV4xwaJrgEys0XOFSa4/5b2VRQ5vYYQ8wTNluvp3+OE3TI3OgLLYqUg8Fxtr0eFJ0cwAfEFX8U+yAq60Pl+00c1VN2an8vta1lTTYLntfnGUcdoFrGkH+Lqj7JMR1Xqd9rxW8mbFzX9mp76p72+WFxJ0abGCNV87"

  # OCI Settings
  region              = "us-ashburn-1"
  availability_domain = "${data.oci_identity_availability_domain.ad3.name}"
  subnet              = "${oci_core_subnet.subnet_jcs.id}"

  weblogic_server {
    shape = "VM.Standard2.1"

    //connect_string = "//${oci_database_db_system.test_db_system.hostname}-scan.${data.oci_core_subnet.subnet_jcs.subnet_domain_name}:1521/${oci_database_db_system.test_db_system.db_home.0.database.0.pdb_name}.${data.oci_core_subnet.subnet_jcs.subnet_domain_name}"

    connect_string = "//myoracledb-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com:1521/pdbName.tfexsubdbsys.tfexvcndbsys.oraclevcn.com"
    database {
    username = "SYS"
    password = "${oci_database_db_system.test_db_system.db_home.0.database.0.admin_password}"
    //password = "BEstrO0ng_#12"
    }


    admin {
      username = "weblogic"
      password = "Ach1z0#d"
    }
  }

  backups {
    cloud_storage_container = "https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/humanaohitrial1/bucket4jcs"
    cloud_storage_username  = "api.user"
    cloud_storage_password  = "D##-gnYml]rH9B)y<9yN"
  }

  enable_admin_console = true
  notification_email    = "aditya.vishwekar@oracle.com"

}
