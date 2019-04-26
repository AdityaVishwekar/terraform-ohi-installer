#!/bin/bash

if [ ! -d /u01/app/oracle/oradata/OHICO/ ]; then
  mkdir -p /u01/app/oracle/oradata/OHICO;
fi

if [ ! -d /u01/app/oracle/oradata/OHICO/OHICOPAAS1/ ] ; then
  mkdir -p /u01/app/oracle/oradata/OHICO/OHICOPAAS1;
fi
if [ ! -d /u01/app/oracle/dpdump/ ] ; then
  mkdir -p /u01/app/oracle/dpdump;
fi

sqlplus -s / as sysdba <<EOF
set echo off;
set heading off;
spool /home/oracle/xaview.log;
@?/rdbms/admin/xaview.sql;
spool off;
exit;
EOF

echo;echo;echo;echo;
oracount=`grep "ORA-" /home/oracle/xaview.log|grep -v "ORA-00942"|wc -l`
if [ $oracount -gt 0 ]; then
        echo "YOu have ORA error in the execution of script"
        echo "Please check the log file /home/oracle/xaview.log"
        echo "exiting.. review and continue likewise"
        echo "Printing list of ORA error below"
        grep "ORA-" /home/oracle/xaview.log
        exit 1
fi

sqlplus -s / as sysdba <<EOF
set echo off;
set heading off;
spool /home/oracle/plscript.log;
@pl_script1.sql;
spool off;
exit;
EOF

echo;echo;echo;echo
