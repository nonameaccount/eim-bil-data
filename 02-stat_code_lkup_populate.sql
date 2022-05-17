/***********************************************************************************************************************
  Object Information
    Object: stat_code_lkup
    Schema: bilfundrpt
    Business Purpose: Initial data population for stat codes

  Version History
    Created By: Bakari Allen
    Created on: 2022-05-06
    DB_Version: v01.01.00

 **********************************************************************************************************************/

BEGIN;
    SELECT * FROM bilfundrpt.stat_code_lkup FOR NO KEY UPDATE;

    INSERT INTO bilfundrpt.stat_code_lkup (stat_code, description, notes)
        values
        (0, 'Ready for Processing', 'Record is ready for processing if processing logic needs to be applied to the record')
        , (5, 'In-Process', 'Application has picked it up for processing')
        , (90, 'Processed', 'Record has been processed successfully without errors, dbo: in CPPX (to indicate the record already used to generate rules in DS schema! Changes from 10 to 90 by DS!)')
        , (95, 'To be re-processed', 'For whatever reason, the record ran into an issue, error has been logged and this record needs to be re-processed (Example: Missing CPT codes)')
        , (99, 'Error', 'We need to log the record(s) in MSG_LOG');
END;