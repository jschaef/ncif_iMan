
<%-- display details for DN attributes as a table of details for the DNs --%>
<%-- @ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_DN_details.jsp" --%>

<%-- example usage:
   
       <% if ( isAttrDisplay( "detail" )) { %>

         < %-- declare variables - -% >
         <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_DN_details_vars.jsp" %>

         <%  // define what we need ...
             ncsDN_bExport          = true;                             // show export option?
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
   {
      // logger.debug ( "ncsDN_sAttrName: " + ncsDN_sAttrName );
      // get the data from edas - this requires the respective attribute to be present in the page xml declaration
      ArrayList     al          = NcsUtil.getAttributeFromEdas( request, NcsUtil.stringNormalize( ncsDN_sAttrName ));
      if ( al.size()==0 ) ncsDN_bExport = false;
      
      if ( ncsDN_prop == null ) ncsDN_prop = ncsCommon;

      String        ncsDN_sParName = NcsUtil.sTempVar; // = "tempData";
      ncsDN_sDisplay         = new StringBuffer( 50 );

      session.removeAttribute( ncsDN_sParName );
      ArrayList ncsDN_alData = new ArrayList();
      ArrayList ncsDN_alHead = new ArrayList();

      String        sBgColor0      = " bgcolor='#FFFFFF'";
      String        sBgColor1      = " bgcolor='#EEEEEE'";
      String        sBgColor2      = " bgcolor='#DDDDDD'";
      ncsDN_sDisplay.append( NcsUtil.CRLF + "<table size='100%' border='0' " + NcsUtil.css_data_table + ">" + NcsUtil.CRLF );

      ncsDN_sDisplay.append( "<tr " + NcsUtil.css_data_th + sBgColor2 + ">" );
      if (( ncsDN_bSequenceNr )&& ( al.size()>1 )) ncsDN_sDisplay.append( "<th>&nbsp;</th>" );
      for ( int iAttr=0; iAttr<ncsDN_saDisplayAttr.length; iAttr++ )
      {
         String sAttrDisplayName = ncsDN_prop.getProperty( "Attribute." + ncsDN_saDisplayAttr[iAttr], ncsDN_saDisplayAttr[iAttr] );
         ncsDN_sDisplay.append( "<th>" + sAttrDisplayName + "</th>" );
         ncsDN_alHead.add( sAttrDisplayName );
      }
      ncsDN_alData.add( ncsDN_alHead );
      ncsDN_sDisplay.append( "</tr>" + NcsUtil.CRLF );

      for ( int i=0; i<al.size(); i++ )
      {
         try
         {
            ArrayList ncsDN_alRow = new ArrayList();
            StringBuffer  sRow  = new StringBuffer(10);
            sRow.append( "<tr " + NcsUtil.css_data_tr + (( (i%2)==1 ) ? sBgColor1 : sBgColor0 ) + ">" );
            String        sDn   = al.get(i).toString();
            ObjectEntry   oe    = NcsUtil.getObjectEntryCatch( ncsCommon.getTree().getNs(), ncsCommon.getTree().getOe(), sDn );
            if (( ncsDN_bSequenceNr )&& ( al.size()>1 )) sRow.append( "<td>" + (i+1) + "</td>" );
            for ( int iAttr=0; iAttr<ncsDN_saDisplayAttr.length; iAttr++ )
            {
               String sTdAttrib    = "";
               if ( NcsUtilSchemaEdir.attr_CONTEXT.equalsIgnoreCase( ncsDN_saDisplayAttr[iAttr] )) sTdAttrib += " nowrap "; // prevent wrapping of container DNs
               String sAttrValue = NcsUtil.getAttrAsString( ncsCommon.getTree().getNs(), oe, ncsDN_saDisplayAttr[iAttr] );
               ncsDN_alRow.add( sAttrValue );
               sRow.append( "<td" + sTdAttrib + ">" + ( NcsUtil.stringEmpty( sAttrValue ) ? "&nbsp;" : sAttrValue ) + "</td>" );
            }

            if (( ncsDN_saTasks != null ) && ( ncsDN_saButtons != null ))
            {
               if ( ncsDN_saTasks.length != ncsDN_saButtons.length ) break;
               for ( int iTask=0; iTask<ncsDN_saTasks.length; iTask++ )
               {
                  if ( NcsUtil.stringEmpty( ncsDN_saTasks[iTask] )) continue;
                  String   sBtn  = NcsUtil.getButtonImg( request, ncsDN_saButtons[iTask], ncsDN_saButtons[iTask] );
                  String   sHref = NcsUtil.makeDelegationLaunchHref( ncsCommon.getTaskContext(), sDn, ncsDN_saTasks[iTask], "", sBtn, ncsDN_bLaunch );
                  sRow.append( "<td>" + sHref + "</td>" );
               }
            }

            sRow.append( "</tr>" + NcsUtil.CRLF );
            ncsDN_sDisplay.append( sRow.toString() );
            ncsDN_alData.add( ncsDN_alRow );
         }
         catch ( Exception e )
         {
            ncsDN_sDisplay.append( "<tr><td colspan='10'>" + e.getMessage() + "</td></tr>" + NcsUtil.CRLF );
         }
      }
      ncsDN_sDisplay.append( "</table><p>" + NcsUtil.CRLF );
      // save table as ArrayList of ArrayLists and store in session var "tempData"
      session.setAttribute( ncsDN_sParName, ncsDN_alData );
   }

%>
  
<td nowrap>

<% if ( ncsDN_bExport ) { %>
   <%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export.jsp" %>
<% } %>

