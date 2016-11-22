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
   <iman:mvedScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         mvcheckbox_onclick("ncifDiskDevices", 0);
         mvcheckbox_onclick("ncifDiskDevices", 1);
         onMVSelectChange("ncifPartFile", document.getElementById("_ncifPartFile"));
         onMVSelectChange("ncifSoftFile", document.getElementById("_ncifSoftFile"));
         onMVSelectChange("ncifServerType", document.getElementById("_ncifServerType"));
         onMVSelectChange("ncifServiceType", document.getElementById("_ncifServiceType"));
         onMVSelectChange("ncifDeviceTemplate", document.getElementById("_ncifDeviceTemplate"));
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifDevice" >


   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncifDiskDevices --%>
      <TR>
         <TD align="left" colspan="2">
            Disk Device Checkbox (multi, Hash separates priority):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDiskDevices.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDiskDevices" value="<c:out value="${eDir$target$ncifDiskDevices}" escapeXml="false"/>">
            </c:if>
<SCRIPT language="javascript">
function checkAllncifDiskDevices(myFormName)
{
  for(var i=0;i<2; i++)
  {
     if(myFormName._ncifDiskDevicescheckAll.checked)
     {
       eval("myFormName._ncifDiskDevices" + i + ".checked='checked'");
     eval("mvcheckbox_onclick('ncifDiskDevices', i )");
     }
     else
     {
       eval("myFormName._ncifDiskDevices" + i + ".checked=null");
     }
  }
}
</SCRIPT>
            <c:set var="testValue" value="/dev/sda#1"/>
               <INPUT type="checkbox" name="_ncifDiskDevices0" onClick="mvcheckbox_onclick('ncifDiskDevices', 0);" value="/dev/sda#1" <x:if select="count($edasXml/edas/ncifDiskDevices/value[text()=$testValue])"> checked </x:if>>/dev/sda#1<br>
            <c:set var="testValue" value="/dev/sdb#2"/>
               <INPUT type="checkbox" name="_ncifDiskDevices1" onClick="mvcheckbox_onclick('ncifDiskDevices', 1);" value="/dev/sdb#2" <x:if select="count($edasXml/edas/ncifDiskDevices/value[text()=$testValue])"> checked </x:if>>/dev/sdb#2<br>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDiskDevices/@mode"/></c:set>
            <iman:mooMode name="_ncifDiskDevices_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDiskDevices = new UiObject();
         <c:if test="${edasRights.target.ncifDiskDevices.writeable}">
            addToNotificationList('ncifDiskDevices', 'uih_mvCheckbox2');
            addActionHandler('ncifDiskDevices', 'uiah_mvcheckbox');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncifPartFile --%>		
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifPartFile.jspf"  %>  

      <%-- ncifSoftFile --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifSoftFile.jspf"  %>  

      <%-- ncifServerType --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifServerType.jspf"  %>  

      <%-- ncifServiceType --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifServiceType.jspf"  %>  

      <%-- ncifRootPwd --%>
      <TR>
         <TD align="left" colspan="2">
            Root Password (encrypted):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifRootPwd.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifRootPwd" value="<c:out value="${eDir$target$ncifRootPwd}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifRootPwd" id="spinner_ncifRootPwd" value="<x:out select="$edasXml/edas/ncifRootPwd/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifRootPwd", "change")'<c:if test="${!edasRights.target.ncifRootPwd.writeable}">DISABLED</c:if> >
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

      <%-- ncifZCMAgentBinary --%>
      <TR>
         <TD align="left" colspan="2">
            ZCM Agent Binary (Filename without Path Component):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifZCMAgentBinary.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifZCMAgentBinary" value="<c:out value="${eDir$target$ncifZCMAgentBinary}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_ncifZCMAgentBinary" id="spinner_ncifZCMAgentBinary" value="<x:out select="$edasXml/edas/ncifZCMAgentBinary/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=64512 onchange='return validateLengthField(this, 0, 64512); postUiHandlerEvent("ncifZCMAgentBinary", "change")'<c:if test="${!edasRights.target.ncifZCMAgentBinary.writeable}">DISABLED</c:if> >
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

      <%-- ncifDeviceTemplate --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDeviceTemplate.jspf"  %>  

      <%-- ncifHWClock --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifHWClock.jspf"  %>  

      <%-- ncifZCMKeys --%>
 		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMKeys.jspf"  %>  

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
