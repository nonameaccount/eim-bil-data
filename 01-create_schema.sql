-- create input and transactional tables; raw archival data goes into inpt, normalized data goes into trxn;
begin;
    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_contractor_poc
    (
        inpt_contractor_poc_id SERIAL PRIMARY KEY NOT NULL ,
        input_hash varchar(32) NULL,
        full_name          varchar(300) NULL,
        phone_number       varchar(20) NULL,
        email              varchar(255) NULL,
        date_of_submission varchar(30) NULL ,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_business_info
    (
        inpt_business_info_id SERIAL PRIMARY KEY NOT NULL,
        input_hash varchar(32) NULL,
        business_name           varchar(300) NULL,
        business_address        varchar(200) NOT NULL,
        city                    varchar(200) NOT NULL,
        state                   varchar(50) NOT NULL,
        zipcode                 varchar(20) NOT NULL,
        biz_socio_stat          varchar(200) NOT NULL,
        contract_num            varchar(100) NOT NULL,
        order_num               varchar(100) NULL,
        mod_num                 varchar(100) NULL,
        obligated_total_to_date varchar(100) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_buy_american
    (
        inpt_buy_american_id SERIAL PRIMARY KEY NOT NULL,
        input_hash varchar(32) NULL,
        jcn          varchar(100) NOT NULL,
        description  varchar(300) NOT NULL,
        dollar_value varchar(100) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_jobs_creation
    (
        inpt_jobs_creation_id SERIAL PRIMARY KEY NOT NULL,
        jcn                         varchar(100) NOT NULL,
        contractor_jobs_created     varchar(100) NOT NULL,
        first_tier_sub_jobs_created varchar(100) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_performance_location
    (
        inpt_performance_location_id SERIAL PRIMARY KEY NOT NULL,
        jcn          varchar(100) NOT NULL,
        city         varchar(200) NOT NULL,
        state        varchar(50) NOT NULL,
        zipcode      varchar(20) NOT NULL,
        dollar_value varchar(100) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_replaced_technology
    (
        inpt_replaced_technology_id SERIAL PRIMARY KEY NOT NULL,
        jcn                 varchar(100) NOT NULL,
        replaced_technology varchar(500) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.inpt_sub_contracting
    (
        inpt_sub_contracting_id SERIAL PRIMARY KEY NOT NULL,
        jcn          varchar(100) NOT NULL,
        lrg_business_concern varchar(100) NOT NULL,
        sm_business_concern varchar(100) NOT NULL,
        sm_disadvtg_business_concern varchar(100) NOT NULL,
        wmn_ownd_business_concern varchar(100) NOT NULL,
        socio_econ_disadvtg_business_concern varchar(100) NOT NULL,
        svc_disabled_vet_sm_business_concern varchar(100) NOT NULL,
        hubzone_sm_business_concern varchar(100) NOT NULL,
        vet_owned_sm_business_concern varchar(100) NOT NULL,
        hbcu_business_concern varchar(100) NOT NULL,
        stat_code smallint NOT NULL DEFAULT 0,
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );


    /***********************************************************************/

    -- Trxn tables
        CREATE TABLE IF NOT EXISTS bilfundrpt.stat_code_lkup
    (
        stat_code_lkup_id SERIAL PRIMARY KEY NOT NULL,
        stat_code smallint unique not null,
        description varchar(100) not null,
        notes varchar(800) null,
        mark_for_deletion boolean not null default false,
        create_date_time timestamp without time zone default localtimestamp not null
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.contractor_poc
    (
        contractor_poc_id SERIAL PRIMARY KEY NOT NULL,
        input_hash varchar(32) NOT NULL UNIQUE,
        full_name          varchar(300) NOT NULL,
        phone_number       varchar(20) NOT NULL,
        email              varchar(255) NOT NULL,
        date_of_submission timestamp NOT NULL,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.business_info
    (
        business_info_id SERIAL PRIMARY KEY NOT NULL,
        input_hash varchar(32) NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        business_name           varchar(300) NOT NULL ,
        business_address        varchar(200) NOT NULL ,
        city                    varchar(200) NOT NULL ,
        state                   varchar(50) NOT NULL ,
        zipcode                 varchar(20) NOT NULL ,
        biz_socio_stat          varchar(200) NOT NULL ,
        contract_num            varchar(100) NOT NULL UNIQUE,
        order_num               varchar(100) NULL ,
        mod_num                 integer NULL ,
        obligated_total_to_date numeric(10, 5) NOT NULL ,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.performance_location   -- Master list of JCNs
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        jcn          varchar(100) NOT NULL UNIQUE,
        city         varchar(200) NOT NULL,
        state        varchar(50) NOT NULL,
        zipcode      varchar(20) NOT NULL,
        dollar_value numeric(10, 5) NOT NULL,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.buy_american_hdr
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        jcn varchar(100) NOT NULL REFERENCES bilfundrpt.performance_location(jcn),
        --description  varchar(300) NOT NULL,
        dollar_value numeric(10, 5) NOT NULL ,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    /*
    CREATE TABLE IF NOT EXISTS bilfundrpt.buy_american_dtl
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash)
        , buy_american_hdr_id varchar(32) NOT NULL REFERENCES bilfundrpt.buy_american_hdr(input_hash)
        , description varchar(500) NOT NULL
        , stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code)
        , mark_for_deletion boolean NOT NULL DEFAULT FALSE
        , create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );
    */

    CREATE TABLE IF NOT EXISTS bilfundrpt.jobs_creation
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        jcn varchar(100) NOT NULL REFERENCES bilfundrpt.performance_location(jcn),
        contractor_jobs_created integer NOT NULL ,
        first_tier_sub_jobs_created integer NOT NULL ,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.replaced_technology
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        jcn varchar(100) NOT NULL REFERENCES bilfundrpt.performance_location(jcn),
        replaced_technology varchar(500),
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.sub_contracting
    (
        input_hash varchar(32) UNIQUE NOT NULL REFERENCES bilfundrpt.contractor_poc(input_hash),
        jcn          varchar(100) NOT NULL REFERENCES bilfundrpt.performance_location(jcn),
        lrg_business_concern varchar(100) NULL,
        sm_business_concern varchar(100) NULL,
        sm_disadvtg_business_concern varchar(100) NULL,
        wmn_ownd_business_concern varchar(100) NULL,
        socio_econ_disadvtg_business_concern varchar(100) NULL,
        svc_disabled_vet_sm_business_concern varchar(100) NULL,
        hubzone_sm_business_concern varchar(100) NULL,
        vet_owned_sm_business_concern varchar(100) NULL,
        hbcu_business_concern varchar(100) NULL,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean NOT NULL DEFAULT FALSE,
        create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );

    /*
    CREATE TABLE IF NOT EXISTS bilfundrpt.contract_jcn_xref
    (
        contract_jcn_xref_id SERIAL PRIMARY KEY NOT NULL
        , contract_number varchar(100) NOT NULL REFERENCES bilfundrpt.business_info(contract_num)
        , JCN varchar(100) NOT NULL REFERENCES bilfundrpt.performance_location(jcn)
        , stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code)
        , mark_for_deletion boolean NOT NULL DEFAULT FALSE
        , create_date_time timestamp without time zone DEFAULT localtimestamp NOT NULL
    );
    */


    CREATE TABLE IF NOT EXISTS bilfundrpt.msg_hdr
    (
        msg_hdr_id SERIAL PRIMARY KEY NOT NULL,
        module varchar(50) not null,
        sub_module varchar(50) not null,
        msg_severity_id integer null,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean not null default false,
        create_date_time timestamp without time zone default localtimestamp not null

    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.msg_dtl
    (
        msg_dtl_id SERIAL PRIMARY KEY NOT NULL,
        msg_hdr_id integer not null references bilfundrpt.msg_hdr(msg_hdr_id),
        msg varchar(512) not null,
        short_msg varchar(50) null,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean not null default false,
        create_date_time timestamp without time zone default localtimestamp not null
    );

    CREATE TABLE IF NOT EXISTS bilfundrpt.msg_log
    (
        msg_log_id serial primary key not null,
        msg_dtl_id integer not null references bilfundrpt.msg_dtl(msg_dtl_id),
        pgm_name varchar(80) null,
        msg varchar(512) not null,
        machine_name varchar(50) null,
        db_user_name varchar(50) null,
        schema_name varchar(50) null,
        process_id varchar(256) null,
        process_name varchar(25) null,
        thread_name varchar(512) null,
        session_state varchar(2000) null,
        misc_value_1 varchar(50) null,
        misc_value_2 varchar(50) null,
        misc_value_3 varchar(50) null,
        misc_num_1 numeric(15,5) null,
        misc_num_2 numeric(15,5) null,
        misc_num_3 numeric(15,5) null,
        stat_code smallint not null default 0 references bilfundrpt.stat_code_lkup(stat_code),
        mark_for_deletion boolean default false,
        create_date_time timestamp without time zone default localtimestamp not null
    );

commit;

--select * from information_schema.tables where table_type = 'BASE TABLE' and table_schema = 'public' and table_catalog = 'jerry';
/*
begin;
    drop table if exists bilfundrpt.inpt_business_info
    drop table if exists bilfundrpt.inpt_jobs_creation
    drop table if exists bilfundrpt.inpt_performance_location
    drop table if exists bilfundrpt.inpt_replaced_technology
    drop table if exists bilfundrpt.inpt_sub_contracting
    drop table if exists bilfundrpt.inpt_contractor_poc
    drop table if exists bilfundrpt.inpt_buy_american
    drop table if exists bilfundrpt.buy_american_dtl
    drop table if exists bilfundrpt.jobs_creation
    drop table if exists bilfundrpt.replaced_technology
    drop table if exists bilfundrpt.sub_contracting
    drop table if exists bilfundrpt.contract_jcn_xref
    drop table if exists bilfundrpt.buy_american_hdr
    drop table if exists bilfundrpt.business_info
    drop table if exists bilfundrpt.performance_location
    drop table if exists bilfundrpt.contractor_poc
    drop table if exists bilfundrpt.msg_log
    drop table if exists bilfundrpt.msg_dtl
    drop table if exists bilfundrpt.msg_hdr
    drop table if exists bilfundrpt.stat_code_lkup

commit;
rollback;
*/
