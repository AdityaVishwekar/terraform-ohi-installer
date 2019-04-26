// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
// 132.145.210.120
resource "null_resource" "remote-exec" {
    provisioner "file" {
        connection {
            agent = false
            timeout = "10m"
            host = "${data.oci_core_vnic.db_node_vnic.public_ip_address}"
            #host = "129.213.164.126"
	        user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }
        source = "./scripts/dbsystem_setup/"
        destination = "~/"
    }    
    
    provisioner "remote-exec" {
        connection {
            agent = false
            timeout = "10m"
            host = "${data.oci_core_vnic.db_node_vnic.public_ip_address}"
            user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }

        inline = [
            "sudo mv -v * /home/oracle/",
            "sudo chown -R oracle:oinstall /home/oracle/ohidbsetup.sh",
            "sudo chown -R oracle:oinstall /home/oracle/pl_script1.sql",
            "sudo chmod +x /home/oracle/*.sh",
            "sudo su - oracle -c 'touch output.txt;ls -lrt;whoami'",
            "echo Permissions give, moving to execution of the script in oracle user",
            "sudo su - oracle -c 'sh /home/oracle/ohidbsetup.sh | tee /home/oracle/output.log'",
            // Transfer and extract claims_fresh_install.zip to /u01/app/oracle/dpdump/ - Check permission for the file oracle:oinstall
            "sudo cp /home/oracle/claims_fresh_install.zip /u01/app/oracle/dpdump/",
            "cd /u01/app/oracle/dpdump/",
            "sudo unzip claims_fresh_install.zip -d /u01/app/oracle/dpdump/",
            "sudo chown -R oracle:oinstall /u01/app/oracle/dpdump/claims_fresh_install.zip",
            "sudo chown -R oracle:oinstall /u01/app/oracle/dpdump/claims_fresh_install.dmp",
	    "echo \"Finsihed my task!!!!!\""
        ]
    }
}

resource "null_resource" "remote-exec-jcs" {
    provisioner "file" {
        connection {
            agent = false
            timeout = "60m"
            host = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
            #host = "129.213.164.126"
            user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }
        source = "./scripts/jcs_setup/"
        destination = "~/"
    }    
    
    provisioner "remote-exec" {
        connection {
            agent = false
            timeout = "60m"
            host = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
            user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }

        inline = [
            // Transfer and extract ohiBaseTerraform.zip to /u01/data/ - Check permission for the file oracle:oracle
            "sudo mv -v * /u01/data/",
            //"sudo su - ",
            //"cd /u01/data/",
            "sudo chown -R oracle:oracle /u01/data/*",
            "sudo unzip /u01/data/ohiBaseTerraform.zip -d /u01/data",
            "sudo chown -R oracle:oracle /u01/data/ohiBase",
            "sudo chmod a+x /u01/data/createCoherenceCluster.py",
            "sudo chmod a+x /u01/data/updateCreateCluster.sh",
            "sudo chown -R oracle:oracle /u01/data/updateCreateCluster.sh",
            "sudo chown -R oracle:oracle /u01/data/OHI-Claims-3.18.3.0.0.ear",
            "sudo chown -R oracle:oracle /u01/data/custom.oracle.healthinsurance.war",
            "sudo chown -R oracle:oracle /u01/data/createCoherenceCluster.py",

            // Copy setGenericDomain.sh to $DOMAIN_HOME/bin/
            "sudo mv /u01/data/setGenericDomainEnv.sh $DOMAIN_HOME/bin/",
            "sudo chown -R oracle:oracle $DOMAIN_HOME/bin/setGenericDomainEnv.sh",

        "echo \"Finsihed my task!!!!!\""
        ]

    }
    depends_on = ["null_resource.remote-exec"]
}


resource "null_resource" "remote-exec-jcs1" {
    
    provisioner "file" {
        connection {
            agent = false
            timeout = "60m"
            host = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
            #host = "129.213.164.126"
            user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }
        source = "./scripts/jcs_setup/"
        destination = "~/"
    }    
    
    provisioner "remote-exec" {
        connection {
            agent = false
            timeout = "60m"
            host = "${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}"
            user = "${var.host_user_name}"
            private_key = "${file("/home/osboxes/.ssh/privateKey")}"
            #private_key = "${file("/root/.oci/privateKey")}"
        }

        inline = [
            // CReate cluster            
            "sudo /u01/data/updateCreateCluster.sh ${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}",

        "echo \"Finsihed my task!!!!!\""
        ]

    }
    depends_on = ["null_resource.remote-exec-jcs"]
}

resource "null_resource" "local-exec-jcs" {
    provisioner "local-exec" {
            command="curl -v --user weblogic:Ach1z0#d -H X-Requested-By:MyClient -H Accept:application/json -X POST http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:7001/management/wls/latest/changeManager/startEdit",

            // Create a datasource
            command="curl -v --user weblogic:Ach1z0#d -H X-Requested-By:MyClient -H Accept:application/json -H Content-Type:application/json -d \"`cat ./scripts/jcs_setup/jdbc.options`\" -X POST http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:7001/management/wls/latest/datasources",

      }
      depends_on = ["null_resource.remote-exec-jcs1"]
}

resource "null_resource" "local-exec-jcs3" {
    provisioner "local-exec" {
            
            // Deploy library
            command="curl -v --user weblogic:Ach1z0#d -H X-Requested-By:MyClient -H Accept:application/json -H Content-Type:application/json -d \"{name: 'custom.oracle.healthinsurance', deploymentPath: '/u01/data/ohiBase/claims/releases/3.18.3.0.0/lib/custom.oracle.healthinsurance.war', targets: ['ohi-app-_adminserver','ohi-app-_cluster']}\" -X POST http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:7001/management/wls/latest/deployments/library",



      }
      depends_on = ["null_resource.local-exec-jcs"]
}
resource "null_resource" "local-exec-jcs4" {
    provisioner "local-exec" {
            
            // Deploy EAR file
            command="curl -v --user weblogic:Ach1z0#d -H X-Requested-By:MyClient -H Accept:application/json -H Content-Type:application/json -d \"{name: 'OHI-Claims-3.18.3.0', deploymentPath: '/u01/data/OHI-Claims-3.18.3.0.0.ear', targets: ['ohi-app-_adminserver','ohi-app-_cluster']}\" -X POST http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:7001/management/wls/latest/deployments/application",


      }
      depends_on = ["null_resource.local-exec-jcs3"]
}
/*
resource "null_resource" "local-exec-jcs-activate" {
    provisioner "local-exec" {
            command="sleep 120"
            // Activate
            command="curl -v --user weblogic:Ach1z0#d -H X-Requested-By:MyClient -H Accept:application/json -X POST http://${replace(element(split(":",oraclepaas_java_service_instance.jcs.weblogic_server.0.root_url),1),"////","")}:7001/management/wls/latest/changeManager/activate",
      
      }
      depends_on = ["null_resource.local-exec-jcs"]
}
*/