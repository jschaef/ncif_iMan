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
   <iman:mvedScripts/>
   <iman:validateNumberScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
      function onInit()
      {
         var form = document.forms[0];
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifConfiguration" >


   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">

      <%-- ncifDefaultGateway 
		<TR>
         <TD align="left" colspan="2">
            Gateway(s) (CIDR notation e.g. 10.86.62.10/24):&nbsp;&nbsp;
         </TD>
      </TR>
      <TR>
         <TD>
            <c:if test="${edasRights.target.ncifDefaultGateway.writeable}">
               <INPUT type="hidden" name="eDir$target$ncifDefaultGateway" value="<c:out value="${eDir$target$ncifDefaultGateway}" escapeXml="false"/>">
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/ncifDefaultGateway" scope="request"/>
            <iman:mved readonly="${!edasRights.target.ncifDefaultGateway.writeable}" enforceUnique="true" ignoreCase="true" name="_ncifDefaultGateway"            />
         </TD>
         <TD valign="top">
            <c:set var="mode"><x:out select="$edasXml/edas/ncifDefaultGateway/@mode"/></c:set>
            <iman:mooMode name="_ncifDefaultGateway_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <SCRIPT>
         window.uiObject_ncifDefaultGateway = new UiObject();
         <c:if test="${edasRights.target.ncifDefaultGateway.writeable}">
            addToNotificationList('ncifDefaultGateway', 'uih_mvStringEditor');
         </c:if>
      </SCRIPT>
      <TR><TD height="9"></TD></TR>
	--%>

      <TR>
         <TD align="left" colspan="2">
				<p/>
            <h2>Press OK to extend the container object with the auxiliary class ncifConfiguration</h2>
         </TD>
      </TR>
      <TR>
         <TD>
         </TD>
         <TD valign="top">
         </TD>
      </TR>
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
