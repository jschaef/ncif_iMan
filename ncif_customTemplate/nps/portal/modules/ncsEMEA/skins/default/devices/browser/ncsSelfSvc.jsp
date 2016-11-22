
<%-- 
	redirect page back if not managing self 
	requires helper.jsp

	usage: 
		<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/browser/ncsSelfSvc.jsp" 	%>
		<c:if test="${ncsTargetSelf}">
			... html body to be excluded ...
		</c:if>


	Note: 
	we could also check the requestScope: Book.displayName and make this dependent on book name

			obs: setTimeout('history.back()', 1000);
			obs: top.history.back();




--%>

<c:catch var="errSelfSvc" >
	<c:if test="${not ncsTargetSelf}">

		<table cellpadding="8" border="1">
		<tr><td><b>	User   </b></td><td>	<%= ncs_objectName  	%>		</td></tr>
		<tr><td><b>	Target </b></td><td>	<%= ncs_Target		%>		</td></tr>
		</table>


  		<script type='text/javascript'>
			alert("Diese Seite dient ausschliesslich dem Self-Service");
			history.go(-2);
   		</script>
	</c:if>
</c:catch>
<c:if test="${not empty errSelfSvc}">
	<h3>	<c:out value="${errSelfSvc.message}"/>	</h3>
</c:if>

