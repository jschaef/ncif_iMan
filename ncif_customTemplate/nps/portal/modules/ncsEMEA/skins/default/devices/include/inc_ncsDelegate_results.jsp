<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsDelegate_results.jsp" --%>
<%-- used in task_ncsDelegate --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<%
  String    sDelegateJs = "";
  if ( xml_searchOS ) {  // do we simply replace the OS screen by a very similar one (to allow setting OS variables)
%>
  <form name=form method=post>
    <table>
      <tr valign=middle>
          <TD colspan='9'>&nbsp;<%= ncsUtilSearch.searchProperties.getProperty( "colHead.searchBase" ) %>:
          </TD>
      </TR>
      <TR>
          <TD>
             <INPUT type=text name="<%= ncsUtilSearch.req_SearchBase_E_Name %>" value="<%= ncsUtilSearch.req_SearchBase_E %>" size="<%= c.string("UI.textboxSize") %>" style="width:<%= c.string("UI.textboxPixel") %>" >
              <% 
                c.set("OS.Control",         ncsUtilSearch.req_SearchBase_E_Name);
                c.set("OS.History", "true"); 
                c.set("OS.SearchSubContainers",      String.valueOf( xml_searchRecurse ));
                if ( NcsUtil.stringNotEmpty( xml_searchClass )) c.set("OS.TypeFilter",      xml_searchClass );
                if ( NcsUtil.stringNotEmpty( xml_searchBase ))  c.set("OS.InitialContext",  xml_searchBase );
                if ( NcsUtil.stringNotEmpty( xml_searchFilter ))c.set("OS.NameFilter",      xml_searchFilter );
              %>
             <jsp:include page='<%= c.getPath("dev/OS_inc.jsp") %>' flush="true" />
          </TD>
      </TR>
      <TR><TD height="8"></TD></TR>
     </TABLE>
     <br>
     <iman:cancelBtn/><iman:button key='OK' onClick="delegation();"/>
     <br><p>
     <iman:bar/>
         <script type='text/javascript'>
            function delegation()
            {
              var form=document.forms[0];
              var targetDn = getFieldValueByName( '<%= ncsUtilSearch.req_SearchBase_E_Name %>' );
              if ( targetDn != "" ) 
              {
                url = delegationUrl_String( targetDn, '<%= ncsUtilSearch.saTasks[0] %>', '<%= ncsUtilSearch.saPages[0] %>' );
                redirectFrame( url );
              }
            }
         </script>
  </form>
  <iman:osFooter/>

<% 
  } else { // do we perform a search and show results as URLs

  int       iElement    = ( ncsUtilSearch.bShowDN ? 0 : 1 );          // element in display (1=cn, 2=parent cn, 3=grand parent cn, .. 0=dn)
  ArrayList v           = NcsUtil.getObjectsAsArrayList( ncsCommon.getTree().getNs(), xml_searchBase, xml_searchClass, xml_searchFilter, xml_searchFilterExclude, xml_searchRecurse );
  iResults = v.size();
  
  if ( NcsUtil.stringEmpty( xml_parentControl ))
  { // full frame 
    ncsUtilSearch.sbDisplayData   = new StringBuffer( NcsUtil.arrayListToDelegate( ncsCommon.getTaskContext(), request, v, ncsCommon.getTree().getNs(), ncsUtilSearch.saAttrSearch, ncsUtilSearch.saTasks, ncsUtilSearch.saPages, ncsUtilSearch.saButtons, iElement, xml_launch, "TD" ));
    if (( v.size() == 1 ) && ( ncsUtilSearch.sbDisplayData.toString().indexOf( "IMG" )<0 ) && ( NcsUtil.stringNotEmpty( ncsUtilSearch.saTasks[0] ))) // one object found, no buttons
    {
      sDelegateJs = NcsUtil.makeDelegationUrl( ncsCommon.getTaskContext(), v.get(0).toString(), ncsUtilSearch.saTasks[0], ncsUtilSearch.saPages[0], xml_launch, true );
    }
  }
  else // pass results back to calling custom object selector
    ncsUtilSearch.sbDisplayData   = new StringBuffer( ncsUtilSearch.arrayListToSelector( ncsCommon.getTaskContext(), request, v, ncsCommon.getTree().getNs(), ncsUtilSearch.saAttrSearch, xml_parentControl, iElement, "TD" ));

  StringBuffer sTableHeader = new StringBuffer( NcsUtil.CRLF );;
  sTableHeader.append( NcsUtil.htmlTagged( "TH", "align=left", "" ));
  if (( v.size() > 0 ) && ( ncsUtilSearch.saAttrSearch.length > 0 ))
  {
    for( int j=0; j<ncsUtilSearch.saAttrSearch.length; j++ )
    {
      String sAttrDisplay = "";
      if ( NcsUtil.stringNotEmpty( ncsUtilSearch.saAttrSearch[j] ))
        sAttrDisplay = ncsUtilSearch.searchProperties.getProperty( "Attribute." + ncsUtilSearch.saAttrSearch[j] );
      // if ( ncsUtilSearch.bDebug ) logger.debug( String.valueOf( j ) + ": " + ncsUtilSearch.saAttrSearch[j] + "/" + sAttrDisplay );
      sTableHeader.append( NcsUtil.htmlTagged( "TH", "align=left", sAttrDisplay ));
    }
  }
%>

<%-- generate link list for generated object list --%>

  <%= sDelegateJs %>

   <table cellpadding='3' width='100%' border='0'>
      <tr bgcolor='#DDDDDD'><TH colspan='20' align='left' width='10%'><%= ncsUtilSearch.searchProperties.getProperty( "info.hitCount" ) %>:  <%= String.valueOf( iResults ) %> &nbsp;</TH> </tr>
      <tr><td height='12'></td></tr>
      <tr> <%= sTableHeader.toString() %> </tr>
      <%= ncsUtilSearch.sbDisplayData.toString() %>
    </table>   
    <p>
    <iman:bar/>

<% } %>
