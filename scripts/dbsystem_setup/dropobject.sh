#!/bin/bash
sqlplus / as sysdba <<EOF
spool drop_objects.log
DROP VIEW d\$pending_xatrans\$;
DROP synonym v\$pending_xatrans\$;
DROP VIEW d\$xatrans\$;
DROP synonym v\$xatrans\$;
DROP DIRECTORY OHI_DPDUMP_DIR;
alter session set "_oracle_script"=true;
DROP USER db_admin;
spool off;
exit;
EOF

