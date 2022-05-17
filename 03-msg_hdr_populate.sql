/***********************************************************************************************************************
  Object Information
    Object: msg_hdr
    Schema: bilfundrpt
    Business Purpose: Initial data population for message headers records

  Version History
    Created By: Bakari Allen
    Created on: 2022-05-06
    DB_Version: v01.01.00

 **********************************************************************************************************************/

BEGIN;
    -- lock table for update
    SELECT * FROM bilfundrpt.msg_hdr FOR NO KEY UPDATE;

    INSERT INTO bilfundrpt.msg_hdr (msg_hdr_id, module, sub_module, msg_severity_id)
        VALUES
        (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_FLAT', 0)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_FLAT', 1)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_FLAT', 2)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_FLAT', 3)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_FLAT', 4)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_TRXN', 0)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_TRXN', 1)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_TRXN', 2)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_TRXN', 3)
        , (DEFAULT,'BIL_DATA_LOAD', 'BIL_LOAD_TRXN', 4);
END;