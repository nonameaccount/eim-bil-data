/***********************************************************************************************************************
  Object Information
    Object: msg_dtl
    Schema: bilfundrpt
    Business Purpose: Initial data population for message detail records

  Version History
    Created By: Bakari Allen
    Created on: 2022-05-06
    DB_Version: v01.01.00

 **********************************************************************************************************************/

BEGIN;
    -- lock table for update
    SELECT * FROM bilfundrpt.msg_dtl FOR NO KEY UPDATE;

    INSERT INTO bilfundrpt.msg_dtl (msg_dtl_id, msg_hdr_id, msg, short_msg)
        VALUES
        (DEFAULT,1, 'CRITICAL: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,2, 'ERROR: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,3, 'WARNING: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,4, 'INFORMATIONAL: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,5, 'VERBOSE: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,6, 'CRITICAL: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,7, 'ERROR: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,8, 'WARNING: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,9, 'INFORMATIONAL: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request')
        , (DEFAULT,10, 'VERBOSE: FAILED WITH ERROR CODE: <INSERT ERROR CODE HERE>', 'Unable to process request');
END;