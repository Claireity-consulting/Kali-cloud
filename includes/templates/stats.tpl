	{* Navigation menu *}
	<a class="update_nav" href="{$smarty.server.SCRIPT_NAME}?action=stats">Update</a><br /><br />
	
	<div class="mychart">
	<img width="680" height="230" src="{$smarty.server.SCRIPT_NAME}?action=chart&amp;routine=last_24_hours" alt="" />
 	</div>	
	<div class="mychart">
	<img width="680" height="230" src="{$smarty.server.SCRIPT_NAME}?action=chart&amp;routine=last_month" alt="" />
 	</div>	
	<div class="mychart" style="height: 250px;">
	<img width="680" height="250" src="{$smarty.server.SCRIPT_NAME}?action=chart&amp;routine=os" alt="" />
 	</div>	

	{* FTP Clients stats *}
 	{if count($ftp_clients_list)}
	<h4>Popular FTP clients</h4>
	<table id="FTPClientsStats" width="700px" cellspacing="0" summary="FTP clients popularity">
	<tbody><tr>
	<th width="75%">FTP client</th>
	<th width="25%">Number of passwords</th>
	</tr></tbody>
	<tbody>
	{assign var="max_ftp_client_list" value=10}
	{foreach from=$ftp_clients_list item=ftp_client name=ftp_client_traversal}
		{assign var=img_file value="includes/design/images/modules/"|cat:$ftp_client.module|cat:".png"}
		{if file_exists($img_file)}
			{assign var=img_url value="<img style=\"margin-top:-2px;vertical-align:middle;\" src=\""|cat:$img_file|cat:"\" width=\"16\" height=\"16\" alt=\"\" /> "}
		{else}
			{assign var=img_url value=""}
		{/if}

		{if $smarty.foreach.ftp_client_traversal.index == $max_ftp_client_list}
			{assign var=ftp_clients_extra_data value=true}
			</tbody>
			<tbody id="hidden_rows" style="display: none;">
		{elseif $smarty.foreach.ftp_client_traversal.index < $max_ftp_client_list}
		{/if}
		<tr>
		<td style="padding-bottom:2px">{$img_url nofilter}{$ftp_client.name}</td>
		<td><b>{$ftp_client.count}</b> ({$ftp_client.percentage}%)</td>
		</tr>
	{/foreach}
	</tbody></table>
	{* Show more FTPClients link *}
	{if isset($ftp_clients_extra_data)}
		<div style="width:700px">
		<p align="right"><a class="local_nav" href="javascript:showMore('')">Show all</a> <font style="font-size:11px;">({count($ftp_clients_list)})</font></p>
		</div>
	{/if}
	<br />
	{/if}

	{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
        {* HTTP Clients stats *}
	 	{if count($http_clients_list)}
			<h4>Popular web browsers</h4>
			<table id="HTTPClientsStats" width="700px" cellspacing="0" summary="HTTP clients popularity">
			<tr>
			<th width="75%">Browser</th>
			<th width="25%">Number of passwords</th>
			</tr>

			{foreach from=$http_clients_list item=http_client}
				<tr>
				{assign var=img_file value="includes/design/images/modules/"|cat:$http_client.module|cat:".png"}
				{if file_exists($img_file)}
					{assign var=img_url value="<img style=\"margin-top:-2px;vertical-align:middle;\" src=\""|cat:$img_file|cat:"\" width=\"16\" height=\"16\" alt=\"\" /> "}
				{else}
					{assign var=img_url value=""}
				{/if}
	
				<td style="padding-bottom:2px">{$img_url nofilter}{$http_client.name}</td>
				<td><b>{$http_client.count}</b> ({$http_client.percentage}%)</td>
				</tr>
			{/foreach}
			</table>
			<br />
		{/if}
	{/if}

	{if $enable_email_mode && ($show_email_to_users || $priv_is_admin)}
        {* E-mail Clients stats *}
	 	{if count($email_clients_list)}
			<h4>Popular E-mail clients</h4>
			<table id="EmailClientsStats" width="700px" cellspacing="0" summary="E-mail clients popularity">
			<tr>
			<th width="75%">E-mail client</th>
			<th width="25%">Number of passwords</th>
			</tr>

			{foreach from=$email_clients_list item=email_client}
				<tr>
				{assign var=img_file value="includes/design/images/modules/"|cat:$email_client.module|cat:".png"}
				{if file_exists($img_file)}
					{assign var=img_url value="<img style=\"margin-top:-2px;vertical-align:middle;\" src=\""|cat:$img_file|cat:"\" width=\"16\" height=\"16\" alt=\"\" /> "}
				{else}
					{assign var=img_url value=""}
				{/if}
	
				<td style="padding-bottom:2px">{$img_url nofilter}{$email_client.name}</td>
				<td><b>{$email_client.count}</b> ({$email_client.percentage}%)</td>
				</tr>
			{/foreach}
			</table>
			<br />
		{/if}
	{/if}

	{* Country stats *}
 	{if count($country_list)}
		<h4>Country statistics</h4>
		<table id="CountryStats" width="700px" cellspacing="0" summary="Country statistics">
		<tbody><tr>
		<th width="50%">Country</th>
		<th width="25%">Number of reports</th>
		<th width="25%">Number of passwords</th>
		</tr></tbody>
		<tbody>
		{assign var="max_country_list" value=10}
		{foreach from=$country_list item=country_item name=country_list_traversal}
			{if $smarty.foreach.country_list_traversal.index == $max_country_list}
				{assign var=country_list_extra_data value=true}
				</tbody>
				<tbody id="hidden_rows_country" style="display: none;">
			{/if}

			<tr>
			{if $country_item.country_code == ''}
			<td><div style="margin-left:20px">Unknown</div></td>
			{else}
			<td>{country base_path="includes/design/images/flags/" country_code=$country_item.country_code country_name=$country_item.country_name}</td>
			{/if}
			<td><b>{$country_item.report_count}</b> ({$country_item.report_percentage}%)</td>
			<td><b>{$country_item.ftp_count}</b> ({$country_item.ftp_percentage}%)</td>
			</tr>
		{/foreach}
		</tbody></table>

		{* Show more country link *}
		{if isset($country_list_extra_data)}
			<div style="width:700px">
			<p align="right"><a class="local_nav_country" href="javascript:showMore('_country')">Show all</a> <font style="font-size:11px;">({count($country_list)})</font></p>
			</div>
		{/if}
	{/if}
