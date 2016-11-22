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
         onMVSelectChange("ncifSLPScopes", document.getElementById("_ncifSLPScopes"));
         onMVSelectChange("ncifSLPType", document.getElementById("_ncifSLPType"));
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


      <%-- ncifDefaultGateways --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDefaultGateways.jspf"  %>

      <%-- ncifDNSServers --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDNSServers.jspf"  %>

      <%-- ncifDNSDomains --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDNSDomains.jspf"  %>	
		
      <%-- ncifNTPServers --%>
      <TR>
         <TD align="left" colspan="2">
            NTP Server(s) (i.e. 10.1.50.152):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifNTPServers.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifNTPServers" value="<c:out value="${eDir$target$ncifNTPServers}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncifNTPServers" scope="request"/>
            <iman:mved maxLength="64512" readonly="${!edasRights.target.ncifNTPServers.writeable}" enforceUnique="true" ignoreCase="true" minLength="0" name="_ncifNTPServers"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifNTPServers/@mode"/></c:set>
            <iman:mooMode name="_ncifNTPServers_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifNTPServers = new UiObject();
         <c:if test="${edasRights.target.ncifNTPServers.writeable}">
            addToNotificationList('ncifNTPServers', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifSLPDAServers --%>
      <TR>
         <TD align="left" colspan="2">
	    SLPDA Servers:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifSLPDAServers.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifSLPDAServers" value="<c:out value="${eDir$target$ncifSLPDAServers}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncifSLPDAServers" scope="request"/>
            <iman:mved maxLength="64512" readonly="${!edasRights.target.ncifSLPDAServers.writeable}" enforceUnique="true" ignoreCase="true" minLength="0" name="_ncifSLPDAServers"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifSLPDAServers/@mode"/></c:set>
            <iman:mooMode name="_ncifSLPDAServers_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifSLPDAServers = new UiObject();
         <c:if test="${edasRights.target.ncifSLPDAServers.writeable}">
            addToNotificationList('ncifSLPDAServers', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>


      <%-- ncifSLPScopes --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifSLPScopes.jspf"  %>  


      <%-- ncifSLPType --%>
      <TR>
         <TD align="left" colspan="2">
            SLP Type:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifSLPType.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifSLPType" value="<c:out value="${eDir$target$ncifSLPType}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifSLPType = null; </SCRIPT>
            <SELECT name="_ncifSLPType" id="_ncifSLPType" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifSLPType', this)">
               <OPTION value=""><iman:string key="Studio.selectAnItem"/>
            <c:set var="testValue" value="open"/>
               <OPTION value="open" <x:if select="count($edasXml/edas/ncifSLPType/value[text()=$testValue])">selected</x:if>>open
            <c:set var="testValue" value="netware"/>
               <OPTION value="netware" <x:if select="count($edasXml/edas/ncifSLPType/value[text()=$testValue])">selected</x:if>>netware
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifSLPType/@mode"/></c:set>
            <iman:mooMode name="_ncifSLPType_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifSLPType = new UiObject();
         <c:if test="${edasRights.target.ncifSLPType.writeable}">
            addToNotificationList('ncifSLPType', 'uih_mvSelect');
            addActionHandler('ncifSLPType', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
