<%@ page import="java.text.*, java.util.*, 
         com.novell.ncsEMEA.util.*,
         com.novell.ncs.lib.nldap.*,
         com.novell.nps.gadgetManager.BaseGadgetInstance,
         javax.naming.NamingException"%>

<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ page errorPage="/portal/modules/ncsEMEA/skins/default/devices/default/ncsGenException.jsp"%>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>
<%   
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
   c.stringTable("com.novell.ncsEMEA.resources");
%>
<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>
<iman:stringtable bundle="com.novell.ncsEMEA.resources"/>
<HTML>
  <HEAD>
    <meta http-equiv="Page-Enter" content="revealTrans(Transition=12,Duration=0.3)">
    <meta http-equiv="Page-exit"  content="revealTrans(Transition=12,Duration=0.3)">
    <TITLE><iman:string key="ProductName"/></TITLE>
    <LINK rel='stylesheet' href='<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css'>
    <iman:eMFrameScripts/>
    <iman:osScripts/>

   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- define common Java/JS functions --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_functions.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- get the parameters from XML -- see example xml and description there --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_getPar.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>

  <script type='text/javascript'>
    // initialize 
    function onInit()
    {
      var form  = document.forms[0];
      // focus on first input field
      var field = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( 1, 0, ncsUtilSearch.sPrefixValTxt ) %>' )[0];
      if ( field != null ) 
      {
        field.focus;
      }
    }
  </script>

  </HEAD>


   <BODY onload='onInit();'>
   
   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- declare form start & hidden input --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_formHeader.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>

   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- if needed, overwrite search parameters here ... --%>
   <%-- ------------------------------------------------------------------------------------------------- --%>

   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- show search masks --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_searchMask.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>

   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- show search results --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_searchResults.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>
   
   </FORM>

   <%-- ------------------------------------------------------------------------------------------------- --%>
   <%-- show hidden debug info --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_debugVars.jsp" %>
   <%-- ------------------------------------------------------------------------------------------------- --%>

  <iman:osFooter/>
  </body>
</HTML>
