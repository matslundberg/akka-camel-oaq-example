-- SET SERVEROUTPUT ON;
-- select * from my_queue;
-- select * from DBA_QUEUE_SCHEDULES;
-- select * from dba_jobs_running;
-- select * from aq$MY_QUEUE where queue = 'MY_QUEUE';

DECLARE
    id                 pls_integer;
    agent              sys.aq$_agent := sys.aq$_agent(' ', null, 0);
    message            sys.aq$_jms_message;
    enqueue_options    dbms_aq.enqueue_options_t;
    message_properties dbms_aq.message_properties_t;
    msgid raw(16);

    java_exp           exception;
    -- pragma EXCEPTION_INIT(java_exp, -24197);
BEGIN
    message := SYS.aq$_jms_message.construct(DBMS_AQJMS.JMS_TEXT_MESSAGE);

    -- Shows how to set the JMS header
    message.set_replyto(agent);
    --message.set_type('tkaqpet1');
    message.set_userid('C20');
    --message.set_appid('plsql_enq');
    --message.set_groupid('st');
    --message.set_groupseq(1);

    -- Shows how to set JMS user properties
    message.set_string_property('color', 'RED');
    message.set_text('foo');
    -- message.set_string_property('Foo', 'bar');
    -- message.set_int_property('year', 1999);
    -- message.set_float_property('price', 16999.99);
    -- message.set_long_property('mileage', 300000);
    -- message.set_boolean_property('import', True);
    -- message.set_byte_property('password', -127);

    --enqueue_options.

    -- Shows how to populate the message payload of aq$_jms_bytes_message

    -- Passing -1 reserve a new slot within the message store of sys.aq$_jms_bytes_message.
    -- The maximum number of sys.aq$_jms_bytes_message type of messges to be operated at
    -- the same time within a session is 20. Calling clean_body function with parameter -1
    -- might result a ORA-24199 error if the messages currently operated is already 20.
    -- The user is responsible to call clean or clean_all function to clean up message store.

    -- Write data into the bytes message paylaod. These functions are analogy of JMS JAVA api's.
    -- See the document for detail.

    -- Write a byte to the bytes message payload
    -- message.write_byte(id, 10);

    -- Write a RAW data as byte array to the bytes message payload
   --  message.write_bytes(id, UTL_RAW.XRANGE(HEXTORAW('00'), HEXTORAW('FF')));

    -- Write a portion of the RAW data as byte array to bytes message payload
    -- Note the offset follows JAVA convention, starting from 0
    -- message.write_bytes(id, UTL_RAW.XRANGE(HEXTORAW('00'), HEXTORAW('FF')), 0, 16);

    -- Write a char to the bytes message payload
    -- message.write_char(id, 'A');

    -- Write a double to the bytes message payload
    -- message.write_double(id, 9999.99);

    -- Write a float to the bytes message payload
    -- message.write_float(id, 99.99);

    -- Write a int to the bytes message payload
    -- message.write_int(id, 12345);

    -- Write a long to the bytes message payload
    -- message.write_long(id, 1234567);

    -- Write a short to the bytes message payload
    -- message.write_short(id, 123);

    -- Write a String to the bytes message payload,
    -- the String is encoded in UTF8 in the message payload
    -- message.write_utf(id, 'Hello World!');

    -- Flush the data from JAVA stored procedure (JServ) to PL/SQL side
    -- Without doing this, the PL/SQL message is still empty.
    --message.flush(id);

    -- Use either clean_all or clean to clean up the message store when the user
    -- do not plan to do paylaod population on this message anymore
    sys.aq$_jms_bytes_message.clean_all();
    --message.clean(id);

    -- Enqueue this message into AQ queue using DBMS_AQ package
    dbms_aq.enqueue(queue_name => 'MY_QUEUE',
                    enqueue_options => enqueue_options,
                    message_properties => message_properties,
                    payload => message,
                    msgid => msgid);

    --dbms_output.put_line(msgid);
    commit;

    EXCEPTION
    WHEN java_exp THEN
      dbms_output.put_line('exception information:');
      -- display_exp(sys.aq$_jms_stream_message.get_exception());

END;
/
