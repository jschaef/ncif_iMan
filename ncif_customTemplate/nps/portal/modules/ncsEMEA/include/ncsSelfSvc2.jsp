<%-- 

  // obsolete ...
  
	redirect page back if not managing self ( checks ID of book/task before doing the check, so this can be included in any page
  and is triggered dependent on book/task id

  checks, if the task/book ID contains the words "SELF" and "SERVICE" (not case sensitive)

  Note: while ncsSelfSvc.inc does an unconditional check for self service,
              ncsSelfSvc2.inc does an conditional check (dependent on book/task name) for self service,

	requires helper.jsp

	usage: 
		<%@ include file="/portal/modules/ncsEMEA/include/ncsSelfSvc2.jsp" 	%>
    <c:if test="${ncsSelfServiceTask}">
			... html body to be excluded ...
		</c:if>


	Note: 
	we could also check the requestScope: Book.displayName and make this dependent on book name

			obs: setTimeout('history.back()', 1000);
			obs: top.history.back();

--%>

<% 
    String  sSelf1            = "SELF";
    String  sSelf2            = "SERVICE";

    // get book/task name
    String  sSelfSvcTask  = request.getAttribute("GI_ID").toString();
    boolean bSelfSvcTask  = ( ( sSelfSvcTask.toUpperCase().indexOf( sSelf1 )>=0 ) && ( sSelfSvcTask.toUpperCase().indexOf( sSelf2 )>=0 ) );

    bSelfSvcTask          = (!bSelfSvcTask) || ncsCommon.getTarget().isMe();  // 
%>    

 <c:catch>
   <c:set	scope="request"	var="ncsSelfServiceTask" >
    <%=  bSelfSvcTask  %>
   </c:set>
   <c:set	scope="request"	var="ncsPreventSelfServiceTask" >
    <%=  !bSelfSvcTask  %>
   </c:set>
 </c:catch>


<% if ( !bSelfSvcTask ){ %>
    <%-- info --%> 
    <table cellpadding="8" border="3">
      <tr><td><b>	User   </b></td><td>	<%= ncsCommon.getUser().getDn()  	%>		</td></tr>
      <tr><td><b>	Target </b></td><td>	<%= ncsCommon.getTarget().getDn()		%>       </td></tr>
      <tr><td><b>	Task   </b></td><td>	<%= sSelfSvcTask		%>     </td></tr>
    </table>
    <%-- redirect --%>
    <%= ncs_RedirectJS %>
    <p>
<% } %>

<c:if test="${not empty errSelfSvc}">
	<h3>	<c:out value="${errSelfSvc.message}"/>	</h3>
</c:if>


