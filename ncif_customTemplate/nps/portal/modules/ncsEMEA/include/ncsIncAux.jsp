<%--
	// java scripts used by Novell Consulting Services (NCS)
	// 
	// last change 2003-06-27 (WS)  
        //  obsolete with iManager 2.0.2 
	//
	// include into JSP with 
	//
	// 	 <%@ include file="/portal/modules/ncsEMEA/include/ncsIncAux.jsp"  %>
	//
	//
	//
	// Display Vars with 	<x:out select="$myVar/."/>	// extract info from XML
	//			<c:out value="${myVar}"/>	// show as XML
	//	
--%>


<%--
	script to add auxiliary class on the fly (for CREATE pages)
	Sample call (within FORM tag):	
		<%@ include file="/portal/modules/ncsEMEA/include/ncsIncAux.jsp"  %>
		<INPUT type='hidden' name='eDir$target$Object_Class' value='<%= customAuxClass("User; myAux1; myAux2") %>'>
    or use different separator (if ";" is needed in class names )
		<INPUT type='hidden' name='eDir$target$Object_Class' value='<%= customAuxClass("User, myAux1, myAux2", ",") %>'>
--%>
<%!
   public String customAuxClass ( String sClasses, String sSeparator )
   {
      String result = "";
      String [] saClasses = sClasses.split( sSeparator );
      for ( int i = 0; i<saClasses.length; i++ )
        {
        result = result + "<value>" + saClasses[i].trim() + "</value>";
        }
      return ( "<Object_Class>" + result + "</Object_Class>" );
    }

   public String customAuxClass ( String sClasses )
   {
      return ( customAuxClass ( sClasses, ";" ) );
    }
%>




<%--
	script to add auxiliary class on the fly (for MODIFY pages: add to existing objects)
	Sample call (within FORM tag):	
		<c:set var="addAuxClass" value="myNewAuxClass"	/>
		<%@ include file="/portal/modules/ncsEMEA/include/ncsIncAux.jsp"  %>
		<INPUT type='text' name='eDir$target$Object_Class' size='120' value='<c:out value="${Object_Class_Mod}" 		escapeXml="false"/>'>
--%>

<c:set var="auxClassPresent" 	value="${false}"	/>
<c:set var="Object_Class_Mod" ><Object_Class><x:forEach var="oc" select="$edasXml/edas/Object_Class/value"><c:out value="${oc}" escapeXml="false"/><x:if select=".=$addAuxClass"><c:set var="auxClassPresent" value="${true}"/></x:if></x:forEach><c:if test="${auxClassPresent=='false'}"><value><c:out value="${addAuxClass}"/></value></c:if></Object_Class></c:set>



