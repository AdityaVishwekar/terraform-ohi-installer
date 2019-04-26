#!/bin/bash
sudo sed -i '1iconnect('\''weblogic'\'','\''Ach1z0#d'\'','\''t3://'"$1"':7001'\'')' /u01/data/createCoherenceCluster.py
source /u01/app/oracle/middleware/wlserver/server/bin/setWLSEnv.sh
java weblogic.WLST /u01/data/createCoherenceCluster.py
# Set reference of setGenericDomain.sh in startWeblogic.sh
cd /u01/data/domains/ohi-app-_domain/bin/
sed -i '/setDomainEnv.sh/ a . $DOMAIN_HOME/bin/setGenericDomainEnv.sh' /u01/data/domains/ohi-app-_domain/bin/startWebLogic.sh
cd /u01/data/ohiBase/claims/releases/3.18.3.0.0/util/install/
./ohi-install.sh -c ohi_install.cfg
