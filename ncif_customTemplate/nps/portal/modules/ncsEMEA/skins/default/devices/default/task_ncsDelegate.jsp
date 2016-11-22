<%@ page import="com.novell.ncsEMEA.util.*, com.novell.nps.gadgetManager.BaseGadgetInstance,
        javax.naming.NamingException,
        java.text.DateFormat, java.util.Date"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>


<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>

<%   
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<%-- ------------------------------------------------------------------------------------------------- --%>

<%-- define common Java/JS functions --%>

<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_functions.jsp" %>

<%-- ------------------------------------------------------------------------------------------------- --%>

<%-- get the parameters from XML --%>
<%-- see example xml and description there --%>

<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_getPar.jsp" %>


<%-- ------------------------------------------------------------------------------------------------- --%>


<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
   <iman:osScripts/>
</HEAD>

<BODY>

<%-- ------------------------------------------------------------------------------------------------- --%>

<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_parCheck.jsp" %>

<%-- ------------------------------------------------------------------------------------------------- --%>

<% 
  c.set("TaskHeader.title",   ncsUtilSearch.searchProperties.getProperty( ncs_thisTaskShort ) );
  // we may have passed multiple classes - take first one
  c.set("TaskHeader.iconUrl", c.plus("dir/", NcsUtil.stringToStringArray( xml_searchClass )[0] + ".gif")); 
  c.set("TaskHeader.iconAlt", ncs_thisTaskShort ); 
%>
<jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

<p><p>

<%-- ------------------------------------------------------------------------------------------------- --%>

<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsDelegate_results.jsp" %>

<%-- used in task_ncsDelegate --%>

<%-- ------------------------------------------------------------------------------------------------- --%>

</body>
</HTML>

