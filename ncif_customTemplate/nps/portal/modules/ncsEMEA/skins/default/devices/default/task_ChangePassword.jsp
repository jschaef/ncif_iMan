<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.ncsEMEA.util.*, com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils" %>

<%
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("com.novell.ncsEMEA.resources");
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<%@ taglib uri="/WEB-INF/iman.tld"  prefix="iman" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %> 
<%@ taglib uri="/WEB-INF/x.tld"     prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld"   prefix="fmt" %>
<iman:stringtable bundle="com.novell.ncsEMEA.resources" />

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<%
    boolean bPwdDebug           = false; // true; // 

    // String  changePwd           = "changePwd";
    // String  onFieldSize         = "";
    String  passwordFieldSize   = "";

    String  sSelfService        = NcsUtil.getRequestAttribute( request, "selfService",  "" ); 
    boolean bSelfService        = sSelfService.equalsIgnoreCase( "true" );

    if (!session.getAttribute("DeviceType").equals("pocket"))
    {
       // onFieldSize = c.string("UI.textboxSize");
       passwordFieldSize = c.string("UI.textboxSize");
    }
    else
    {
       // onFieldSize = c.string("PocketUI.textboxSizeOneButton");
       passwordFieldSize = c.string("PocketUI.textboxSize");
    }
%>


<HTML>

   <SCRIPT language="JavaScript">

      var ENABLED_COLOR = "white";
      var DISABLED_COLOR = "#EFEEE9";

      function isValid()
      {
         var form = document.forms[0];
         if ( form.SetPswdNewPassword == null ) return( true );
         if(form.SetPswdNewPassword.value != form.SetPswdVerifyPassword.value)
         {
            alert("<%= c.string("SetPassword.PasswordsDontMatch") %>");
            return( false );
         }
         return( true )
      }

      function onPageLoad()
      {
         document.form.single.focus();

      }

   </script>

<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <iman:stylesheet/>
   <iman:uihandlerTools/>


   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
   <iman:osScripts/>
</HEAD>

<BODY>

<%
  c.set("TaskHeader.title",   ncsCommon.getProperty( "ncsEMEA_task_ChangePassword" )); // ncsCommon.getProperty(ncs_thisTask ));
  c.set("TaskHeader.iconAlt", ncsCommon.getProperty( ncs_thisTask )); 
  c.set("TaskHeader.iconUrl", "dir/Person.gif");
%>
<jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

   <%-- iman:taskHeader title="Password Self Service"/--%>

  <!-- <%= ncsCommon.getUser().getDn() %> -->
<form name="uploadForm" method="post" onSubmit="return isValid();" action="webacc?Autoparse=true" enctype="multipart/form-data">
    <INPUT type="hidden" name="error"                 value="dev.GenErr">
    <INPUT type="hidden" name="User.context"          value='<c:out value="${User.context}" />'>
    <INPUT type="hidden" name="taskId"                value="<%= ncs_thisTaskId %>">
    <INPUT type="hidden" name="merge-template-entry"  value="<%= NcsUtil.getRequestAttribute( request, "merge-template-entry", "" ) %>">
    <INPUT type="hidden" name="pwd_attribute"         value="<%= NcsUtil.getRequestAttribute( request, "pwd_attribute", "" ) %>">   
<p>

<c:if test="${phase == '0'}">
    <INPUT type="hidden" name="nextState" value="changePassword">

    <TABLE border="0" cellspacing="0" cellpadding="1">
      <% 
      boolean isAdminMode = !bSelfService; // false; // true; // 
      if ( isAdminMode )
      {
      %>
       <INPUT type="hidden" name="setPassword"    value="true"> 
      <% } else { %>
       <INPUT type="hidden" name="setPassword"    value="false"> 
        <tr>
          <td class=mediumtext><%= c.string("SetPassword.OldPassword") %>:&nbsp;&nbsp;</td>
          <td><input type=password name="SetPswdOldPassword" value="" size=<%= passwordFieldSize %> maxlength="128"></td>
        </tr>
      <% } %>

      <tr>
        <td class=mediumtext><%= c.string("SetPassword.NewPassword") %>:&nbsp;&nbsp;</td>
        <td><input type=password name="SetPswdNewPassword" value="" size=<%= passwordFieldSize %> maxlength="128"></td>
      </tr>

      <tr>
        <td class=mediumtext><%= c.string("SetPassword.RenterPassword") %>&nbsp;&nbsp;</td>
        <td><input type=password name="SetPswdVerifyPassword" value="" size=<%= passwordFieldSize %> maxlength="128"></td>
      </tr>

      <TR><TD height="9"></TD></TR>

    </TABLE>

      <br>
      <% if ( bPwdDebug ) { %>
      <br> <b>phase:</b> <c:out value="${phase}"/> 
      <br> <b>success:</b> <c:out value="${success}"/> 
      <% } %>
      <br> <c:out value="${msg}"/> 
      <p>

      <BR>
      <iman:bar/>
      <iman:button key="OK" type="input"/>
      <iman:cancelBtn/>
</c:if>


<c:if test="${phase == '1'}">
    <INPUT type="hidden" name="nextState" value="done">
         <br>
<% if ( bPwdDebug ) { %>
         <br> Password change ...
         <br>
         <br> <b>phase:</b> <c:out value="${phase}"/> 
         <br> <b>success:</b> <c:out value="${success}"/> 
<% } %>
         <br> <c:out value="${msg}"/> 
      <p>

      <BR><BR>
      <iman:bar/>
      <iman:cancelBtn/>
</c:if>

   </form>
</BODY>
</HTML>
