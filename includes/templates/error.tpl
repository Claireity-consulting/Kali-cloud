<h4 class="achtung_header">
{if $err_code == 'ERR_NOT_ENOUGH_PRIVILEGES'}
	Error: Not enough privileges!
{elseif $err_code == 'ERR_UNK_LOG_ID'}
	Error: Unknown log id!
{elseif $err_code == 'ERR_UNK_REPORT_ID'}
	Error: Unknown report id!
{elseif $err_code == 'ERR_SRV_CONFIGURATION'}
	Attention: There is problem(s) with the server configuration!
{elseif $err_code == 'ERR_WRONG_PASSWORD'}
	Error: Wrong password
{elseif $err_code == 'ERR_PASSWORD_MISMATCH'}
	Error: Password mismatch!
{elseif $err_code == 'ERR_EMPTY_PASSWORD'}
	Error: empty password!
{else}
	An error has occurred!
{/if}
</h4><br />

{if isset($back_link)}
<a href="{$smarty.server.SCRIPT_NAME}{$back_link nofilter}">Go back and try again</a>.
<br /><br />
{/if}