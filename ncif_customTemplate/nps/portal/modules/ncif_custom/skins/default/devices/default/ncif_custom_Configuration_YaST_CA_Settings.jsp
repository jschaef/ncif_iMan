<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils" %>
<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>
<%
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("FwResources");
   c.stringTable("DevResources");
%>
<iman:stringtable bundle="DevResources" />
<iman:stringtable bundle="FwResources" />
<x:parse xml="${edas}" var="edasXml"/>

<%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>

<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <iman:stylesheet/>
   <iman:uihandlerTools/>
   <iman:pageScripts/>

   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
   <iman:osScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
//         form._ncifDHCPLocatorCtx.focus();
//         onMVSelectChange("ncifUCOCtx", document.getElementById("_ncifUCOCtx"));
//         onMVSelectChange("ncifLUMAdmGrp", document.getElementById("_ncifLUMAdmGrp"));
         returnFromOS();
      }

      <%-- ---------------------------------------------------------------- --%>
      <%--    What should this method do?                                   --%>
      <%--    -data validation                                              --%>
      <%--    -general page cleanup before being submitted                  --%>
      <%--    -if this method returns false, the page will not be saved     --%>
      <%--    Called when user leaves this page or applys changes           --%>
      <%-- ---------------------------------------------------------------- --%>
      function isPageValid( action )
      {
         var form=document.forms[0];

         var success = notifyAllOfExit();
         if(!success)
         {
            return false;
         }
			if ( success ) success = wsValidate( action );
			return( success );
      }

   </SCRIPT>
</HEAD>

<BODY onLoad="onInit();">
<FORM name="form" method="post" action="webacc" >
   <iman:messagebar />
   <iman:bookvars/>

   <!---- Shared Form Code ---->


   <!-- Automatic Aux Class Extension -->
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifConfiguration" >


   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">

<%--		
		ncifCACn 
		ncifCACountry
		ncifCAEmail
		ncifCALocality 
		ncifCAName
		ncifCAOrg 
		ncifCAOrgUnit 
		ncifCAPwd
		ncifCAState
--%>		
		<%-- ncifCACn --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCACn.jspf"  %>  

      <%-- ncifCACountry --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCACountry.jspf"  %>  

      <%-- ncifCAEmail --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAEmail.jspf"  %>  

      <%-- ncifCALocality --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCALocality.jspf"  %>  

      <%-- ncifCAName --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAName.jspf"  %>  

      <%-- ncifCAOrg --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAOrg.jspf"  %>  

      <%-- ncifCAOrgUnit --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAOrgUnit.jspf"  %>  

      <%-- ncifCAPwd --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAPwd.jspf"  %>  

      <%-- ncifCAState --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifCAState.jspf"  %>  


   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
