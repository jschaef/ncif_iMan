<%-- 

	JSP segment that shows current scope variables

include with
     <%@ include file="/portal/modules/ncsEMEA/include/helperScope.jsp"  %>



	to access one var directly, use
		<c:out value="${pageScope.xxx}" />	
		<c:out value="${requestScope.xxx}" />	
		<c:out value="${sessionScope.xxx}" />	
		<c:out value="${applicationScope.xxx}" />	
		or
		<c:out value="${xxx}" />	

from Java:
  String sMyAddress   = request.getSession().getAttribute("BROWSER_HOST").toString(); 
  String sSrvAddress  = request.getSession().getAttribute("PORTAL_HOST_NAME").toString(); 


  NcsUtil.getPagecontextAttribute( pageContext,  "javax.servlet.jsp.jstl.fmt.locale.page", "" );
  NcsUtil.getRequestAttribute(     request,      "javax.servlet.include.request_uri",      "" );
  NcsUtil.getSessionAttribute(     request,      "xxx",                                    "" );


	to set a new var, use
		<c:set var="xxx" value="myval" scope="page" />	
		<c:set var="xxx" value="myval" scope="request" />	
		<c:set var="xxx" value="myval" scope="session" />	
		<c:set var="xxx" value="myval" scope="application" />
		or
		<c:set var="xxx" scope="page" >	myval </c:set>

 --%>


<hr>
<a name="applicationScope"></a>

Scope : 
<a href="#applicationScope"><b>application</b></a>&nbsp;
<a href="#pageScope"       ><b>page</b></a>&nbsp;
<a href="#sessionScope"    ><b>session</b></a>&nbsp;
<a href="#requestScope"    ><b>request</b></a>&nbsp;
<a href="#config"          ><b>config</b></a>&nbsp;
<a href="#initParam"       ><b>initParam</b></a>&nbsp;
<hr>

<table border="1" cellpadding="1">
	<tr>	<td>	<b>applicationScope:</b>	</td>	</tr>
	<c:forEach var="rs" items="${applicationScope}">
	<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
	</c:forEach>
</table>

<p>
<hr>
<a name="pageScope"></a>

<a href="#applicationScope">  <b>applicationScope</b> 	</a>		&nbsp;
<a href="#pageScope"	>     <b>pageScope</b>     	</a>		&nbsp;
<a href="#sessionScope"	>     <b>sessionScope</b>     	</a>		&nbsp;
<a href="#requestScope"	>     <b>requestScope</b>     	</a>		&nbsp;
<a href="#config"	>     <b>config</b>     	</a>		&nbsp;
<a href="#initParam"	>     <b>initParam</b>     	</a>		&nbsp;
<hr>

<table border="1" cellpadding="1">
	<tr>	<td>	<b>pageScope:</b>	</td>	</tr>
		<c:forEach var="rs" items="${pageScope}">
		<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
		</c:forEach>
</table>

<p>
<hr>
<a name="sessionScope"></a>

<a href="#applicationScope">  <b>applicationScope</b> 	</a>		&nbsp;
<a href="#pageScope"	>     <b>pageScope</b>     	</a>		&nbsp;
<a href="#sessionScope"	>     <b>sessionScope</b>     	</a>		&nbsp;
<a href="#requestScope"	>     <b>requestScope</b>     	</a>		&nbsp;
<a href="#config"	>     <b>config</b>     	</a>		&nbsp;
<a href="#initParam"	>     <b>initParam</b>     	</a>		&nbsp;
<hr>


<table border="1" cellpadding="1">
	<tr>	<td>	<b>sessionScope:</b>	</td>	</tr>
		<c:forEach var="rs" items="${sessionScope}">
		<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
		</c:forEach>
</table>


<p>
<hr>
<a name="requestScope"></a>

<a href="#applicationScope">  <b>applicationScope</b> 	</a>		&nbsp;
<a href="#pageScope"	>     <b>pageScope</b>     	</a>		&nbsp;
<a href="#sessionScope"	>     <b>sessionScope</b>     	</a>		&nbsp;
<a href="#requestScope"	>     <b>requestScope</b>     	</a>		&nbsp;
<a href="#config"	>     <b>config</b>     	</a>		&nbsp;
<a href="#initParam"	>     <b>initParam</b>     	</a>		&nbsp;
<hr>

<table border="1" cellpadding="1">
	<tr>	<td>	<b>requestScope:</b>	</td>	</tr>
	<c:forEach var="rs" items="${requestScope}">
	<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
	</c:forEach>
</table>


<p>
<hr>
<a name="config"></a>

<a href="#applicationScope">  <b>applicationScope</b> 	</a>		&nbsp;
<a href="#pageScope"	>     <b>pageScope</b>     	</a>		&nbsp;
<a href="#sessionScope"	>     <b>sessionScope</b>     	</a>		&nbsp;
<a href="#requestScope"	>     <b>requestScope</b>     	</a>		&nbsp;
<a href="#config"	>     <b>config</b>     	</a>		&nbsp;
<a href="#initParam"	>     <b>initParam</b>     	</a>		&nbsp;
<hr>

<table border="1" cellpadding="1">
	<tr>	<td>	<b>config</b>	</td>	</tr>
	<c:forEach var="rs" items="${config}">
	<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
	</c:forEach>
</table>



<p>
<hr>
<a name="initParam"></a>

<a href="#applicationScope">  <b>applicationScope</b> 	</a>		&nbsp;
<a href="#pageScope"	>     <b>pageScope</b>     	</a>		&nbsp;
<a href="#sessionScope"	>     <b>sessionScope</b>     	</a>		&nbsp;
<a href="#requestScope"	>     <b>requestScope</b>     	</a>		&nbsp;
<a href="#config"	>     <b>config</b>     	</a>		&nbsp;
<a href="#initParam"	>     <b>initParam</b>     	</a>		&nbsp;
<hr>

<table border="1" cellpadding="1">
	<tr>	<td>	<b>initParam</b>	</td>	</tr>
	<c:forEach var="rs" items="${initParam}">
	<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
	</c:forEach>
</table>



<p>
<hr>

