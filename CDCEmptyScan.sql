SELECT top 10 session_id,empty_scan_count from sys.dm_cdc_log_scan_sessions where empty_scan_count <> 0
