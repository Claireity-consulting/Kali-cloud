{if {$smarty.request.routine|default:''} == 'confirm_clear_log'}
{assign var='msg' value="Are you sure you want to clear the system logs?"}
{assign var='yes_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=log&amp;routine=clear_log"}
{assign var='no_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=log"}
{include file='confirm.tpl'}
{/if}		
	{if $smarty.request.filter_ip|default:'' != '' || $smarty.request.filter_hwid|default:'' != '' || $smarty.request.filter_notify|default:'' != ''}
		<h4>Attention! Filter Activated. <a href="{$smarty.server.SCRIPT_NAME}?action=log">Cancel</a>.</h4><br />
	{/if}

	<a class="download_nav" href="{$smarty.server.SCRIPT_NAME}?action=log&amp;routine=download_log">Download logs</a> ({$log_events_count} {$log_events_count|items})<br />

	{if $priv_can_delete}
		<a class="delete_nav" href="{$smarty.server.SCRIPT_NAME}?action=log&amp;routine=confirm_clear_log">Clear logs</a> ({$total_log_table_size|file_size})<br />
	{/if}
	<br />

	<form name="filter_frm" style="width:300px;" action="">
	<input type="submit" style="position:absolute;left:-10000px;top:-10000px;" />
	<input type="hidden" name="action" value="log" />
	{if $smarty.request.filter_ip|default:'' != ''}
		<input type="hidden" name="filter_ip" value="{$smarty.request.filter_ip|default:''}" />
	{/if}
	{if $smarty.request.filter_hwid|default:'' != ''}
		<input type="hidden" name="filter_hwid" value="{$smarty.request.filter_hwid|default:''}" />
	{/if}
	<input style="margin-left:10px;" type="checkbox" onclick="javascript:document.filter_frm.submit();" id="filter_notify" name="filter_notify" value="1" 
	{if $smarty.request.filter_notify|default:'' == '1'}
		checked="checked"
	{/if}
	/><label for="filter_notify"> Show notification</label>
	</form><br />

	{if count($log_list)}
		<table id="table_logs" width="700px" cellspacing="0" summary="Log contents">
			<tr>
			<th width="14%">Report</th>
			<th width="61%">Text</th>
			<th width="25%">Time added</th>
			</tr>

			{foreach from=$log_list item=log_item}
				<tr>
				{if $log_item.report_id == '' || $log_item.report_id == '0'}
					<td><a class="view_report_delete"
				{else}
					<td><a class="view_report"
				{/if}
				 href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=view_report&amp;report_id={$log_item.report_id}&amp;log_id={$log_item.log_id}">Open</a></td>

				{if strlen($log_item.log_line) > 55}
					<td title="{$log_item.log_line}">
				{else}
					<td>
				{/if}
				{$log_item.log_line|truncate:55:'...':true:false}
				</td>
				<td>{$log_item.import_time}</td>
				</tr>
			{/foreach}

		</table><br />

		{if $paginate.page_total gt 1}
			<div id="page_select">
    			{paginate_prev} {paginate_middle link_prefix=" " link_suffix=" |" format="page" prefix="" suffix=""} {paginate_next}
    		</div>
    	{/if}
	{/if}