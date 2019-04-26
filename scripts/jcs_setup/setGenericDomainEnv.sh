#!/bin/bash

# Restore system umask that got overridden by startWeblogic.sh
umask 002

if [ "${SERVER_NAME}" = "ohi_admin_server" ] ; then
   MEM_ARGS="-Xmx1g"
   export MEM_ARGS

   JAVA_OPTIONS="${JAVA_OPTIONS} -Dclaims.mock.properties.file=${OHI_BASE}/claims/config/mock.properties"
   JAVA_OPTIONS="${JAVA_OPTIONS} -Dproddef.mock.properties.file=${OHI_BASE}/proddef/config/mock.properties"
   JAVA_OPTIONS="${JAVA_OPTIONS} -Dacceptall.properties.file=${OHI_BASE}/config/acceptall.properties"
   JAVA_OPTIONS="${JAVA_OPTIONS} -Dohi.enrollment.mock.filelocation=${OHI_BASE}/claims/mock/enrollment/response"
   JAVA_OPTIONS="${JAVA_OPTIONS} -Dohi.callout.mock.filelocation=${OHI_BASE}/mock"
   JAVA_OPTIONS="${JAVA_OPTIONS} -Djet.properties.file=${OHI_BASE}/modelOfficeJET/config/jet-demo.properties"
   export JAVA_OPTIONS
else
    # Extract the application name from the WLS server name, e.g. extract "claims" from "claims_node1"
    APP_NAME=${SERVER_NAME%_*}

    # Memory Args
    MEM_ARGS="-Xmx2g"
    MEM_ARGS="${MEM_ARGS} -XX:+UseG1GC"
    export MEM_ARGS

    # Java Options
    TIMESTAMP=`date "+%Y-%m-%d_%H_%M_%S"`
    JAVA_OPTIONS="${JAVA_OPTIONS} -Xloggc:${LOG_BASE}/${APP_NAME}/gc/gc_${SERVER_NAME}_${TIMESTAMP}.log"
    JAVA_OPTIONS="${JAVA_OPTIONS} -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -XX:+PrintGCTimeStamps"

    JAVA_OPTIONS="${JAVA_OPTIONS} -Dohi.mds.country=US"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dohi.properties.file=/u01/data/ohiBase/claims/config/ohi-claims.properties"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dlogback.configurationFile=/u01/data/ohiBase/claims/config/logback_claims.xml"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.security.auth.login.config=/u01/data/ohiBase/claims/config/ohi-security.config"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.awt.headless=true"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Djavax.xml.datatype.DatatypeFactory=com.sun.org.apache.xerces.internal.jaxp.datatype.DatatypeFactoryImpl"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dcom.sun.org.apache.xml.internal.dtm.DTMManager=com.sun.org.apache.xml.internal.dtm.ref.DTMManagerDefault"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dtangosol.coherence.mode=prod"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dtangosol.coherence.log=stderr"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dtangosol.coherence.log.level=4"

    # To make Jersey filters that set certain CORS related HTTP Headers work
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dsun.net.http.allowRestrictedHeaders=true"

    # Optional settings for JMX management
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dcom.sun.management.jmxremote.authenticate=false"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dcom.sun.management.jmxremote.ssl=false"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Djavax.management.builder.initial=weblogic.management.jmx.mbeanserver.WLSMBeanServerBuilder"

    # Optional settings to enable monitoring Coherence through JMX
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dtangosol.coherence.management=all"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Dtangosol.coherence.management.remote=true"
    export JAVA_OPTIONS
fi
