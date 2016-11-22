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

<%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>

<iman:stringtable bundle="FwResources" />
<iman:stringtable bundle="DevResources" />
<x:parse xml="${edas}" var="edasXml"/>

<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <iman:stylesheet/>
   <iman:uihandlerTools/>
   <iman:pageScripts/>

   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         onMVSelectChange("ncifGlobalConfigurationCtx", document.getElementById("_ncifGlobalConfigurationCtx"));
         onMVSelectChange("ncifTimeZone", document.getElementById("_ncifTimeZone"));
         onMVSelectChange("ncifLanguage", document.getElementById("_ncifLanguage"));
         onMVSelectChange("ncifHWClock", document.getElementById("_ncifHWClock"));
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


      <%-- ncifGlobalConfigurationCtx --%>
      <TR>
         <TD align="left" colspan="2">
            Global Configuration Container (static):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifGlobalConfigurationCtx.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifGlobalConfigurationCtx" value="<c:out value="${eDir$target$ncifGlobalConfigurationCtx}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifGlobalConfigurationCtx = null; </SCRIPT>
            <SELECT name="_ncifGlobalConfigurationCtx" id="_ncifGlobalConfigurationCtx" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifGlobalConfigurationCtx', this)">
               <OPTION value=""><iman:string key="Studio.selectAnItem"/>
            <c:set var="testValue" value="ncif-configuration.global.@CUSTOMER.LOWER@"/>
               <OPTION value="ncif-configuration.global.@CUSTOMER.LOWER@" <x:if select="count($edasXml/edas/ncifGlobalConfigurationCtx/value[text()=$testValue])">selected</x:if>>ncif-configuration.global.@CUSTOMER.LOWER@
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifGlobalConfigurationCtx/@mode"/></c:set>
            <iman:mooMode name="_ncifGlobalConfigurationCtx_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifGlobalConfigurationCtx = new UiObject();
         <c:if test="${edasRights.target.ncifGlobalConfigurationCtx.writeable}">
            addToNotificationList('ncifGlobalConfigurationCtx', 'uih_mvSelect');
            addActionHandler('ncifGlobalConfigurationCtx', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifTimeZone --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifTimeZone.jspf"  %>  

      <%-- ncifLanguage --%>
 		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifLanguage.jspf"  %>  

      <%-- ncifHWClock --%>
      <TR>
         <TD align="left" colspan="2">
            HWClock (UTC or localtime):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifHWClock.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifHWClock" value="<c:out value="${eDir$target$ncifHWClock}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifHWClock = null; </SCRIPT>
            <SELECT name="_ncifHWClock" id="_ncifHWClock" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifHWClock', this)">
               <OPTION value=""><iman:string key="Studio.selectAnItem"/>
            <c:set var="testValue" value="UTC"/>
               <OPTION value="UTC" <x:if select="count($edasXml/edas/ncifHWClock/value[text()=$testValue])">selected</x:if>>UTC
            <c:set var="testValue" value="localtime"/>
               <OPTION value="localtime" <x:if select="count($edasXml/edas/ncifHWClock/value[text()=$testValue])">selected</x:if>>localtime
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifHWClock/@mode"/></c:set>
            <iman:mooMode name="_ncifHWClock_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifHWClock = new UiObject();
         <c:if test="${edasRights.target.ncifHWClock.writeable}">
            addToNotificationList('ncifHWClock', 'uih_mvSelect');
            addActionHandler('ncifHWClock', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifKeyBoard --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifKeyBoard.jspf"  %>  

      <%-- ncifRootPwd --%>
      <TR>
         <TD align="left" colspan="2">
            Root Password encrypted (i.e. '$2y$05$vlM6FAdPP...'):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifRootPwd.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifRootPwd" value="<c:out value="${eDir$target$ncifRootPwd}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifRootPwd" id="spinner_ncifRootPwd" value="<x:out select="$edasXml/edas/ncifRootPwd/value"/>" size=50  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifRootPwd", "change")'<c:if test="${!edasRights.target.ncifRootPwd.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifRootPwd/@mode"/></c:set>
            <iman:mooMode name="_ncifRootPwd_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifRootPwd = new UiObject();
         <c:if test="${edasRights.target.ncifRootPwd.writeable}">
            addToNotificationList('ncifRootPwd', 'uih_textfield');
            addActionHandler('ncifRootPwd', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifRootPwd.m_lowerBound = 0;
         window.uiObject_ncifRootPwd.m_upperBound = 64512;
         window.uiObject_ncifRootPwd.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
