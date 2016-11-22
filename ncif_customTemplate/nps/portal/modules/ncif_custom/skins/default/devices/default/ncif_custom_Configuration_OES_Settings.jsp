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
   <iman:validateNumberScripts/>
   <iman:osScripts/>
   <iman:mvedScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         form._ncifServerCtx.focus();
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


      <%-- ncifServerCtx --%>
      <TR>
         <TD align="left" colspan="2">
            eDirectory Server Context:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifServerCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifServerCtx" value="<c:out value="${eDir$target$ncifServerCtx}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifServerCtx" id="spinner_ncifServerCtx" value="<x:out select="$edasXml/edas/ncifServerCtx/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifServerCtx.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifServerCtx.writeable}">
               <iman:os typeFilter="*" control="_ncifServerCtx" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifServerCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifServerCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifServerCtx = new UiObject();
         <c:if test="${edasRights.target.ncifServerCtx.writeable}">
            addToNotificationList('ncifServerCtx', 'uih_textfield');
            addActionHandler('ncifServerCtx', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifServerCtx.m_lowerBound = null;
         window.uiObject_ncifServerCtx.m_upperBound = null;
         window.uiObject_ncifServerCtx.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifReplicaServers --%>
      <TR>
         <TD align="left" colspan="2">
            eDirectory Replica Server (IP Address, i.e. 10.232.100.61):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifReplicaServers.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifReplicaServers" value="<c:out value="${eDir$target$ncifReplicaServers}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncifReplicaServers" scope="request"/>
            <iman:mved maxLength="64512" readonly="${!edasRights.target.ncifReplicaServers.writeable}" enforceUnique="true" ignoreCase="true" minLength="0" name="_ncifReplicaServers"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifReplicaServers/@mode"/></c:set>
            <iman:mooMode name="_ncifReplicaServers_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifReplicaServers = new UiObject();
         <c:if test="${edasRights.target.ncifReplicaServers.writeable}">
            addToNotificationList('ncifReplicaServers', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifLDAPServers --%>
      <TR>
         <TD align="left" colspan="2">
		  OES LDAP Server(s) (DNS name or IP Address)<br>
		  (recommend to use DNS cnames):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifLDAPServers.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifLDAPServers" value="<c:out value="${eDir$target$ncifLDAPServers}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncifLDAPServers" scope="request"/>
            <iman:mved maxLength="64512" readonly="${!edasRights.target.ncifLDAPServers.writeable}" enforceUnique="true" ignoreCase="true" minLength="0" name="_ncifLDAPServers"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifLDAPServers/@mode"/></c:set>
            <iman:mooMode name="_ncifLDAPServers_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifLDAPServers = new UiObject();
         <c:if test="${edasRights.target.ncifLDAPServers.writeable}">
            addToNotificationList('ncifLDAPServers', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
