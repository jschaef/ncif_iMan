<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

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

<HTML>
<HEAD>
<%--
    <meta http-equiv="Page-Enter"     content="revealTrans(Transition=12,Duration=0.5)">
    <meta http-equiv="Page-exit"      content="revealTrans(Transition=12,Duration=0.3)">
    <meta http-equiv="Page-Enter"     content="revealTrans(Transition=6,Duration=0.1)">
    <meta http-equiv="Page-exit"      content="revealTrans(Transition=6,Duration=0.1)">
--%>
    <meta http-equiv="Page-Enter"     content="revealTrans(Transition=6,Duration=0.1)">
    <meta http-equiv="Page-exit"      content="revealTrans(Transition=6,Duration=0.1)">
    <meta http-equiv="cache-control"  content="no-cache">
    <meta http-equiv="pragma"         content="no-cache">
    <TITLE><iman:string key="ProductName"/></TITLE>
    <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
    <iman:eMFrameScripts/>
</HEAD>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<BODY>

   <% 
        c.set("TaskHeader.title",   "Import results" );
        c.set("TaskHeader.iconUrl", "dir/Profile.gif");
        c.set("TaskHeader.iconAlt", c.var ("TranslatedClass")); 
    %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

  
  
<%
    String        sPrefix     = NcsUtilHtml.getSessionAttribute( request, NcsUtilAjax.CONST_prefix, "" );
    NcsUtilAjax   ncsUtilAjax = new NcsUtilAjax( request, sPrefix );
    String        s_status    = NcsUtilBasics.stringFix( ncsUtilAjax.getSessionData( NcsUtilAjax.CONST_status ));
    String        s_linesCurr = NcsUtilBasics.stringFix( ncsUtilAjax.getSessionData( NcsUtilAjax.CONST_linesCurr ));
    String        s_linesMax  = NcsUtilBasics.stringFix( ncsUtilAjax.getSessionData( NcsUtilAjax.CONST_linesMax  ));
    ArrayList     alResults   = (ArrayList) ncsUtilAjax.getSessionData( NcsUtilAjax.CONST_results );
    
    int           i_linesCurr = NcsFormat.strToInt( s_linesCurr, -1 );
    int           i_linesMax  = NcsFormat.strToInt( s_linesMax , -1 );
    String        sProgress   = "";
    if (( i_linesCurr >= 0 ) && ( i_linesMax > 0 )) sProgress = NcsUtilIManager.progressBar( request, 32, 500, i_linesCurr, i_linesMax );
%>
  
  
   <iman:bar/>
   
   
  <% 
    if ( !s_status.equalsIgnoreCase( "true" ) ) //  !( String.valueOf( true ).equalsIgnoreCase( s_status )) )  // reload page until completed
    {
  %>
  
  
  <p>
  
     <TABLE <%-- class="mediumtext" --%> border='0'>
          <tr>
            <td><b>Lines</B></td>
            <td><%= s_linesCurr %> / <%= s_linesMax %></td>
          </tr>
          <tr>
            <td colspan="2"><%= sProgress %></td>
          </tr>
          <tr>
            <td colspan="2"><%= ncs_Wait %></td>
          </tr>
      </table>
 
    <script type='text/javascript'>
      window.setTimeout( "location.reload( true );", 1500 );
    </script>
    
   <table width="100%" border="0">
     <tr>
     <td>
      <iman:cancelBtn/>
     </td>
     </tr>
   </table>
    
    
  <%
      NcsUtilBasics.garbageCollection( 20000000 );
    }
    else
    {
  %>
  
  
     <TABLE <%-- class="mediumtext" --%> border='0'>
        <tr>
          <td></td>
          <td colspan='2'><c:out value="${result}" escapeXml="false"/></td>
        </tr>
        <tr>
          <td></td>
          <td colspan='2'>
            <ol>
              <% for ( int i=0; i<alResults.size(); i++ ) { %>
                <li> <%= ( String ) alResults.get(i) %> </li>
              <% } %>  
            </ol>
          </td>
        </tr>
     </table>

<p>

   
   
   
   <iman:bar/>

   
   <% 
      // store results into session variable for access by export form, remove the html formatting
      //ArrayList alTemp = ( ArrayList ) request.getAttribute( "arResults" );
      ArrayList alTemp = new ArrayList( alResults );
      for ( int i = 0; i<alTemp.size(); i++ ) {
         ArrayList alRow = new ArrayList();
         String sLine = alTemp.get(i).toString();
         sLine = NcsUtil.stringCutBeforeString( sLine, ">" );
         sLine = NcsUtil.stringCutAfterString( sLine, "</" );
         alRow.add( sLine );
         alTemp.set( i, alRow );
      }
      session.setAttribute( NcsUtil.sTempVar, alTemp );
      
      
      ncsUtilAjax.clearSessionData();
   %>

   <table width="100%" border="0">
     <tr>
     <td>
      <iman:cancelBtn/>
      <a href='#' onclick='javascript: callExportForm( "csv",   ";",  "FALSE", "\"", "",  "" );'>                       <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportcsv",  "Export Comma Separated Values" ) %></a>&nbsp;
      <a href='#' onclick='javascript: callExportForm( "xls",   "\t", "FALSE", "",   "",  "" );'>                       <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportxls",  "Export to Spreadsheet" ) %></a>&nbsp;
     </td>
     </tr>
   </table>
   
   <p/>
   <iman:bar/>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" %>

<% } %>


</body>
</HTML>
