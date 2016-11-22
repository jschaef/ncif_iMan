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
        <%-- - form._@CUSTOMER.ATTR.PREFIX.ATTR@Country.focus(); - --%>
         onMVSelectChange("@CUSTOMER.ATTR.PREFIX.ATTR@InternetAccess", document.getElementById("_@CUSTOMER.ATTR.PREFIX.ATTR@InternetAccess"));
         onMVSelectChange("@CUSTOMER.ATTR.PREFIX.ATTR@Location", document.getElementById("_@CUSTOMER.ATTR.PREFIX.ATTR@Location"));
         onMVSelectChange("@CUSTOMER.ATTR.PREFIX.ATTR@Country", document.getElementById("_@CUSTOMER.ATTR.PREFIX.ATTR@Country"));
         onMVSelectChange("@CUSTOMER.ATTR.PREFIX.ATTR@Company", document.getElementById("_@CUSTOMER.ATTR.PREFIX.ATTR@Company"));
         onMVSelectChange("dialupAccess", document.getElementById("_dialupAccess"));
         returnFromOS();
      }

      function onExit()
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
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="@CUSTOMER.ATTR.PREFIX.CLASS@User,radiusprofile" >


   <iman:taskHeader title="${requestScope['Task.displayName']}:  ${requestScope['Task.targetDisplayName']}" iconUrl="dir/${requestScope['TaskHeader.iconUrl']}" iconAlt="${requestScope['TaskHeader.iconAlt']}"/><BR>

   <iman:messagebar/>


   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- @CUSTOMER.ATTR.PREFIX.ATTR@Country --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncif_custom_Country.jspf"  %> 
      <%-- @CUSTOMER.ATTR.PREFIX.ATTR@Company --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncif_custom_Company.jspf"  %> 
      <%-- @CUSTOMER.ATTR.PREFIX.ATTR@Location --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncif_custom_Location.jspf"  %> 
      <%-- @CUSTOMER.ATTR.PREFIX.ATTR@InternetAccess --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncif_custom_InternetAccess.jspf"  %> 
      <%-- dialupAccess --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncif_custom_dialupAccess.jspf"  %> 

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
