<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils"%>
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

   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
   <iman:mvedScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         var form = document.forms[0];
         form._Description.focus();
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




   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- Description --%>
      <TR>
         <TD align="left" colspan="2">
            <c:out value="${DescriptionDisplayName}"/>:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.Description.writeable}">
               <INPUT type="hidden" name="eDir$target$Description" value="<c:out value="${eDir$target$Description}" escapeXml="false"/>">
            </c:if>
            <INPUT type="text" name="_Description" id="spinner_Description" value="<x:out select="$edasXml/edas/Description/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=1024 onchange='return validateLengthField(this, 1, 1024); postUiHandlerEvent("Description", "change")'<c:if test="${!edasRights.target.Description.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/Description/@mode"/></c:set>
            <iman:mooMode name="_Description_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_Description = new UiObject();
         <c:if test="${edasRights.target.Description.writeable}">
            addToNotificationList('Description', 'uih_textfield');
            addActionHandler('Description', 'uiah_textfield');
         </c:if>
      </SCRIPT>
      <SCRIPT>
         window.uiObject_Description.m_lowerBound = 1;
         window.uiObject_Description.m_upperBound = 1024;
         window.uiObject_Description.m_type = "string";
      </SCRIPT>
      <TR><TD height="9"></TD></TR>

      <%-- L --%>
      <TR>
         <TD align="left" colspan="2">
            List Values:&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.L.writeable}">
               <INPUT type="hidden" name="eDir$target$L" value="<c:out value="${eDir$target$L}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/L" scope="request"/>
            <iman:mved maxLength="128" readonly="${!edasRights.target.L.writeable}" enforceUnique="true" ignoreCase="true" minLength="1" name="_L"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/L/@mode"/></c:set>
            <iman:mooMode name="_L_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_L = new UiObject();
         <c:if test="${edasRights.target.L.writeable}">
            addToNotificationList('L', 'uih_mvStringEditor');
         </c:if>
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
