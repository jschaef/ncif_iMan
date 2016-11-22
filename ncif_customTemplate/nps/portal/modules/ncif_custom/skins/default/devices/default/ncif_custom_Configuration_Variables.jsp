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

<%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>

<x:parse xml="${edas}" var="edasXml"/>

<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <iman:stylesheet/>
   <iman:uihandlerTools/>
   <iman:pageScripts/>

   <iman:eMFrameScripts/>
   <iman:mvedScripts/>
   <iman:validateNumberScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="@CUSTOMER.ATTR.PREFIX.NCIF@Configuration" >


   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncif_custom_InstServers --%>
      <TR>
         <TD align="left" colspan="2">
            Short Hostname of Installation Server:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncif_custom_InstServers.writeable}">
               <INPUT type="hidden" name="eDir$target$ncif_custom_InstServers" value="<c:out value="${eDir$target$ncif_custom_InstServers}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncif_custom_InstServers" scope="request"/>
            <iman:mved maxLength="64512" readonly="${!edasRights.target.ncif_custom_InstServers.writeable}" enforceUnique="true" ignoreCase="true" minLength="0" name="_ncif_custom_InstServers"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncif_custom_InstServers/@mode"/></c:set>
            <iman:mooMode name="_ncif_custom_InstServers_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncif_custom_InstServers = new UiObject();
         <c:if test="${edasRights.target.ncif_custom_InstServers.writeable}">
            addToNotificationList('ncif_custom_InstServers', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
