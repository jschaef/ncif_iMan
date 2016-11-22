<%--

  JSP to display/save plain text data as stored in session buffer.  Sample call:

<%
  String sUrl  = NcsUtil.makeDelegationUrl( ncsCommon.getTaskContext(), "dummyDn", "shared_task_ncsDisplay", "", true );
%>
   <tr><td><%= c.string("Button.Save.alt") %></td>       <td><A href="<%= sUrl %>"><IMG onclick='alert("Use right-mouse click: Save Target As ...");return false;' src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Save.image") %>" alt="<%= c.string("Button.Save.alt") %>" title="<%= c.string("Button.Save.alt") %>" border=0></A> &nbsp;</td></tr>


--%>
<%@ page import="com.novell.ncsEMEA.util.*"%>
<%@ page pageEncoding="utf-8" contentType="text/plain" %>
<%
  response.setHeader("Content-Disposition", "attachment;filename=myFile.ldif"); 
  response.setContentType( "text/plain" ); 
%>
<%= NcsUtil.getSessionAttribute( request, "ncsLdif", "nothing" ) %>
