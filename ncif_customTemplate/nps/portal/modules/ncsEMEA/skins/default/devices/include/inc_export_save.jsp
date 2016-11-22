<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<%--   

provide form variables that prepare output to an export form

prerequisites:
   * collect the data and store them as ArrayList
   * put the data into the session variable 


    // can be set with  JS  function  callExportForm( par_format, par_separator, par_preformatted, par_quote, par_print, par_title )
    //  - declared in   include/inc_export.jsp
    //  - called in     include/inc_ncsSearch_searchResults.jsp

example

<% // test ... prepare some dummy data 
  String sParName = NcsUtil.sTempVar; // = "tempData";
  session.removeAttribute( sParName );
  ArrayList alData = new ArrayList();

  // the first entry in the ArrayList is the title row
  for ( int iCol=1; iCol<6; iCol++ ) 
      alData.add( "Header " + String.valueOf( j ));

  for ( int iRow=1; i<10; iRow++ ) {
    ArrayList alRow = new ArrayList();
    for ( int iCol=1; iCol<6; iCol++ )
         alRow.add( "data  row=" + iRow + " / col=" + iCol );
    alData.add( alRow );
  }
  // save table as ArrayList of ArrayLists and store in session var "tempData"
  session.setAttribute( sParName, alData );
%>     

TEST contents
   ArrayList alDataTest = ( ArrayList ) session.getAttribute( NcsUtil.sTempVar );
   out.println( "<table border='1'>" ); 
   for ( int iRow=0; iRow<alDataTest.size(); iRow ++ ){
      ArrayList alRowTest = ( ArrayList ) alDataTest.get(iRow);
      out.println( "<tr><td>" + iRow + "</td>" ); 
      for ( int iCol=0; iCol<alRowTest.size(); iCol++ ){
         out.println( "<td>" + alRowTest.get(iCol).toString() + "</td>" ); 
      }
      out.println( "</tr>" ); 
   }
   out.println( "</table>" ); 



You may also 'manually' add lines to the ArrayList - with something like ...
   alData.add(  NcsUtil.stringArrayToArrayList( new String[] { "Hello", "world" } ) );

 <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" %>
   <iman:bar/>
   <table width="100%" border="0">
      <tr><td>
         <a href='#' onclick='javascript: callExportForm( "csv",   ";",  "FALSE", "\"", "",     "" );'> <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportcsv", "Export Comma Separated Values" ) %></a>&nbsp;
         <a href='#' onclick='javascript: callExportForm( "xls",   "\t", "FALSE", "",   "",     "" );'> <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportxls", "Export to Spreadsheet" ) %></a>&nbsp;
         <a href='#' onclick='javascript: callExportForm( "html",  "",   "FALSE", "",   "yes",  "Search Results" );'>  <%= NcsUtil.getButtonImg( request, ncs_Language, "btnprint", "Print Values" ) %></a>&nbsp;          
         <a href='#' onclick='javascript: callExportForm( "csv",   "",   "FALSE", "",   "",     "" );'> <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexport", "Export data" ) %></a>&nbsp;
      </td></tr>
   </table>
   <iman:bar/>

...  must be outside of FORM tag .....



Example to set additional CSS:

    <script type='text/javascript'>
      var cssLink = "<link rel='stylesheet' href='<%= request.getContextPath() %>/portal/modules/XXX/css/hf_style.css'>"
      setExportVar( 'css', cssLink );
    </script>

--%>
<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export_vars.jsp" %>
</form>  <%-- conclude existing form ... --%>

<form name="exportData" id="exportData" method="post" target="_build" action="/nps/portal/modules/ncsEMEA/skins/default/devices/default/task_ncsExport.jsp">
      <input type="hidden" name="<%= sPar_print %>"         id="<%= sPar_print %>"        value=""			/>
      <input type="hidden" name="<%= sPar_format %>"        id="<%= sPar_format %>"       value="html"	/>
      <input type="hidden" name="<%= sPar_separator %>"     id="<%= sPar_separator %>"    value=";"		/>
      <input type="hidden" name="<%= sPar_preformatted %>"  id="<%= sPar_preformatted %>" value="FALSE"	/>
      <input type="hidden" name="<%= sPar_quote %>"         id="<%= sPar_quote %>"        value="'"		/>
      <input type="hidden" name="<%= sPar_title %>"         id="<%= sPar_title %>"        value="iManager Export Data"/>
      <input type="hidden" name="<%= sPar_data %>"          id="<%= sPar_data %>"         value="<%= NcsUtil.sTempVar %>"/>
      <input type="hidden" name="<%= sPar_extension %>"     id="<%= sPar_extension %>"    value=".html"	/>
      <input type="hidden" name="<%= sPar_css %>"           id="<%= sPar_css %>"          value=""			/>

   <script type='text/javascript'>
      function setExportVar( sVarName, sVarValue ) {
         var field = document.getElementsByName( sVarName )[0];
         if ( field == null ) 
           field = document.getElementById( sVarName );
         if ( field == null ) return;
         field.value = sVarValue;
      }

      <%-- overwrite default hiiden parameters
       par_format        html, txt, csv, txt, save, print, xls, xml
       par_separator     used for CSV, XLS:  e.g., "," or "|". 
       par_preformatted  do default formatting: TRUE/FALSE
       par_quote         e.g. "'", "\"", or '"'
       par_print         show print button: TRUE/FALSE
       par_title         add page title
      --%>
      function  callExportForm( par_format, par_separator, par_preformatted, par_quote, par_print, par_title )
      {
   //     alert ( "callExportForm: " + par_format + " / " + par_separator + " / " + par_quote + " / " + par_print + " / " + par_title );
        var exportForm = document.getElementsByName( "exportData" )[0];
        if ( exportForm == null ) {
         exportForm = document.getElementById( "exportData" );
         }
   //     alert ( "exportForm: "     + exportForm.name );
        setExportVar( "<%= sPar_format %>",        par_format ); 
        setExportVar( "<%= sPar_separator %>",     par_separator ); 
        setExportVar( "<%= sPar_preformatted %>",  par_preformatted ); 
        setExportVar( "<%= sPar_quote %>",         par_quote ); 
        setExportVar( "<%= sPar_print %>",         par_print ); 
        setExportVar( "<%= sPar_title %>",         par_title ); 
        exportForm.submit();
      }
   </script>
   
</form>

