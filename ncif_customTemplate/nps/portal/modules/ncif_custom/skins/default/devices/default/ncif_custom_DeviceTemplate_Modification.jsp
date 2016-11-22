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
   <iman:mvedScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         var form = document.forms[0];
         onMVSelectChange("ncifPartFile", document.getElementById("_ncifPartFile"));
         onMVSelectChange("ncifSoftFile", document.getElementById("_ncifSoftFile"));
         onMVSelectChange("ncifServerType", document.getElementById("_ncifServerType"));
         onMVSelectChange("ncifServiceType", document.getElementById("_ncifServiceType"));
         mvcheckbox_onclick("ncifDiskDevices", 0);
         mvcheckbox_onclick("ncifDiskDevices", 1);
//         mvcheckbox_onclick("ncifDHCPInterfaces", 0);
//         mvcheckbox_onclick("ncifDHCPInterfaces", 1);
//         mvcheckbox_onclick("ncifDHCPInterfaces", 2);
//         mvcheckbox_onclick("ncifDHCPInterfaces", 3);
//         mvcheckbox_onclick("ncifDHCPInterfaces", 4);
         onMVSelectChange("ncifHWClock", document.getElementById("_ncifHWClock"));
         onMVSelectChange("ncifLanguage", document.getElementById("_ncifLanguage"));
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifDeviceTemplate" >


   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncifPartFile --%>		
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifPartFile.jspf"  %>  

<%--		
      <TR>
         <TD align="left" colspan="2">
            Partitioning XML File:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifPartFile.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifPartFile" value="<c:out value="${eDir$target$ncifPartFile}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifPartFile = null; </SCRIPT>
            <SELECT name="_ncifPartFile" id="_ncifPartFile" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifPartFile', this)">
            <c:set var="testValue" value="part-VM-100G-lvm.xml"/>
               <OPTION value="part-VM-100G-lvm.xml" <x:if select="count($edasXml/edas/ncifPartFile/value[text()=$testValue])">selected</x:if>>part-VM-100G-lvm.xml
            <c:set var="testValue" value="part-VM-130G-lvm.xml"/>
               <OPTION value="part-VM-130G-lvm.xml" <x:if select="count($edasXml/edas/ncifPartFile/value[text()=$testValue])">selected</x:if>>part-VM-130G-lvm.xml
            <c:set var="testValue" value="part-VM-ZCM-lvm.xml"/>
               <OPTION value="part-VM-ZCM-lvm.xml" <x:if select="count($edasXml/edas/ncifPartFile/value[text()=$testValue])">selected</x:if>>part-VM-ZCM-lvm.xml
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifPartFile/@mode"/></c:set>
            <iman:mooMode name="_ncifPartFile_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifPartFile = new UiObject();
         <c:if test="${edasRights.target.ncifPartFile.writeable}">
            addToNotificationList('ncifPartFile', 'uih_mvSelect');
            addActionHandler('ncifPartFile', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>
--%>

      <%-- ncifSoftFile --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifSoftFile.jspf"  %>  

   <%--  
      <TR>
         <TD align="left" colspan="2">
            Software XML File:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifSoftFile.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifSoftFile" value="<c:out value="${eDir$target$ncifSoftFile}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifSoftFile = null; </SCRIPT>
            <SELECT name="_ncifSoftFile" id="_ncifSoftFile" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifSoftFile', this)">
            <c:set var="testValue" value="soft-oes11sp2_NISS.xml"/>
               <OPTION value="soft-oes11sp2_NISS.xml" <x:if select="count($edasXml/edas/ncifSoftFile/value[text()=$testValue])">selected</x:if>>soft-oes11sp2_NISS.xml
            <c:set var="testValue" value="soft-oes11sp2_eDir.xml"/>
               <OPTION value="soft-oes11sp2_eDir.xml" <x:if select="count($edasXml/edas/ncifSoftFile/value[text()=$testValue])">selected</x:if>>soft-oes11sp2_eDir.xml
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifSoftFile/@mode"/></c:set>
            <iman:mooMode name="_ncifSoftFile_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifSoftFile = new UiObject();
         <c:if test="${edasRights.target.ncifSoftFile.writeable}">
            addToNotificationList('ncifSoftFile', 'uih_mvSelect');
            addActionHandler('ncifSoftFile', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>
--%>

	<%-- ncifServerType --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifServerType.jspf"  %>  
   <%-- 
      <TR>
         <TD align="left" colspan="2">
            Server Type:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifServerType.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifServerType" value="<c:out value="${eDir$target$ncifServerType}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncifServerType = null; </SCRIPT>
            <SELECT name="_ncifServerType" id="_ncifServerType" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncifServerType', this)">
            <c:set var="testValue" value="sles11sp3-TST"/>
               <OPTION value="sles11sp3-TST" <x:if select="count($edasXml/edas/ncifServerType/value[text()=$testValue])">selected</x:if>>sles11sp3-TST
            <c:set var="testValue" value="oes11sp2-TST"/>
               <OPTION value="oes11sp2-TST" <x:if select="count($edasXml/edas/ncifServerType/value[text()=$testValue])">selected</x:if>>oes11sp2-TST
            <c:set var="testValue" value="oes11sp2-TST-CD"/>
               <OPTION value="oes11sp2-TST-CD" <x:if select="count($edasXml/edas/ncifServerType/value[text()=$testValue])">selected</x:if>>oes11sp2-TST-CD
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifServerType/@mode"/></c:set>
            <iman:mooMode name="_ncifServerType_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifServerType = new UiObject();
         <c:if test="${edasRights.target.ncifServerType.writeable}">
            addToNotificationList('ncifServerType', 'uih_mvSelect');
            addActionHandler('ncifServerType', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>
--%>

	<%-- ncifServiceType --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifServiceType.jspf"  %>  

      <%-- ncifDiskDevices --%>
      <TR>
         <TD align="left" colspan="2">
            Disk Devices (multiple selection possible):&nbsp;&nbsp;
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

      <%-- ncifDHCPInterfaces --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifDHCPInterfaces.jspf"  %>  

		<%-- ncifHWClock --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifHWClock.jspf"  %>  

      <%-- ncifKeyBoard --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifKeyBoard.jspf"  %>  

      <%-- ncifLanguage --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifLanguage.jspf"  %>  

      <%-- ncifZCMKeys --%>
		<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifZCMKeys.jspf"  %>  

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
