
BEGIN
DBMS_AQADM.CREATE_QUEUE_TABLE(
     Queue_table        => 'MY_QUEUE',
     Queue_payload_type => 'SYS.AQ$_JMS_MESSAGE',
     Storage_clause => 'TABLESPACE svntest');
  END;

  BEGIN
  DBMS_AQADM.CREATE_QUEUE(
     Queue_name          => 'MY_QUEUE',
     Queue_table         => 'MY_QUEUE');
  END;

  BEGIN
  DBMS_AQADM.START_QUEUE(
     Queue_name          => 'MY_QUEUE');
  END;

  /
