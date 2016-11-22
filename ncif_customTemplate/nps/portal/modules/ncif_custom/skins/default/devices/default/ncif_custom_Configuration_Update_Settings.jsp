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
         onMVSelectChange("ncifUpdateSystem", document.getElementById("_ncifUpdateSystem"));
 //      onMVSelectChange("ncifZCMServers", document.getElementById("_ncifZCMServers"));
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


      <%-- ncifUpdateSystem --%>
      <TR>
         <TD align="left" colspan="2">
            Update System Selection:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifUpdateSystem.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifUpdateSystem" value="<c:out value="${eDir$target$ncifUpdateSystem}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifUpdateSystem = null; </SCRIPT>
            <SELECT name="_ncifUpdateSystem" id="_ncifUpdateSystem" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifUpdateSystem', this)">
               <OPTION value=""><iman:string key="Studio.selectAnItem"/>
            <c:set var="testValue" value="zcm"/>
               <OPTION value="zcm" <x:if select="count($edasXml/edas/ncifUpdateSystem/value[text()=$testValue])">selected</x:if>>zcm
            <c:set var="testValue" value="smt"/>
               <OPTION value="smt" <x:if select="count($edasXml/edas/ncifUpdateSystem/value[text()=$testValue])">selected</x:if>>smt
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifUpdateSystem/@mode"/></c:set>
            <iman:mooMode name="_ncifUpdateSystem_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifUpdateSystem = new UiObject();
         <c:if test="${edasRights.target.ncifUpdateSystem.writeable}">
            addToNotificationList('ncifUpdateSystem', 'uih_mvSelect');
            addActionHandler('ncifUpdateSystem', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifZCMServers --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMServers.jspf"  %>  

      <%-- ncifZCMAgentURL --%>
      <TR>
         <TD align="left" colspan="2">
            ZCM Agent URL (i.e. $AY_SERVER/zcm/$ZCM_AGENT_BIN):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifZCMAgentURL.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifZCMAgentURL" value="<c:out value="${eDir$target$ncifZCMAgentURL}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifZCMAgentURL" id="spinner_ncifZCMAgentURL" value="<x:out select="$edasXml/edas/ncifZCMAgentURL/value"/>" size=60  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifZCMAgentURL", "change")'<c:if test="${!edasRights.target.ncifZCMAgentURL.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifZCMAgentURL/@mode"/></c:set>
            <iman:mooMode name="_ncifZCMAgentURL_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifZCMAgentURL = new UiObject();
         <c:if test="${edasRights.target.ncifZCMAgentURL.writeable}">
            addToNotificationList('ncifZCMAgentURL', 'uih_textfield');
            addActionHandler('ncifZCMAgentURL', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifZCMAgentURL.m_lowerBound = 0;
         window.uiObject_ncifZCMAgentURL.m_upperBound = 64512;
         window.uiObject_ncifZCMAgentURL.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifZCMAgentBinary --%>
      <TR>
         <TD align="left" colspan="2">
            Binary Name of ZCM Agent (i.e. PreAgentPkg_AgentLinuxComplete.bin):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifZCMAgentBinary.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifZCMAgentBinary" value="<c:out value="${eDir$target$ncifZCMAgentBinary}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifZCMAgentBinary" id="spinner_ncifZCMAgentBinary" value="<x:out select="$edasXml/edas/ncifZCMAgentBinary/value"/>" size=60  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifZCMAgentBinary", "change")'<c:if test="${!edasRights.target.ncifZCMAgentBinary.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifZCMAgentBinary/@mode"/></c:set>
            <iman:mooMode name="_ncifZCMAgentBinary_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifZCMAgentBinary = new UiObject();
         <c:if test="${edasRights.target.ncifZCMAgentBinary.writeable}">
            addToNotificationList('ncifZCMAgentBinary', 'uih_textfield');
            addActionHandler('ncifZCMAgentBinary', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifZCMAgentBinary.m_lowerBound = 0;
         window.uiObject_ncifZCMAgentBinary.m_upperBound = 64512;
         window.uiObject_ncifZCMAgentBinary.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifSMTServer --%>
      <TR>
         <TD align="left" colspan="2">
            SMT Server Protocol + Name|IP Address  (i.e. https://192.168.178.12):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifSMTServer.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifSMTServer" value="<c:out value="${eDir$target$ncifSMTServer}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifSMTServer" id="spinner_ncifSMTServer" value="<x:out select="$edasXml/edas/ncifSMTServer/value"/>" size=60  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifSMTServer", "change")'<c:if test="${!edasRights.target.ncifSMTServer.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifSMTServer/@mode"/></c:set>
            <iman:mooMode name="_ncifSMTServer_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifSMTServer = new UiObject();
         <c:if test="${edasRights.target.ncifSMTServer.writeable}">
            addToNotificationList('ncifSMTServer', 'uih_textfield');
            addActionHandler('ncifSMTServer', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifSMTServer.m_regExpression = "^(http|https):/+.*$";
         window.uiObject_ncifSMTServer.m_regExpressionErrorMsg = "The protocol of SMT Server should be either http|https";
         window.uiObject_ncifSMTServer.m_lowerBound = 0;
         window.uiObject_ncifSMTServer.m_upperBound = 64512;
         window.uiObject_ncifSMTServer.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifSMTClientURL --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifSMTClientURL.jspf"  %>  
 
      <%-- ncifIsoServer --%>
      <TR>
         <TD align="left" colspan="2">
            ISO Server Protocol + Name|IP Address  (i.e. https://192.168.178.12):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifIsoServer.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifIsoServer" value="<c:out value="${eDir$target$ncifIsoServer}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifIsoServer" id="spinner_ncifIsoServer" value="<x:out select="$edasXml/edas/ncifIsoServer/value"/>" size=60  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifIsoServer", "change")'<c:if test="${!edasRights.target.ncifIsoServer.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifIsoServer/@mode"/></c:set>
            <iman:mooMode name="_ncifIsoServer_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifIsoServer = new UiObject();
         <c:if test="${edasRights.target.ncifIsoServer.writeable}">
            addToNotificationList('ncifIsoServer', 'uih_textfield');
            addActionHandler('ncifIsoServer', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifIsoServer.m_regExpression = "^(http|https):/+.*$";
         window.uiObject_ncifIsoServer.m_regExpressionErrorMsg = "The protocol of ISO Server should be either http|https";
         window.uiObject_ncifIsoServer.m_lowerBound = 0;
         window.uiObject_ncifIsoServer.m_upperBound = 64512;
         window.uiObject_ncifIsoServer.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
