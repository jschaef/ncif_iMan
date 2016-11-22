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
   <iman:osScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         onMVSelectChange("ncifLanguage", document.getElementById("_ncifLanguage"));
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifDevice" >


   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncifIPAddresses --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifIPAddresses.jspf"  %>

      <%-- ncifServerCtx --%>
      <TR>
         <TD align="left" colspan="2">
            eDirectory Server Context (Servers with eDirectory only):&nbsp;&nbsp;
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

		<%-- ncifMACAddresses --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifMACAddresses.jspf"  %>

      <%-- ncifKeyBoard --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifKeyBoard.jspf"  %>  


      <%-- ncifLanguage --%>
  		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifLanguage.jspf"  %>  

      <%-- ncifServerStatus --%>
      <TR>
         <TD align="left" colspan="2">
            Server Status (autofilled by installation process):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifServerStatus.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifServerStatus" value="<c:out value="${eDir$target$ncifServerStatus}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifServerStatus" id="spinner_ncifServerStatus" value="<x:out select="$edasXml/edas/ncifServerStatus/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifServerStatus", "change")'<c:if test="${!edasRights.target.ncifServerStatus.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifServerStatus/@mode"/></c:set>
            <iman:mooMode name="_ncifServerStatus_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifServerStatus = new UiObject();
         <c:if test="${edasRights.target.ncifServerStatus.writeable}">
            addToNotificationList('ncifServerStatus', 'uih_textfield');
            addActionHandler('ncifServerStatus', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifServerStatus.m_lowerBound = 0;
         window.uiObject_ncifServerStatus.m_upperBound = 64512;
         window.uiObject_ncifServerStatus.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
