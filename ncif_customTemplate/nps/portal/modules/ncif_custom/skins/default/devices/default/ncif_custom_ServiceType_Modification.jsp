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
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         var form = document.forms[0];
/*
         mvcheckbox_onclick("ncifXMLSnippets", 0);
         mvcheckbox_onclick("ncifXMLSnippets", 1);
         mvcheckbox_onclick("ncifXMLSnippets", 2);
         mvcheckbox_onclick("ncifXMLSnippets", 3);
         mvcheckbox_onclick("ncifXMLSnippets", 4);
         mvcheckbox_onclick("ncifXMLSnippets", 5);
         mvcheckbox_onclick("ncifXMLSnippets", 6);
         mvcheckbox_onclick("ncifXMLSnippets", 7);
         mvcheckbox_onclick("ncifXMLSnippets", 8);
         mvcheckbox_onclick("ncifXMLSnippets", 9);
         mvcheckbox_onclick("ncifXMLSnippets", 10);
         mvcheckbox_onclick("ncifXMLSnippets", 11);
         mvcheckbox_onclick("ncifXMLSnippets", 12);
*/
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifServiceType" >


   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


   <%-- ncifXMLSnippets --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifXMLSnippets.jspf"  %> 
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
