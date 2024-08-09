{if !isset($confirm_code)}
	{assign var='confirm_code' value=''}
{/if}
		<h4 class="achtung_header">{$msg|default:"Are you sure?"}</h4>
		<div style="height:40px;">
                <div class="buttons">
					<a href="{$yes_code|default:{$smarty.server.SCRIPT_NAME} nofilter}" class="positive" style="width:50px">
					    <img src="includes/design/images/accept.png" alt="" />
					    Yes
					</a>
					<a href="{$no_code|default:{$smarty.server.SCRIPT_NAME} nofilter}" class="negative" style="width:50px">
					    <img src="includes/design/images/cross.png" alt="" /> 
					    No
					</a>
	    		</div>
	    </div>
