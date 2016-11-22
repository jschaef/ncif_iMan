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
         form._ncifDHCPLocatorCtx.focus();
         onMVSelectChange("ncifUCOCtx", document.getElementById("_ncifUCOCtx"));
         onMVSelectChange("ncifLUMAdmGrp", document.getElementById("_ncifLUMAdmGrp"));
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


      <%-- ncifDHCPLocatorCtx --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifDHCPLocatorCtxDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDHCPLocatorCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDHCPLocatorCtx" value="<c:out value="${eDir$target$ncifDHCPLocatorCtx}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifDHCPLocatorCtx" id="spinner_ncifDHCPLocatorCtx" value="<x:out select="$edasXml/edas/ncifDHCPLocatorCtx/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifDHCPLocatorCtx.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifDHCPLocatorCtx.writeable}">
               <iman:os typeFilter="*" control="_ncifDHCPLocatorCtx" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDHCPLocatorCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifDHCPLocatorCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDHCPLocatorCtx = new UiObject();
         <c:if test="${edasRights.target.ncifDHCPLocatorCtx.writeable}">
            addToNotificationList('ncifDHCPLocatorCtx', 'uih_textfield');
            addActionHandler('ncifDHCPLocatorCtx', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifDHCPLocatorCtx.m_lowerBound = null;
         window.uiObject_ncifDHCPLocatorCtx.m_upperBound = null;
         window.uiObject_ncifDHCPLocatorCtx.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

		
      <%-- ncifDHCPGroupCtx --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDHCPGroupCtx.jspf"  %>  

		
      <%-- ncifDNSLocatorCtx --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifDNSLocatorCtxDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDNSLocatorCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDNSLocatorCtx" value="<c:out value="${eDir$target$ncifDNSLocatorCtx}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifDNSLocatorCtx" id="spinner_ncifDNSLocatorCtx" value="<x:out select="$edasXml/edas/ncifDNSLocatorCtx/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifDNSLocatorCtx.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifDNSLocatorCtx.writeable}">
               <iman:os typeFilter="*" control="_ncifDNSLocatorCtx" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDNSLocatorCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifDNSLocatorCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDNSLocatorCtx = new UiObject();
         <c:if test="${edasRights.target.ncifDNSLocatorCtx.writeable}">
            addToNotificationList('ncifDNSLocatorCtx', 'uih_textfield');
            addActionHandler('ncifDNSLocatorCtx', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifDNSLocatorCtx.m_lowerBound = null;
         window.uiObject_ncifDNSLocatorCtx.m_upperBound = null;
         window.uiObject_ncifDNSLocatorCtx.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifDNSGroupCtx --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifDNSGroupCtxDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDNSGroupCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDNSGroupCtx" value="<c:out value="${eDir$target$ncifDNSGroupCtx}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifDNSGroupCtx" id="spinner_ncifDNSGroupCtx" value="<x:out select="$edasXml/edas/ncifDNSGroupCtx/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifDNSGroupCtx.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifDNSGroupCtx.writeable}">
               <iman:os typeFilter="*" control="_ncifDNSGroupCtx" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDNSGroupCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifDNSGroupCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDNSGroupCtx = new UiObject();
         <c:if test="${edasRights.target.ncifDNSGroupCtx.writeable}">
            addToNotificationList('ncifDNSGroupCtx', 'uih_textfield');
            addActionHandler('ncifDNSGroupCtx', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifDNSGroupCtx.m_lowerBound = null;
         window.uiObject_ncifDNSGroupCtx.m_upperBound = null;
         window.uiObject_ncifDNSGroupCtx.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifDNSRootServerInfoCtx --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifDNSRootServerInfoCtxDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDNSRootServerInfoCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDNSRootServerInfoCtx" value="<c:out value="${eDir$target$ncifDNSRootServerInfoCtx}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifDNSRootServerInfoCtx" id="spinner_ncifDNSRootServerInfoCtx" value="<x:out select="$edasXml/edas/ncifDNSRootServerInfoCtx/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifDNSRootServerInfoCtx.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifDNSRootServerInfoCtx.writeable}">
               <iman:os typeFilter="*" control="_ncifDNSRootServerInfoCtx" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDNSRootServerInfoCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifDNSRootServerInfoCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDNSRootServerInfoCtx = new UiObject();
         <c:if test="${edasRights.target.ncifDNSRootServerInfoCtx.writeable}">
            addToNotificationList('ncifDNSRootServerInfoCtx', 'uih_textfield');
            addActionHandler('ncifDNSRootServerInfoCtx', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifDNSRootServerInfoCtx.m_lowerBound = null;
         window.uiObject_ncifDNSRootServerInfoCtx.m_upperBound = null;
         window.uiObject_ncifDNSRootServerInfoCtx.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifInstUser --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifInstUserDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifInstUser.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifInstUser" value="<c:out value="${eDir$target$ncifInstUser}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifInstUser" id="spinner_ncifInstUser" value="<x:out select="$edasXml/edas/ncifInstUser/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  <c:if test="${!edasRights.target.ncifInstUser.writeable}">DISABLED</c:if> >            <c:if test="${edasRights.target.ncifInstUser.writeable}">
               <iman:os typeFilter="*" control="_ncifInstUser" />
            </c:if>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifInstUser/@mode"/></c:set>
            <iman:mooMode name="_ncifInstUser_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifInstUser = new UiObject();
         <c:if test="${edasRights.target.ncifInstUser.writeable}">
            addToNotificationList('ncifInstUser', 'uih_textfield');
            addActionHandler('ncifInstUser', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifInstUser.m_lowerBound = null;
         window.uiObject_ncifInstUser.m_upperBound = null;
         window.uiObject_ncifInstUser.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifUCOCtx --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifUCOCtx.jspf"  %>  
		
		
      <%-- ncifLUMAdmGrp --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${ncifLUMAdmGrpDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifLUMAdmGrp.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifLUMAdmGrp" value="<c:out value="${eDir$target$ncifLUMAdmGrp}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifLUMAdmGrp = null; </SCRIPT>
            <SELECT name="_ncifLUMAdmGrp" id="_ncifLUMAdmGrp" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifLUMAdmGrp', this)">
               <OPTION value=""><iman:string key="Studio.selectAnItem"/>
            <c:set var="testValue" value="admingroup.adm.@CUSTOMER.LOWER@"/>
               <OPTION value="admingroup.adm.@CUSTOMER.LOWER@" <x:if select="count($edasXml/edas/ncifLUMAdmGrp/value[text()=$testValue])">selected</x:if>>admingroup.adm.@CUSTOMER.LOWER@
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifLUMAdmGrp/@mode"/></c:set>
            <iman:mooMode name="_ncifLUMAdmGrp_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifLUMAdmGrp = new UiObject();
         <c:if test="${edasRights.target.ncifLUMAdmGrp.writeable}">
            addToNotificationList('ncifLUMAdmGrp', 'uih_mvSelect');
            addActionHandler('ncifLUMAdmGrp', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
