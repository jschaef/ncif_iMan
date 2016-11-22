<%@page import="com.novell.ncsEMEA.util.*, com.novell.ncs.lib.general.*, java.util.*, com.novell.nps.sessionManager.*, org.apache.log4j.Logger"   %><%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %><%@ taglib uri="/WEB-INF/c.tld" prefix="c" %><%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %><%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export_vars.jsp" %><fmt:setBundle basename="DevResources"/><%


/**
   // jsp and java code that accepts the data passed in request variables and displays in requested format
 *
 *  accepted keys/parameters in form request (see include/inc_export_vars.jsp):
 *    sPar_separator
 *    sPar_preformatted
 *    sPar_quote
 *    sPar_format
 *    sPar_print
 *    sPar_title
 *    sPar_extension
 *    
 */

	// set the parameters - the pars have been set in inc_export.jsp 
   Logger logger = Logger.getLogger( "Export" );
   String par_separator = HelperHtml.getRequestParameter( request, sPar_separator,				"" );
   pageContext.setAttribute(sPar_separator, par_separator, pageContext.PAGE_SCOPE );

   String par_preformatted		= HelperHtml.getRequestParameter( request, sPar_preformatted,	"FALSE" );
   pageContext.setAttribute(	sPar_preformatted, par_preformatted, pageContext.PAGE_SCOPE );

   String par_quote				= HelperHtml.getRequestParameter( request, sPar_quote,			"" );
   pageContext.setAttribute(	sPar_quote, par_quote, pageContext.PAGE_SCOPE );

   String par_filename			= HelperHtml.getRequestParameter( request, sPar_filename,		"export" );		// pass custom export file name
   pageContext.setAttribute(	sPar_filename, par_filename, pageContext.PAGE_SCOPE );

   String par_format				= HelperHtml.getRequestParameter( request, sPar_format,			"html" );
   pageContext.setAttribute(	sPar_format, par_format, pageContext.PAGE_SCOPE );

   String par_print				= HelperHtml.getRequestParameter( request, sPar_print,			"" );
   pageContext.setAttribute(	sPar_print, par_print, pageContext.PAGE_SCOPE );

   String par_title				= HelperHtml.getRequestParameter( request, sPar_title,			"iManager Export Data" );

   pageContext.setAttribute(	sPar_title, par_title, pageContext.PAGE_SCOPE );
	if (		(   "csv".equalsIgnoreCase(	par_format )) 
			|| (   "txt".equalsIgnoreCase(	par_format )) 
			|| (  "save".equalsIgnoreCase( par_format )) 
			|| ( "print".equalsIgnoreCase( par_format )) )			response.setContentType( "text/plain" );
	else	if (   "xml".equalsIgnoreCase(	par_format ))			response.setContentType( "text/xml" );
	else	if (   "xls".equalsIgnoreCase(	par_format ))			response.setContentType( "application/vnd.ms-excel" );
	else																			response.setContentType( "text/html" );
 
	if (		(  "csv".equalsIgnoreCase(	par_format )) 
			|| (  "txt".equalsIgnoreCase(	par_format )) 
			|| ( "save".equalsIgnoreCase( par_format )) 
			|| (  "xls".equalsIgnoreCase(	par_format ))
			|| (  "xml".equalsIgnoreCase(	par_format )) )			response.setHeader( "Content-disposition","attachment;filename=" + par_filename + "." + par_format );
 
   String par_extension = HelperHtml.getRequestParameter( request, sPar_extension, ".html" );

	// copy session data to page context - the name of the session var is passed in par_data (typically NcsUtilBasics.sTempVar)
	String par_data = HelperHtml.getRequestParameter( request, sPar_data, "" );

	if ( par_preformatted.equalsIgnoreCase( "TRUE" )) 
	{ // unformatted - display as is
		 Object oFmt = session.getAttribute( par_data + "Fmt" );
		 if ( oFmt == null ) oFmt = "'" + par_data + "Fmt' is undefined";
		 pageContext.setAttribute( "pageVar", oFmt );
	  }
	else 
	{  // formatted html
		pageContext.setAttribute( "pageVar", session.getAttribute( par_data ));
	}
	String ncs_Language = "en";

	try 
	{
		ncs_Language = com.novell.emframe.dev.eMFrameFactory.getTaskContext(request).getLocale().getLanguage();
	}
	catch(Exception e)  {}

