<%@ page import="com.novell.ncsEMEA.util.*, com.novell.nps.gadgetManager.BaseGadgetInstance,
        java.io.*, 
        java.util.*, 
        com.novell.ldap.*,
        com.novell.ldap.util.*"%>
        
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<%@ page errorPage="/portal/modules/ncsEMEA/skins/default/devices/default/ncsGenException.jsp"%>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


<% 
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
   c.stringTable("com/novell/ncsDemo/resources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<fmt:setLocale value="${ClientLocale}"/>
<fmt:setBundle basename="DevResources"/>

<HTML>

<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
   <iman:include page="dev/OSScripts_inc.jsp"/>
</HEAD>

<BODY>
   <% 
      c.set("TaskHeader.iconUrl", "dir/rbsPage.gif");
      c.set("TaskHeader.title",   "LDIF Export" );
      c.set("TaskHeader.iconAlt", "Test" ); 
    %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />
<%--
   <iman:taskHeader title="ncsDemo_task_Ldif" iconUrl="dir/Person.gif" iconAlt="Test" />
--%>   
<p>
  <%-- ------------------------------------------------------------------------------------------- --%>

  <script type='text/javascript'>
      function onExit( action )
      {
        var form = document.forms[0];
        var success = true;
        return success;
      }
  </script>
    
<FORM name="Next" method=post action="webacc">

      <%-- required ... --%>
      <input type="hidden" name="GI_ID"         value="<%= ncs_thisTaskId %>">
      
      <%-- required for EmptyTask - if specified here, the page reloads after sumbit(), otherwise it exits --%>
      <INPUT type="hidden" name="nextState"     value="initialState">

      <%-- required for NcsDemo_task - if specified here, the specified page loads after sumbit(), otherwise the default page loads--%>
      <INPUT type="hidden" name="ncs_nextJsp"  value="ncsDemo/ncsDemo_task_Results.jsp">

      
      <% // get request variables ...
        String ncs_taskOption       = NcsUtil.getRequestAttribute( request, "ncs_taskOption",    "",                             false ); // true );

        String ncs_ldifBaseDn       = NcsUtil.getRequestAttribute( request, "ncs_ldifBaseDn",    ncsCommon.getTarget().getDn(),  false ); // true); // 
        String ncs_ldifFilter       = NcsUtil.getRequestAttribute( request, "ncs_ldifFilter",    "objectClass=*",                false ); // true); // 
        String ncs_ldifAttributes   = NcsUtil.getRequestAttribute( request, "ncs_ldifAttributes","",                             false ); // true); // 
        String ncs_ldifScope        = NcsUtil.getRequestAttribute( request, "ncs_ldifScope",     "",                             false ); // true );

        HelperResult result            = new HelperResult();
      %>
      
<%--      
   <br>
   <table>
     <tr><td colspan='2'><b><%= ncs_Date %></b></td></tr>
     <tr><td>ncs_taskOption</td>  <td><%= ncs_taskOption %></td></tr>
     <tr><td>taskId</td>          <td><%= ncs_thisTaskId %></td></tr>
     <tr><td>ncs_initialJsp</td>  <td><%= NcsUtil.getRequestParameter( request, "ncs_initialJsp", "" ) %></td></tr>
     <tr><td>ncs_thisJsp</td>     <td><%= ncs_thisJsp %></td></tr>
     <tr><td>ncs_taskState</td>   <td><c:out value="${ncs_taskState}"/></td></tr>
     <tr><td>getTarget</td>       <td><%= ncsCommon.getTarget().getDn() %></td></tr>
   </table>
   <br>
--%>     
     
<%  if ( ncs_taskOption.equalsIgnoreCase( "" )) {  %>

  <%-- used to set current status --%>
  <INPUT type="hidden" name="ncs_taskOption"  value="ldif_export">

  <TABLE>
  
      <%-- ncs_ldifBaseDn --%>
      <TR>
         <TD align=left>Base DN:&nbsp;&nbsp;</TD>
         <c:if test=" ${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <INPUT type="text" name="ncs_ldifBaseDn" value="<%= ncs_ldifBaseDn %>" size='<fmt:message key="UI.textboxSize"/>' style='width:<fmt:message key="UI.textboxPixel"/>' >
            <a onclick='alert("Select base object in untyped eDirectory format (e.g., \"test.myOu.myOrg\")")'><IMG src="<%= c.getModulesUrl() %>/dev/images/help_16.gif" border=0></A> 
            <iman:os initialContext="" typeFilter="*" history="true" control="ncs_ldifBaseDn" />
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      
      <%-- ncs_ldifFilter --%>
      <TR>
         <TD align=left>Filter:&nbsp;&nbsp;</TD>
         <c:if test=" ${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <INPUT type="text" name="ncs_ldifFilter" value="<%= ncs_ldifFilter %>" size='<fmt:message key="UI.textboxSize"/>' style='width:<fmt:message key="UI.textboxPixel"/>' >
            <a onclick='alert("Specify LDIF filter (e.g.: objectClass=*) or leave empty")'><IMG src="<%= c.getModulesUrl() %>/dev/images/help_16.gif" border=0></A> 
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      <%-- ncs_ldifAttributes --%>
      <TR>
         <TD align=left>Attributes:&nbsp;&nbsp;</TD>
         <c:if test=" ${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <INPUT type="text" name="ncs_ldifAttributes" value="<%= ncs_ldifAttributes %>" size='<fmt:message key="UI.textboxSize"/>' style='width:<fmt:message key="UI.textboxPixel"/>' >
            <a onclick='alert("Attribute List (e.g.: cn;description) or leave empty")'><IMG src="<%= c.getModulesUrl() %>/dev/images/help_16.gif" border=0></A> 
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      <%-- ncs_ldifScope --%>
      <TR>
         <TD align=left>
           Scope:&nbsp;&nbsp;
         </TD>
         <c:if test=" ${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <INPUT name="ncs_ldifScope" type="radio" value="Base" <%= ncs_ldifScope.equalsIgnoreCase("Base")? "CHECKED":"" %> <%= ncs_ldifScope.equalsIgnoreCase("")? "CHECKED":"" %> > Selected Object&nbsp;&nbsp;&nbsp;
            <INPUT name="ncs_ldifScope" type="radio" value="One"  <%= ncs_ldifScope.equalsIgnoreCase("One") ? "CHECKED":"" %> > Subordinates&nbsp;&nbsp;&nbsp;
            <INPUT name="ncs_ldifScope" type="radio" value="Sub"  <%= ncs_ldifScope.equalsIgnoreCase("Sub") ? "CHECKED":"" %> > Subtree&nbsp;&nbsp;&nbsp;
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

  </TABLE>
  
<% } %>
  


<%  if ( ncs_taskOption.equalsIgnoreCase( "ldif_export" )) {  %>

  <%-- reset current status --%>
  <INPUT type="hidden" name="ncs_taskOption"  value="">
  
  <%-- keep user input in request (for getting back to form)--%>
  <INPUT type="hidden" name="ncs_ldifBaseDn"      value="<%= ncs_ldifBaseDn %>" >
  <INPUT type="hidden" name="ncs_ldifFilter"      value="<%= ncs_ldifFilter %>" >
  <INPUT type="hidden" name="ncs_ldifAttributes"  value="<%= ncs_ldifAttributes %>" >
  <INPUT type="hidden" name="ncs_ldifScope"       value="<%= ncs_ldifScope %>" >
    
<%
  
  String       ncs_ldifLdapDn = NcsUtil.getTypedName( ncsCommon.getTree().getOe(), ncs_ldifBaseDn, false );
  
  int ncs_scope = LDAPConnection.SCOPE_BASE;
  if ( ncs_ldifScope.equalsIgnoreCase( "Base" ))  ncs_scope = LDAPConnection.SCOPE_BASE;
  if ( ncs_ldifScope.equalsIgnoreCase( "One" ))   ncs_scope = LDAPConnection.SCOPE_ONE;
  if ( ncs_ldifScope.equalsIgnoreCase( "Sub" ))   ncs_scope = LDAPConnection.SCOPE_SUB;

  String sDebug = "No base specified";
  if ( NcsUtil.stringNotEmpty( ncs_ldifLdapDn ))
  {
    ObjectEntry  oeTarget = NcsUtil.getObjectEntryCatch( ncsCommon.getTree().getOe(), ncs_ldifBaseDn );
    NcsUtil.historyAddItem( ncsCommon.getTaskContext(), oeTarget );
    result = ncsUtilLdap.ldifExport( 
                    ncs_ldifLdapDn,  
                    ncs_ldifFilter,
                    ncs_ldifAttributes,
                    ncs_scope, // SCOPE_BASE, // SCOPE_SUB, // 
                    session.getId() + ".ldif"
                    );
    session.setAttribute( "ncsLdif", result.getData() );
  }

  String sUrl  = NcsUtil.makeDelegationUrl( ncsCommon.getTaskContext(), ncs_ldifBaseDn, "shared_task_ncsDisplay", "", true );
%>

   <table cellspacing='10' width='100%'>
     <tr><td>ncs_ldifBaseDn</td>      <td><%= ncs_ldifBaseDn %></td></tr>
     <tr><td>ncs_ldifLdapDn</td>      <td><%= ncs_ldifLdapDn %></td></tr>
     <tr><td>ncs_ldifFilter</td>      <td><%= ncs_ldifFilter %> (<%= ncs_ldifScope %>)</td></tr>
     <tr><td>ncs_ldifAttributes</td>  <td><%= ncs_ldifAttributes %></td></tr>
<%--
     <tr><td>ncs_taskOption</td>  <td><%= ncs_taskOption %></td></tr>
      <tr><td>name</td>           <td><%= ncs_ldifBaseDn %> / <%= ncs_ldifLdapDn %>   </td></tr>
      <tr><td>getMsgDetail</td>   <td><%= result.getMsgDetail() %>                    </td></tr>
      <tr><td>getData</td>        <td><%= result.getData() %>                         </td></tr>

			    <A href="webacc?taskId=fw.DownloadFile&file=WEB-INF/temp\xxx/yyy.txt" target="_top">Download file</A><BR>
--%>
      <% if ( result.getData().length() > 0 ) { %>
      <tr><td><%= c.string("Button.Export.alt") %></td>     <td><textarea name="data" rows='20' cols='78'><%= result.getData() %></textarea></td></tr>
      <tr><td><%= c.string("Button.Save.alt") %></td>       <td><A href="<%= sUrl %>"><IMG onclick='alert("Use right-mouse click: Save Target As ...");return false;' src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Save.image") %>" alt="<%= c.string("Button.Save.alt") %>" title="<%= c.string("Button.Save.alt") %>" border=0></A> &nbsp;</td></tr>
      <% } %>
   </table>
  
<% } %>

  <p> <iman:bar/> <p>

  
  <%-- ------------------------------------------------------------------------------------------- --%>

  <jsp:include page='<%= c.getPath("dev/Cancel_inc.jsp") %>' flush="true" />&nbsp;

<%  if ( ncs_taskOption.equalsIgnoreCase( "" )) {  %>
  <A href="javascript: if(onExit() != false) document.forms[0].submit();"><IMG src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Export.image") %>" alt="<%= c.string("Button.Export.alt") %>" title="<%= c.string("Button.Export.alt") %>" border=0></A> &nbsp;
<% } %>

<%  if ( ncs_taskOption.equalsIgnoreCase( "ldif_export" )) {  %>
  <A href="javascript: if(onExit() != false) document.forms[0].submit();"><IMG src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Back.image") %>" alt="<%= c.string("Button.Back.alt") %>" title="<%= c.string("Button.Back.alt") %>" border=0></A> &nbsp;
<% } %>

  
  </FORM>
  <jsp:include page='<%= c.getPath("dev/OSFooter_inc.jsp") %>' flush="true" />

</body>
</HTML>
