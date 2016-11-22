<%@page import="com.novell.ncsEMEA.util.*, java.util.*, com.novell.nps.sessionManager.*, org.apache.log4j.Logger" %>
<%--

This JSP does nothing but return an XML dom 
The Dom contains the fixed elements time and count (todo) and - optionally attributes from the session vars
To get vars from the session buffer, call it with the expected session var names as url parameters "getVar=test1;test2'

Use for example with 
    include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ajax.jsp"           
    see an example there
    
    
We may for example start a task in a 2nd JSP, and use this JSP polling and displaying session vars that are set by that other JSP
    
--%>
<%!
   Logger logger = Logger.getLogger( "AjaxResponder" );
%>

<%
    response.setHeader("Cache-Control", "no-cache" );
    response.setContentType("text/xml");

    int iCounter = 0;    

    out.println("<response>");
    out.println( NcsUtilHtml.xmlTagged( "count",      "",       String.valueOf( iCounter++ ),   false     ));
    out.println( NcsUtilHtml.xmlTagged( "time",       "",       ""+new java.util.Date(),        false         ));

    // we may request certain values from our session by passing the names as request parameters "getVars=abc;def;ghi"
    String sSessionAttrNames = (String) request.getParameter( NcsUtilAjax.CONST_GETVAR );
    if (logger.isDebugEnabled() ) logger.debug( "sessionAttrNames=" + sSessionAttrNames );
    if ( sSessionAttrNames != null )
    {
      String[] saSessionAttrNames = sSessionAttrNames.split( ";" );
      for ( int iPar=0; iPar<saSessionAttrNames.length; iPar++ )
      {
        String sAttrValue = (String) request.getSession().getAttribute( saSessionAttrNames[iPar] );
        if (logger.isDebugEnabled() ) logger.debug( saSessionAttrNames[iPar] + "=" + sAttrValue );
        out.println( NcsUtilHtml.xmlTagged( saSessionAttrNames[iPar],     "",     sAttrValue,     false ));
        sAttrValue = null;
      }
      saSessionAttrNames  = null;
      sSessionAttrNames   = null;
    }
    out.println("</response>");
    // NcsUtilDebug.logMemory();
    NcsUtilBasics.garbageCollection( 10000000 );
%>
<%@ page contentType="text/xml" %>




