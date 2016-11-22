<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_resultsDisplay.jsp" --%>
<%-- used in ncs_Search --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_resultsDisplay.jsp start -->

   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_customButtons.jsp" %>

   <%= ncsUtilSearch.searchProperties.getProperty( xml_textBeforeResults, "" ) %>
   <p>
   <table <%= NcsUtil.css_data_table %> cellpadding='3' width='100%' border='0'>
    <tr bgcolor='#DDDDDD' <%= NcsUtil.css_data_tr %>><TD colspan='20' align='left' width='10%'><%= ncsUtilSearch.searchProperties.getProperty( "info.hitCount" ) %>:  <%= String.valueOf( iResults ) %> &nbsp;</TD> </tr>
    <tr <%= NcsUtil.css_data_tr %>><td height='12'></td></tr>
    <%  out.flush(); %>
    <%= ncsUtilSearch.sbDisplayData.toString() %>
    <%  ncsUtilSearch.sbDisplayData.setLength(0); // release memory %>
   </table>
   <p/>   
   <%= ncsUtilSearch.searchProperties.getProperty( xml_textAfterResults, "" ) %>
   <iman:bar/>

   <%= sCustomButtons %> 

   <% 
   if ( ncsUtilSearch.bShowExportOptions && xml_displayExport ) {
   %>
   <p>
   <table width="100%" border="0">
      <tr>
         <td>
				<%-- see "/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" --%>
            <a href='#' onclick='javascript: callExportForm( "csv",   ";",  "FALSE", "<%= sExportCsvQuoteCharacter %>", "",  "" );'>                       <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportcsv",  "Export Comma Separated Values" ) %></a>&nbsp;
            <a href='#' onclick='javascript: callExportForm( "xls",   "\t", "FALSE", "",   "",  "" );'>                       <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportxls",  "Export to Spreadsheet" ) %></a>&nbsp;
				<a href='#' onclick='javascript: window.print();'>																						<%= NcsUtil.getButtonImg( request, ncs_Language, "btnprint",      "Print Values" ) %></a>&nbsp;          
            <a href='#' onclick='javascript: callExportForm( "html",  "",   "FALSE", "",   "",  "HTML Export (<%= ncsCommon.getUser().getShortName() %> <%= HelperFormat.dateToStr( "yyyy-MM-dd HH:mm" ) %>)" );'>   <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexporthtml", "Export to HTML" ) %></a>&nbsp;          
         </td>
      </tr>
   </table>
   <p/>
   <iman:bar/>
   <%-- we need to close the current form and create new one in inc_export --%>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" %>
   <script type='text/javascript'> setExportVar( '<%= sPar_preformatted %>', true ); </script>
   <% } %>

   <% // force garbage collection
   if ( bShowResults )
   {
      Runtime.getRuntime().gc();
      Runtime.getRuntime().runFinalization();
   }
   %>
    
<!-- inc_ncsSearch_resultsDisplay.jsp end -->

