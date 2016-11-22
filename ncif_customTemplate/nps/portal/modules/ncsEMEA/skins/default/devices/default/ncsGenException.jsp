<%@  page pageEncoding="utf-8" 
          contentType="text/html;charset=utf-8" 
          import="java.io.*, java.util.*, com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils" %>
<%@  page isErrorPage="true" %>



<%-- call in JSP header with ...
  <%@ page errorPage="/portal/modules/ncsEMEA/skins/default/devices/default/ncsGenException.jsp"%>
--%>

<%!
  public String getStackTrackAsString( Throwable e )
  {
    ByteArrayOutputStream bytes   = new ByteArrayOutputStream();
    PrintWriter           writer  = new PrintWriter( bytes, true );
    e.printStackTrace( writer );
    return ( bytes.toString() );
  }
%>


<%   JSPConduit c = JSPConduit.getJSPConduit(request); 
   c.set("GeneralMsg.Mode", "error"); 
   c.set("GeneralMsg.MsgBodyPlainText", "[" + exception.toString() + "] [" + exception.getMessage() + "]"); 
%>

  <table border='1' rules=rows >
    <tr><td>exception          </td><td> <%=  exception.toString() %> </td></tr>
    <%
      Enumeration enumP = request.getParameterNames();
      for ( ; enumP.hasMoreElements(); )
      {
        String strParName = (String) enumP.nextElement();
        Object oValue     = request.getParameter( strParName );
    %>
    <tr><td><%= strParName %>  </td><td> <%=  oValue %> </td></tr>
    <% } %>
    <tr><td>Exception</td><td><pre> <%=  getStackTrackAsString( exception) %> </pre></td></tr>
  </table>

<!--
  exception:                    
      <%=  getStackTrackAsString( exception) %>
      
      
  getAttributeNames:    
    <%
      Enumeration enumA = request.getAttributeNames();
      for ( ; enumA.hasMoreElements(); )
      {
        String strParName = (String) enumA.nextElement();
        Object oValue     = request.getAttribute( strParName );
    %>
    <%= strParName %>  :  <%=  oValue %> 
    <% } %>
      
-->



<jsp:include page="/portal/modules/dev/skins/default/devices/default/GenMsg.jsp" flush="true" />

<%-- no further display beyond this include ( </body></html> )  --%>