%><c:choose><c:when test="${(par_format == 'html') || (par_format == 'save') || (par_format == 'print')}">
<html>
  <head>
    <link rel='stylesheet' href='<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css'>
    <%= HelperHtml.getRequestParameter( request, "css", "" ) %> <%-- used to pass additional stylesheets --%>
  </head>
  <body>
    <% if ( par_preformatted.equalsIgnoreCase( "TRUE" )) { // preformatted - display as is %>
		<c:forEach var='dataRow' varStatus="row" items='${pageVar}'>
        <c:out value='${dataRow}' escapeXml='false'/>
      </c:forEach>
    <% } else { // formatted into rows and cells %>
		<p>
      <table width="100%" border="0" cellspacing="1" cellpadding="3" style="white-space: nowrap">
			<tr class="tablehead1">
			  <td colspan="5"  style="border-bottom: 2px solid #458ab9"><%= par_title %></td>
			</tr>
      </table>

      <table border="0" cellspacing="1" cellpadding="3"  style="width: 100%">
        <c:forEach var='dataRow' varStatus="row" items='${pageVar}'>
            <tr  class="smalltext">
                <c:forEach var='dataCell' varStatus="col" items='${dataRow}'>
                  <c:if test="${row.first}"><th valign="bottom" align='left' size='+2' class="tablecolumnhead1"></c:if>
                  <c:if test="${not row.first}"><td bgcolor='#EEEEEE'></c:if>
                      <c:out value='${dataCell}'/>
                  <c:if test="${row.first}"></th></c:if>
                  <c:if test="${not row.first}"></td></c:if>
                </c:forEach>  
            </tr>
        </c:forEach>
      </table>
    <% } %>      

    <% if ( NcsUtil.stringNotEmpty( par_print )) { %>
		<table border="0" cellspacing="1" cellpadding="3"  style="width: 100%">
        <TR><TD height="20"></TD></TR>
        <tr>
          <td>
            <a href='javascript:window.print();'>
              <%= NcsUtil.getButtonImg( request, ncs_Language, "btnprint", "Print Values" ) %></a>
            &nbsp;  <%-- if (window.external) document.execCommand("SaveAs" ... // if the browser is IE --%>
            <a href='javascript:document.execCommand("SaveAs", null, ".html");document.close();'>
              <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexporthtml", "Save as HTML" ) %></a>
            &nbsp;  
            <a onclick='self.close();'>
              <%= NcsUtil.getButtonImg( request, ncs_Language, "btnclose", "Close" ) %></a>
          </td>
        </tr>
      </table>
    <% } %>

    <script type='text/javascript'>
       self.focus();        // bring to front
       <c:if test="${par_format == 'save'}"> <%-- auto-save --%>
          window.setTimeout( 'document.execCommand( "SaveAs", null, "*<%= par_extension %>")', 1000);
       </c:if>
       <c:if test="${par_format == 'print'}"> <%-- auto-print --%>
          window.setTimeout( 'window.print();', 1000);
       </c:if>
    </script>
    </br>
<%--	 
	<table border="1" cellpadding="1">
		<tr><td><b>sessionScope:</b>	</td></tr>
			<c:forEach var="rs" items="${sessionScope}">
			<tr><td><c:out value="${rs}"/></td></tr>
			</c:forEach>
	</table>
--%>	 
<p>
<hr>
</body>
</html><%-- non-html stuff should be compressed since every white space goes into the file --%>
</c:when><%	// 
%><c:otherwise><%
%><% if ( par_preformatted.equalsIgnoreCase( "TRUE" )) { // already formatted - display as is 
	%><c:forEach var='dataRow' varStatus="row" items='${pageVar}'><c:out value='${dataRow}' escapeXml='false'/></c:forEach>
<% } else { %><%
	%><c:forEach var='dataRow' varStatus="row" items='${pageVar}'><%
		%><c:forEach var='dataCell' varStatus="col" items='${dataRow}'><%= par_quote %><c:out value='${dataCell}' escapeXml='false'/><%= par_quote %><c:if test="${not col.last}"><%= par_separator %></c:if></c:forEach>
</c:forEach>
<% } %><%
%></c:otherwise><%
%></c:choose><%

%><% out.flush(); %>