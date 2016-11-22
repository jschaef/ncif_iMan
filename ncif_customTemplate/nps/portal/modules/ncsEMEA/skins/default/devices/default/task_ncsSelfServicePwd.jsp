<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>

<% JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>
<iman:stringtable bundle="com/novell/ncsEMEA/resources"/>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<%--

  <task>
      <id>task_pwdSelfSvc</id>
      <version>2.0.0</version>
      <required-version>2.0.0</required-version>
      <class-name>com.novell.emframe.dev.EmptyTask</class-name>
      <merge-template>ncsEMEA.task_ncsSelfServicePwd</merge-template> 
      <display-name-key>task_pwdSelfSvc</display-name-key>
      <description-key>task_pwdSelfSvc</description-key>
      <resource-properties-file>com.novell.ncsEMEA.resources</resource-properties-file>
      <url-param>
         <param-key>resource-properties-file</param-key>
         <param-value>com.endress.infoserve.imanager.resources</param-value>
      </url-param>
      <role-assignment>role_ncsEMEA</role-assignment>
   </task>

--%>


<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
   
   <script type='text/javascript'>
      function validate()
      {
         if( document.chgPwd.pwd_1.value == document.chgPwd.pwd_old.value )
         {
            alert("<iman:string key="message.pwdMatch"/>");
            alert( "<iman:string key="message.pwdOld"/> = <iman:string key="message.pwdNew"/>");
            return false;
         }
         if( document.chgPwd.pwd_1.value != document.chgPwd.pwd_2.value)
         {
            alert("<iman:string key="SetPassword.PasswordsDontMatch"/>");
            return false;
         }
         document.chgPwd.submit();
      }
   </script>
</HEAD>

<BODY>
<%
  
  String pwd_chg      = NcsUtil.getRequestAttribute( request, "pwd_chg", "" );
  String pwd_old      = NcsUtil.getRequestAttribute( request, "pwd_old", "" );
  String pwd_1        = NcsUtil.getRequestAttribute( request, "pwd_1",   "" );
  String pwd_2        = NcsUtil.getRequestAttribute( request, "pwd_2",   "" );
  String sError       = "";

  boolean bSubmit     = ( pwd_chg.length() > 0 );
  boolean bShowTable  = true;

  if ( bSubmit ) {
    try {
      ncsCommon.getTree().getNs().changePassword( ncsCommon.getUser().getOe(), pwd_old, pwd_1 );
      bShowTable = false;
    }
    catch( Exception e ) {
      sError = e.getLocalizedMessage();
    }
  }
%>
<iman:taskHeader titleKey="ChangePassword.title" /><BR>

<FORM name="chgPwd" method=post action="webacc">
<input type='hidden' name='GI_ID'         value='<%= ncs_thisTaskId %>'>
<INPUT type='hidden' name='nextState'     value='initialState'>
<INPUT type='hidden' name='error'         value='dev.GenErr'>

<% if ( bSubmit && ( sError.length() == 0 ) ) { // we submitted the password change request successfully ... %>
    <h3><iman:string key="message.pwdChanged"/></h3>
<% } %>

<% if ( bSubmit && ( sError.length() > 0 ) ) { // we submitted the password change request and got an error ... %>
    <h3><iman:string key="message.pwdNotChanged"/></h3>
    <p><font color='red'><%= sError %></font>
<% } %>


<% if ( bShowTable ) { %> 
     <input type="hidden" name="pwd_chg" value="true">
     <table>
        <tr>
        	 <td nowrap class="mediumtext"><iman:string key="AuthenticateForm.UserNameEditBoxHeader"/></td>
           <td class="mediumtext"><%= ncsCommon.getUser().getDn() %></td>
        </tr>
        <tr><td height='10' colspan='99'></td></tr>
        <tr>
           <td class="mediumtext"><iman:string key="CreateUser.Password"/></td>
           <td><input name="pwd_old" type="password" value="<%= pwd_old %>" style="width: <iman:string key="UI.textboxPixel"/>"/></td>
        </tr>
        <tr>
           <td class="mediumtext"><iman:string key="ChangePassword.newPassword"/></td>
           <td><input name="pwd_1"  type="password" value="<%= pwd_1 %>" style="width: <iman:string key="UI.textboxPixel"/>"/></td>
        </tr>
        <tr>
           <td class="mediumtext"><iman:string key="ChangePassword.newPasswordVerify"/></td>
           <td><input name="pwd_2"  type="password" value="<%= pwd_2 %>" style="width: <iman:string key="UI.textboxPixel"/>"/></td>
        </tr>
     </table>

      <BR><BR>
      <iman:bar/>
      <iman:button key="OK" onClick="validate()"/>
<% } else { %>
     <input type="hidden" name="pwd_chg" value="">
     <BR><BR>
<% } %>
 
      <iman:cancelBtn/>
   </form>
</BODY>
</HTML>
