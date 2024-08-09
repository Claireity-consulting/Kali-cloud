			</div>
	</div>

{if $authentication_success}
	<div class="push"></div>
</div>
   <div class="footer">
	<div id="foot">
    	<ul class="links">
{append var="nav_links" value="Home" index=""}
{append var="nav_links" value="List FTP" index="ftp"}
{if $enable_http_mode && ($show_http_to_users || $priv_is_admin)}
{append var="nav_links" value="List HTTP" index="http"}
{/if}
{if $show_other_to_users || $priv_is_admin}
{append var="nav_links" value="Other" index="other"}
{append var="nav_links" value="Statistics" index="stats"}
{/if}
{append var="nav_links" value="Domains" index="ping"}
{append var="nav_links" value="Logs" index="log"}
{append var="nav_links" value="Reports" index="reports"}
{append var="nav_links" value="Management" index="admin"}
{if $show_help_to_users || $priv_is_admin}
{append var="nav_links" value="Help" index="help"}
{/if}
{append var="nav_links" value="Log out" index="exit"}

{foreach from=$nav_links key=action item=contents name=nav}
			<li><a href="{$smarty.server.SCRIPT_NAME}{if $action != ""}?action={$action}{/if}">{$contents}</a>{if !$smarty.foreach.nav.last} | {/if}</li>
{/foreach}
     	</ul>
    </div>
	</div>
{/if}

</body>
</html>
<!-- This page was generated in {stopwatch} seconds -->