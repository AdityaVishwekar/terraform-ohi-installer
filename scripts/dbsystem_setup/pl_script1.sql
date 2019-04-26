ALTER SESSION SET CONTAINER=PDBNAME;

alter session set "_ORACLE_SCRIPT"=true;

CREATE USER db_admin1 IDENTIFIED BY "BEstrO0ng_#12";

grant create session to db_admin1;

CREATE BIGFILE TABLESPACE "OHI_TAB" EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO DATAFILE '/u01/app/oracle/oradata/OHICO/OHICOPAAS1/ohi_tab01.dbf' SIZE 10G REUSE AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;

CREATE BIGFILE TABLESPACE "OHI_IDX" EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO DATAFILE '/u01/app/oracle/oradata/OHICO/OHICOPAAS1/ohi_idx01.dbf' SIZE 10G REUSE AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;

CREATE OR REPLACE DIRECTORY OHI_DPDUMP_DIR as '/u01/app/oracle/dpdump' ;

grant READ,WRITE  on DIRECTORY OHI_DPDUMP_DIR to system ;

grant execute on sys.dbms_aqin to system with grant option;

grant execute on sys.dbms_lock to system with grant option;

grant execute on sys.dbms_aqadm to system with grant option;

grant execute on sys.dbms_aq to system with grant option;

grant grant any object privilege to system ;

GRANT EXECUTE ON ctxsys.ctx_ddl to system WITH GRANT OPTION;

GRANT EXECUTE ON SYS.DBMS_SYSTEM to system with Grant Option ;

GRANT SELECT ON SYS.V_$PARAMETER TO system with grant option ;

GRANT GRANT ANY OBJECT PRIVILEGE TO system;

grant select on v$pending_xatrans$ to system;

grant select on v$xatrans$ to system;

