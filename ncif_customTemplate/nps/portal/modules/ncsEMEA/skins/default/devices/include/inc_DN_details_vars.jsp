<%-- display details for DN attributes as a table of details for the DNs --%>
<%-- @ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_DN_details.jsp" --%>
<%-- example usage:
   
       <% if ( isAttrDisplay( "detail" )) { %>

         < %- - declare variables --% >
         <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_DN_details_vars.jsp" %>
         
         <%  // define what we need ...
             ncsDN_bExport          = true;                             // show export option ?
             ncsDN_bSequenceNr      = true;                             // show sequence number in col #1 ?
             ncsDN_prop             = ncsUtil_myCustomer;               // type NcsProperties to get custom display names
             ncsDN_sAttrName        = NcsUtilSchemaEdir.attr_Member;    // attr that holds the DNs
             ncsDN_saDisplayAttr    = new String[] {                    // array with attribute list to display
                NcsUtilSchemaEdir.attr_CONTEXT,
                NcsUtilSchemaEdir.attr_CN,
                NcsUtilSchemaEdir.attr_Surname,
                NcsUtilSchemaEdir.attr_Description
             };
         %>  
         < %-- get the data --% >
         <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_DN_details.jsp" %>
         < %-- show the data --% >
         <%= ncsDN_sDisplay.toString() %>

         < %-- show export options --% >
         <% if ( ncsDN_bExport ) { %>
            <iman:bar/>
              <table width="100%" border="0">
              <tr><td>
                 <a href='#' onclick='javascript: callExportForm( "csv",   ";",  "FALSE", "\"", "",     "" );'> <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportcsv", "Export Comma Separated Values" ) %></a>&nbsp;
                 <a href='#' onclick='javascript: callExportForm( "xls",   "\t", "FALSE", "",   "",     "" );'> <%= NcsUtil.getButtonImg( request, ncs_Language, "btnexportxls", "Export to Spreadsheet" ) %></a>&nbsp;
              </td></tr>
              </table>
            <iman:bar/>
         <% } %>   
      <% } %>
   
--%>
<%
    String        ncsDN_sAttrName      = "";
    String[]      ncsDN_saDisplayAttr  = null;
    String[]      ncsDN_saTasks        = null;  // tasks for delegation
    String[]      ncsDN_saButtons      = null;  // buttons for delegation
    NcsProperties ncsDN_prop           = null;
    StringBuffer  ncsDN_sDisplay       = null;
    boolean       ncsDN_bExport        = true;
    boolean       ncsDN_bSequenceNr    = true;
    boolean       ncsDN_bMultiSelect   = true;
    boolean       ncsDN_bLaunch        = true;  // false; // launch or delegate
%>
