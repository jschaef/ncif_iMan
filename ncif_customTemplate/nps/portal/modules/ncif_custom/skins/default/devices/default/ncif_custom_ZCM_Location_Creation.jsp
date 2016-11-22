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

   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         var form = document.forms[0];
         onMVSelectChange("ncifZCMLanguageUIDKey", document.getElementById("_ncifZCMLanguageUIDKey"));
         onMVSelectChange("ncifZCMOSUIDKey", document.getElementById("_ncifZCMOSUIDKey"));
         onMVSelectChange("ncifZCMMSOfficeUIDKey", document.getElementById("_ncifZCMMSOfficeUIDKey"));
      }

      function onExit(action)
      {
         var form=document.forms[0];

         var success = notifyAllOfExit();
         if(!success)
         {
            return false;
         }

      }
   </SCRIPT>
</HEAD>

<body onLoad="onInit();">
<FORM name="form" method="post" action="webacc" onSubmit="onExit();">

   <%-- - edas and system variables  - --%>
   <INPUT type="hidden" name="taskId" value="<c:out value="${taskId}"/>">
   <INPUT type="hidden" name="eDirCommand" value="Write">
   <INPUT type="hidden" name="eDir$target" value="<c:out value="${param.eDir$target}"/>">
   <INPUT type="hidden" name="merge" value="dev.GenConf">
   <INPUT type="hidden" name="error" value="dev.GenErr">
   <INPUT type="hidden" name="jspFile" value="<c:out value="${jspFile}"/>">





   <!-- Automatic Aux Class Extension -->
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifZCMConfiguration" >


   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncifZCMLanguageUIDKey --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMLanguageUIDKey.jspf"  %>  

      <%-- ncifZCMOSUIDKey --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMOSUIDKey.jspf"  %>  

      <%-- ncifZCMMSOfficeUIDKey --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMMSOfficeUIDKey.jspf"  %>  

      <%-- ncifZCMRsyncBandwidthLimit --%>
      <TR>
         <TD align="left" colspan="2">
            Rsync Bandwidth for Image Distribution (kB/sec).<br>If empty the whole bandwidth will be used.:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifZCMRsyncBandwidthLimit.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifZCMRsyncBandwidthLimit" value="<c:out value="${eDir$target$ncifZCMRsyncBandwidthLimit}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifZCMRsyncBandwidthLimit" id="spinner_ncifZCMRsyncBandwidthLimit" value="<x:out select="$edasXml/edas/ncifZCMRsyncBandwidthLimit/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifZCMRsyncBandwidthLimit", "change")'<c:if test="${!edasRights.target.ncifZCMRsyncBandwidthLimit.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifZCMRsyncBandwidthLimit/@mode"/></c:set>
            <iman:mooMode name="_ncifZCMRsyncBandwidthLimit_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifZCMRsyncBandwidthLimit = new UiObject();
         <c:if test="${edasRights.target.ncifZCMRsyncBandwidthLimit.writeable}">
            addToNotificationList('ncifZCMRsyncBandwidthLimit', 'uih_textfield');
            addActionHandler('ncifZCMRsyncBandwidthLimit', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_ncifZCMRsyncBandwidthLimit.m_lowerBound = 0;
         window.uiObject_ncifZCMRsyncBandwidthLimit.m_upperBound = 64512;
         window.uiObject_ncifZCMRsyncBandwidthLimit.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>


   <BR>
   <iman:bar/>
   <iman:button key="OK" onClick="document.forms[0].eDirCommand.value='Write'; if(onExit() != false) document.forms[0].submit();"/>
   <c:if test="${taskIsMoo!='true'}">
      <iman:button key="Apply" onClick="document.forms[0].eDirCommand.value='Apply'; if(onExit() != false) document.forms[0].submit();"/>
   </c:if>
   <iman:cancelBtn/>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
