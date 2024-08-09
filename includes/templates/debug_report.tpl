{if isset($parse_result) && $parse_result}
	<h4 class="success_header">
		The report has been successfully processed!
	</h4>
	Imported new passwords: <b>{$parse_new_ftp}</b>
	<br /><br />
{else if isset($parse_result) && !$parse_result}
	<h4 class="achtung_header">
	An error has occurred during report processing!
	</h4><br />
{/if}

<table id="table_view_report_data" width="800px" cellspacing="0">
	<tr><th width="100%">Treatment in debug mode</th></tr>
	{foreach from=$log_list item=log_item}
		<tr><td>
		{if strstr($log_item.log_line, 'ERR_')}
			<font style="font-weight: bold; color: #b72525">
			{$log_item.log_line}
		</font>
		{else}
			{$log_item.log_line}
		{/if}
		<font style="color: #bbbbbb; font-size: 10px;"> | {$log_item.log_extra}</font></td></tr>
	{/foreach}
</table>
