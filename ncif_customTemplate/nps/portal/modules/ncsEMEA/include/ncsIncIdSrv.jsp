<%--
	// java scripts for IdServer used by Novell Consulting Services (NCS)
	// 
	// last change 2003-04-27 (WS)
	//
	//	requires nceInc.jsp & nceIncGez.jsp
	//
	// include into JSP with 
	//
	// 	 <%@ include file="/portal/modules/ncsEMEA/include/ncsIncIdSrv.jsp"  %>
	//
	//
	//
	//	<%	String newID = getIdServerId();  	%>	
	//	<h3>	IdServer returned: "<%= newID %>"	</h3>
	//	
--%>


<%--	IdServer	IdServer	IdServer	IdServer	IdServer	IdServer	IdServer	--%>




<%--	imports needed for idsrv		--%>

<%@  	page import="com.novell.ncsEMEA.idsrv.*" 	%>


<%!

    // return id from idserver
   private String getIdServerId()
   {
     try
     {
	String id = "n/a";
	id = IDClient.getNextID("10.50.20.1", "1099", "GEZ-Global-ID", "iManager");
//	id = IDClient.getNextID("localhost", "1099", "IdServer-Externals", "iManager");
//	id = IDClient.getNextID(host, port, policy, clientName[, traceLevel]);
	return(id);
     }
     catch ( Exception e )   
     { 
       return ( "getIdServerId: " + e.getMessage() );
     }
   }

%>






