<html>
<body>
<h2>Error</h2>

<#if errorMsg?has_content>
    <h3>${errorMsg}</h3>
    <#--<p>${errorMsg.stackTrace}</p>-->
</#if>

</body>
</html>