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
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         onMVSelectChange("ncif_custom_ServerType", document.getElementById("_ncif_custom_ServerType"));
         onMVSelectChange("ncif_custom_SLESVersion", document.getElementById("_ncif_custom_SLESVersion"));
      }

      <%-- ---------------------------------------------------------------- --%>
      <%--    What should this method do?                                   --%>
      <%--    -data validation                                              --%>
      <%--    -general page cleanup before being submitted                  --%>
      <%--    -if this method returns false, the page will not be saved     --%>
      <%--    Called when user leaves this page or applys changes           --%>
      <%-- ---------------------------------------------------------------- --%>
      function isPageValid(action)
      {
         var form=document.forms[0];

         var success = notifyAllOfExit();
         if(!success)
         {
            return false;
         }

         if(form.eDir$target$ncif_custom_SLESVersion.value.indexOf('<value')<0)
         {
            alert(formatMessage("<iman:string key="General.provideMandatoryAttribute"/>", ["@CUSTOMER.CAMEL@ SLES Versions (list)"]));
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="@CUSTOMER.ATTR.PREFIX.NCIF@Device" >


   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- ncif_custom_ServerType --%>
      <TR>
         <TD align="left" colspan="2">
            @CUSTOMER.CAMEL@ Linux Server Type:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncif_custom_ServerType.writeable}">
               <INPUT type="hidden" name="eDir$target$ncif_custom_ServerType" value="<c:out value="${eDir$target$ncif_custom_ServerType}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncif_custom_ServerType = null; </SCRIPT>
            <SELECT name="_ncif_custom_ServerType" id="_ncif_custom_ServerType" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncif_custom_ServerType', this)">
            <c:set var="testValue" value="GW PC"/>
               <OPTION value="GW PC" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>GW PC
            <c:set var="testValue" value="Preadvice Server"/>
               <OPTION value="Preadvice Server" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>Preadvice Server
            <c:set var="testValue" value="Uni Station"/>
               <OPTION value="Uni Station" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>Uni Station
            <c:set var="testValue" value="Uni Sort"/>
               <OPTION value="Uni Sort" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>Uni Sort
            <c:set var="testValue" value="NISS"/>
               <OPTION value="NISS" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>NISS
            <c:set var="testValue" value="External Box"/>
               <OPTION value="External Box" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>External Box
            <c:set var="testValue" value="Base Linux"/>
               <OPTION value="Base Linux" <x:if select="count($edasXml/edas/ncif_custom_ServerType/value[text()=$testValue])">selected</x:if>>Base Linux
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncif_custom_ServerType/@mode"/></c:set>
            <iman:mooMode name="_ncif_custom_ServerType_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncif_custom_ServerType = new UiObject();
         <c:if test="${edasRights.target.ncif_custom_ServerType.writeable}">
            addToNotificationList('ncif_custom_ServerType', 'uih_mvSelect');
            addActionHandler('ncif_custom_ServerType', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncif_custom_SLESVersion --%>
      <TR>
         <TD align="left" colspan="2">
            @CUSTOMER.CAMEL@ SLES Versions (list):<font color="red">*</font>&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncif_custom_SLESVersion.writeable}">
               <INPUT type="hidden" name="eDir$target$ncif_custom_SLESVersion" value="<c:out value="${eDir$target$ncif_custom_SLESVersion}" escapeXml="false"/>">
            </c:if>
            <SCRIPT>window.lastSelectedItem_ncif_custom_SLESVersion = null; </SCRIPT>
            <SELECT name="_ncif_custom_SLESVersion" id="_ncif_custom_SLESVersion" style="width:<iman:string key="UI.textboxPixel"/>" onchange="onMVSelectChange('ncif_custom_SLESVersion', this)">
            <c:set var="testValue" value="sles8-i386"/>
               <OPTION value="sles8-i386" <x:if select="count($edasXml/edas/ncif_custom_SLESVersion/value[text()=$testValue])">selected</x:if>>sles8-i386
            <c:set var="testValue" value="sles10sp4-32"/>
               <OPTION value="sles10sp4-32" <x:if select="count($edasXml/edas/ncif_custom_SLESVersion/value[text()=$testValue])">selected</x:if>>sles10sp4-32
            <c:set var="testValue" value="sles11sp3-64"/>
               <OPTION value="sles11sp3-64" <x:if select="count($edasXml/edas/ncif_custom_SLESVersion/value[text()=$testValue])">selected</x:if>>sles11sp3-64
            </SELECT>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncif_custom_SLESVersion/@mode"/></c:set>
            <iman:mooMode name="_ncif_custom_SLESVersion_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncif_custom_SLESVersion = new UiObject();
         <c:if test="${edasRights.target.ncif_custom_SLESVersion.writeable}">
            addToNotificationList('ncif_custom_SLESVersion', 'uih_mvSelect');
            addActionHandler('ncif_custom_SLESVersion', 'uiah_mvSelect');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- ncif_custom_TestPC --%>
      <TR>
         <TD align="left" colspan="2">
            Test PC&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncif_custom_TestPC.writeable}">
               <INPUT type="hidden" name="eDir$target$ncif_custom_TestPC" value="<c:out value="${eDir$target$ncif_custom_TestPC}" escapeXml="false"/>">
            </c:if>
            <INPUT name="_ncif_custom_TestPC" type="checkbox" <c:if test="${!edasRights.target.ncif_custom_TestPC.writeable}">DISABLED</c:if> <x:if select="$edasXml/edas/ncif_custom_TestPC/value='true'">checked</x:if>>
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncif_custom_TestPC/@mode"/></c:set>
            <iman:mooMode name="_ncif_custom_TestPC_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncif_custom_TestPC = new UiObject();
         <c:if test="${edasRights.target.ncif_custom_TestPC.writeable}">
            addToNotificationList('ncif_custom_TestPC', 'uih_checkbox');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

   </TABLE>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>
