=================================================
SETTING UP REPLICATION IN MS SQL SERVER
=================================================

PNGOMNIFLOWDBV2 JOB STEPS
JOB STEP 1: Queue Reader Agent startup message.
sp_MSadd_qreader_history @perfmon_increment = 0, @agent_id = 1, @runstatus = 1,  
                    @comments = N'Starting agent.'
					
					
					
JOB STEP 2:Run agent.
-Distributor [PNGOMNIFLOWDB2V] -DistributionDB [Dist1] -DistributorSecurityMode 1  -Continuous

JOB STEP 3: Detect nonlogged agent shutdown.
sp_MSdetect_nonlogged_shutdown @subsystem = 'QueueReader', @agent_id = 1	


=====================================================
OMNIFLOW KCC REPLICATION CREATION SCRIPT
=====================================================
-- Enabling the replication database
use master
exec sp_replicationdboption @dbname = N'KCC', @optname = N'publish', @value = N'true'
GO

exec [KCC].sys.sp_addlogreader_agent @job_login = null, @job_password = null, @publisher_security_mode = 1
GO
-- Adding the transactional publication
use [KCC]
exec sp_addpublication @publication = N'AR_PUBLICATION_00005', @description = N'Qlik Replicate: Anonymous Transactional publication for Database: KCC , from Publisher: PNGOMNIFLOWDB2V.', @sync_method = N'native', @retention = 1, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'AR_PUBLICATION_00005', @frequency_type = 4, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 8, @frequency_subday_interval = 1, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1
exec sp_grant_publication_access @publication = N'AR_PUBLICATION_00005', @login = N'sqldba'
GO

-- Adding the transactional articles
use [KCC]
exec sp_addarticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1010102639', @source_owner = N'dbo', @source_object = N'PDBGroupMember', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000000050D3, @identityrangemanagementoption = N'none', @destination_table = N'PDBGroupMember', @destination_owner = N'dbo', @status = 16, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_PDBGroupMember]', @del_cmd = N'CALL [sp_MSdel_PDBGroupMember]', @upd_cmd = N'MCALL [sp_MSupd_PDBGroupMember]', @filter_clause = N'(1=0)'

-- Adding the article filter
exec sp_articlefilter @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1010102639', @filter_name = N'AR_FILTER_00005_1010102639', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1010102639', @view_name = N'syncobj_0x3830393645443432', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO
use [KCC]
exec sp_addarticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1141579105', @source_owner = N'dbo', @source_object = N'PDBGroup', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000000050D3, @identityrangemanagementoption = N'none', @destination_table = N'PDBGroup', @destination_owner = N'dbo', @status = 16, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_PDBGroup]', @del_cmd = N'CALL [sp_MSdel_PDBGroup]', @upd_cmd = N'MCALL [sp_MSupd_PDBGroup]', @filter_clause = N'(1=0)'

-- Adding the article filter
exec sp_articlefilter @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1141579105', @filter_name = N'AR_FILTER_00005_1141579105', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1141579105', @view_name = N'syncobj_0x4437464336454331', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO
use [KCC]
exec sp_addarticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_448772706', @source_owner = N'dbo', @source_object = N'WFFilterTable', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000000050D3, @identityrangemanagementoption = N'none', @destination_table = N'WFFilterTable', @destination_owner = N'dbo', @status = 16, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_WFFilterTable]', @del_cmd = N'CALL [sp_MSdel_WFFilterTable]', @upd_cmd = N'MCALL [sp_MSupd_WFFilterTable]', @filter_clause = N'(1=0)'

-- Adding the article filter
exec sp_articlefilter @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_448772706', @filter_name = N'AR_FILTER_00005_448772706', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_448772706', @view_name = N'syncobj_0x3535423433344431', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO
use [KCC]
exec sp_addarticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_901578250', @source_owner = N'dbo', @source_object = N'PDBUser', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x00000000000050D3, @identityrangemanagementoption = N'none', @destination_table = N'PDBUser', @destination_owner = N'dbo', @status = 16, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_PDBUser]', @del_cmd = N'CALL [sp_MSdel_PDBUser]', @upd_cmd = N'MCALL [sp_MSupd_PDBUser]', @filter_clause = N'(1=0)'

-- Adding the article filter
exec sp_articlefilter @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_901578250', @filter_name = N'AR_FILTER_00005_901578250', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_901578250', @view_name = N'syncobj_0x4332334444354130', @filter_clause = N'(1=0)', @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO

=================================================
DROPPING REPLICATION IN OMNIFLOW
=================================================
-- Dropping the transactional articles
use [KCC]
exec sp_dropsubscription @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1010102639', @subscriber = N'all', @destination_db = N'all'
GO
use [KCC]
exec sp_droparticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1010102639', @force_invalidate_snapshot = 1
GO
use [KCC]
exec sp_dropsubscription @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1141579105', @subscriber = N'all', @destination_db = N'all'
GO
use [KCC]
exec sp_droparticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_1141579105', @force_invalidate_snapshot = 1
GO
use [KCC]
exec sp_dropsubscription @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_448772706', @subscriber = N'all', @destination_db = N'all'
GO
use [KCC]
exec sp_droparticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_448772706', @force_invalidate_snapshot = 1
GO
use [KCC]
exec sp_dropsubscription @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_901578250', @subscriber = N'all', @destination_db = N'all'
GO
use [KCC]
exec sp_droparticle @publication = N'AR_PUBLICATION_00005', @article = N'AR_ARTICLE_00005_901578250', @force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
use [KCC]
exec sp_droppublication @publication = N'AR_PUBLICATION_00005'
GO

				