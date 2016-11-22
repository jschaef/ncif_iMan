<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_searchResults.jsp" --%>
<%-- used in ncs_Search --%>
<%-- -------------------------------------------------------------------------------------------------
	// in FireFox 3.5: check "Tools"/"Options"/"Applications"
--%><!-- inc_ncsSearch_searchResults.jsp start --><%
  out.flush();
  ncsUtilSearch.sCurrentTask				= ncsUtilSearch.searchProperties.getProperty( ncs_thisTaskId );
	ncsUtilSearch.iAttrSize1				= ncsUtilSearch.saAttrDisplay.length;
	ncsUtilSearch.iAttrSize2				= ncsUtilSearch.saAttrDisplay2.length;
  if ( !ncsUtilSearch.bShowCN )         ncsUtilSearch.iAttrSize1 -= 1;
    else                  ncsUtilSearch.iAttrSize1 += 1;
  ncsUtilSearch.iAttrSizeMax				= ( ncsUtilSearch.iAttrSize1<ncsUtilSearch.iAttrSize2 ? ncsUtilSearch.iAttrSize2 : ncsUtilSearch.iAttrSize1 );

   boolean bShowResults						= ( req_Option_Value.equalsIgnoreCase( NcsUtilSearch.sOptionSearch ) || xml_searchOnStart );
   if ( bShowResults )
   {
      if ( !ncsUtilSearch.bShowObject1 ) ncsUtilSearch.bShowHeader1 = false;
      if ( !ncsUtilSearch.bShowObject2 ) ncsUtilSearch.bShowHeader2 = false;
      if ( ( !ncsUtilSearch.bShowHeader1 ) && ( ncsUtilSearch.bShowHeader2 )) // if header #1 is not shown, display header #2 in style of header #1
         ncsUtilSearch.css_data_th2		= " class='css_data_th1'"; // css_data_th1;
      else
         ncsUtilSearch.css_data_th2		= " class='css_data_th2'"; // css_data_th1;

      ncsUtilSearch.sSearchFilter         = ncsUtilSearch.calculateSearchFilter( req_searchGroups_Value );

      // clear old data ...
      session.removeAttribute( NcsUtil.sTempVar );
      NcsUtil.garbageCollection( 40000000 );

      // xml_searchClass can be object type (e.g., "user") or set ldap filter (e.g., "(objectClass=inetOrgPerson)")
      String sObjectClassFilter = xml_searchClass;
      if ( ncsUtilSearch.bDebug )  logger.info( "inc_ncsSearch_searchResults - sObjectClassFilter:  " + sObjectClassFilter );
      if ( NcsUtil.stringNotEmpty( sObjectClassFilter ))
      {
         if ( sObjectClassFilter.indexOf( "=" ) < 0 ) // set ldap filter ? treat parameter as class name
            sObjectClassFilter = "(objectClass=" + xml_searchClass + ")"; // object type, make it a filter
          ncsUtilSearch.sSearchFilter         = HelperLdap.ldapAddFilterElement( sObjectClassFilter, ncsUtilSearch.sSearchFilter, "&" );
      }

      if ( ncsUtilSearch.sSearchFilter.length() > 0 )
      {
         if ( xml_customReport )
         { // if we allow custom attribute lists, remove the unchecked display attribute
            //ncsUtilSearch.saAttrDisplay	= ncsUtilSearch.getCheckedDisplayAttr( ncsUtilSearch.saAttrDisplay );
            //ncsUtilSearch.saAttrLocal		= ncsUtilSearch.getLocalizedText( ncsUtilSearch.saAttrDisplay,  "Attribute.", ncsUtilSearch.searchProperties );   // level 1 display attr			
				ncsUtilSearch.clearUncheckedAttr( );
				//ncsUtilSearch.saAttrDisplay		= ncsUtilSearch.getSelectedAttr( 1 );
				//ncsUtilSearch.saAttrLocal		= ncsUtilSearch.getSelectedAttr( 2 );
         }
         // generate table headers
         ncsUtilSearch.sHeader1				= ncsUtilSearch.makeHeader1(    ncsUtilSearch.saAttrLocal );
         ncsUtilSearch.alHeader1 			= ncsUtilSearch.makeHeaderAL1(  ncsUtilSearch.saAttrLocal );
         ncsUtilSearch.sHeader2   			= ncsUtilSearch.makeHeader2(    ncsUtilSearch.saAttrLocal2 );
         ncsUtilSearch.alHeader2  			= ncsUtilSearch.makeHeaderAL2(  ncsUtilSearch.saAttrLocal2 );

         boolean bSearchSubTree				= xml_searchRecurse; // true;
         
         // we have an edir base, but no ldap base, yet
         if ( NcsUtilBasics.stringEmpty( ncsUtilSearch.req_SearchBase_L ) && NcsUtilBasics.stringNotEmpty( ncsUtilSearch.req_SearchBase_E ) )
         {
           ncsUtilSearch.req_SearchBase_L = NcsUtil.getTypedNameLdap( ncsCommon.getTree().getNs(), ncsUtilSearch.req_SearchBase_E );
         }

         try
         {
            ncsUtilSearch.bShowExportOptions    = false;
            if ( ncsUtilSearch.bDebug ) 
            {
              logger.info( "ldapSearch base=" + ncsUtilSearch.req_SearchBase_L + " filter=" + ncsUtilSearch.sSearchFilter );
              logger.info( "ldapSearch getServerAddress=" + ncsUtilLdap.getServerAddress() + 
                      "|getServerPort=" + ncsUtilLdap.getServerPort()+ 
                      "|getUserName=" + ncsUtilLdap.getUserName() + 
                     // "|getUserPwd=" + ncsUtilLdap.getUserPwd() +
                      "|getUseSSL=" + String.valueOf( ncsUtilLdap.getUseSSL() ));
            }
            int iMaxResults = NcsFormat.strToInt( ncsUtilSearch.req_maxResults, 0 ); // 100 );
            
            //ArrayList al = NcsUtilLdap.ldapSearchToArrayList( ncsUtilLdap, ncsUtilSearch.req_SearchBase_L, ncsUtilSearch.sSearchFilter, ncsUtilSearch.saAttrDisplay, bSearchSubTree, true, iMaxResults, null, NcsUtilLdap.sDefaultAttributeSeparator );
				ArrayList al = HelperLdap.ldapSearchToArrayList( ncsUtilLdap.getServerAddress(), ncsUtilLdap.getUserName(), ncsUtilLdap.getUserPwd(), 
				  ncsUtilSearch.req_SearchBase_L, ncsUtilSearch.sSearchFilter, ncsUtilSearch.clearComments( ncsUtilSearch.saAttrDisplay ), bSearchSubTree, true, true, iMaxResults, null, HelperLdap.sDefaultAttributeSeparator );
            if ( al != null )
            {
               if ( al.size() > 0 )
               {
						// convert the ldap search results into HTML display
                  NcsUtil.arrayListSort( al );
                  if ( bSelectorPopup )
                     ncsUtilSearch.sbDisplayData = new StringBuffer( ncsUtilSearch.ldapArraylistToSelector( al, ncsUtilSearch.searchProperties, xml_parentControl, ncsUtilSearch.saAttrLocal ));
                  else
                     ncsUtilSearch.sbDisplayData = new StringBuffer( ncsUtilSearch.ldapArraylistDelegate( ncsCommon.getTree().getOe(), ncsCommon.getTaskContext(), al, ncsUtilSearch.searchProperties, xml_level2_searchAttr, ncsUtilSearch.saAttrDisplay2, ncsUtilSearch.saAttrLocal2  ));
               }
               iResults    = al.size();
               ncsUtilSearch.bShowExportOptions = ( al.size()>0 );
               al = null;
            }
            //logger.debug( ncsUtilSearch.sSearchFilter + " - " + getServletContext().getRealPath("") +  " - " + HelperLdap.getCacertsPath() );
         }
         catch ( OutOfMemoryError e)
         {
            logger.error( "inc_ncsSearch_searchResults OutOfMemoryError - " + e.getMessage(), e );
            %><script type='text/javascript'>alert( '<%= ncsUtilSearch.searchProperties.getProperty( "search.error.OutOfMemoryError" ) %>' );</script><%
         }
         catch (Exception e)
         {
            String msg = "Error performing search: " + HelperBasics.getExceptionDetails( e ); // " connecting to " +   ncsUtilLdap.getServerAddress()

				if ( msg.indexOf( "SSL" ) > 0 ) msg += "<br>" + "Check server certificate in " + HelperLdap.getCacertsPath();
				String sDebugInfo = NcsLdapId.getDebugInformation( request );
				msg += "  <font onclick='alert( \"" + sDebugInfo + "\" );'>" + "[debug]" + "</font>";
				logger.error( msg + "; " + e );
				logger.error( sDebugInfo );
				if ( ncsUtilSearch.bDebug ) logger.info( e );
				if ( ncsUtilSearch.bDebug ) logger.info( sDebugInfo );
				if ( ncsUtilSearch.bDebug ) logger.info( HelperBasics.VERSION );
				if ( ncsUtilSearch.bDebug ) logger.info( HelperLdap.VERSION );

				ncsUtilSearch.sbDisplayData.append( msg );
         }
      }
		// wrap the html results in table row
   ncsUtilSearch.sbDisplayData.insert( 0, "<tr " + ncsUtilSearch.css_data_tr + "><td colspan='2'>" );
   ncsUtilSearch.sbDisplayData.append( "</td></tr>" );

   // save custom selection to cookies
   out.flush();
%>
<%= ncsUtilSearch.setCookies() %>

<%-- ------------------------------------------------------------------------------------------------- --%>
<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_resultsDisplay.jsp" %>
<%-- ------------------------------------------------------------------------------------------------- --%>
    
<% } %>
   
<%--
	<table border="1" cellpadding="1">
		<tr>	<td>	<b>requestScope:</b>	</td>	</tr>
		<c:forEach var="rs" items="${requestScope}">
		<tr>	<td>	<c:out value="${rs}"/>	</td>	</tr>
		</c:forEach>
	</table>

	<%= HelperHtml.showCookies( request ) %>
--%>
<!-- inc_ncsSearch_searchResults.jsp end -->
