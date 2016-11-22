<%--

Task to redirect current user with delegation feature for self-service


Use xml declaration like ...

<task>
    <id>task_SelfService</id>
    <version>2.0.0</version>
    <required-version>2.0.0</required-version>
    <class-name>com.novell.emframe.dev.EmptyTask</class-name>
    <merge-template>ncsEMEA.task_ncsSelfServicePwd</merge-template> 
    <display-name-key>task_ncsSelfService</display-name-key>
    <description-key>task_ncsSelfService</description-key>
    <resource-properties-file>com.novell.xxx.Resources</resource-properties-file>
    <role-assignment>role_xxx</role-assignment>
    <url-param>
        <param-key>sharedTaskDefault</param-key>
        <param-value>ncsDemo_shared_ModifyUser</param-value>
    </url-param>
</task>

--%>

<%@ page import="com.novell.ncsEMEA.util.*, com.novell.nps.gadgetManager.BaseGadgetInstance"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<%@ taglib uri="/WEB-INF/iman.tld"  prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld"     prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld"   prefix="fmt" %>

<%   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<HTML>

<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>

<BODY>

<%
  String sTask          = NcsUtil.getRequestAttribute( request, "sharedTaskDefault",   "" ); 
  String sPage          = NcsUtil.getRequestAttribute( request, "sharedPageId",        "" ); 
  String sRedirectUrl   = NcsUtil.makeDelegationUrl ( ncsCommon.getTaskContext(), ncsCommon.getUser().getDn(), sTask, sPage, false, false );
  String sRedirectJS    = "<script type='text/javascript'>document.location.href ='" + sRedirectUrl + "';</script>";
  if ( NcsUtil.stringEmpty( sTask ) ) sRedirectJS = "Target Task undefined";
%>

<%= sRedirectJS %>

<%-- the manual link is for seldom cases where the JS auto-redirect doesn't work --%>

   <table cellspacing='10' width='100%'>
      <tr>
         <td></td>
         <td align=left> <a href='<%= sRedirectUrl %>'>Click here</a> </td>
      </tr>
   </table>

</body>
</HTML>
