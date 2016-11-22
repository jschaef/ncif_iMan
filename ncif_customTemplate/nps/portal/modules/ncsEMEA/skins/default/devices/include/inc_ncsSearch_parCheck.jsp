<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_parCheck.jsp" --%>
<%-- used in ncs_Search & ncs_Delegate - e.g., called in inc_ncsSearch_searchMask.jsp  --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_parCheck.jsp start -->
<%

	// sanity check
	if ( NcsUtil.stringEmpty( xml_searchAttr )) xml_searchOnStart = true;

	// force starting with SSL?
	if ( xml_useSSL ) ncsUtilLdap.setUseSSL( true );

	// interprete the xml parameters ...
	boolean bSelectorPopup                          = ( NcsUtil.stringNotEmpty( xml_parentControl ));

	// request var to store number of groups
	int    req_searchGroups_Value                   = NcsUtilHtml.getRequestAttribute_asInt( request, ncsUtilSearch.req_searchGroups_Name,   xml_searchGroups );
	ncsUtilSearch.req_DelGrp_Value                  = NcsUtilHtml.getRequestAttribute_asInt( request, ncsUtilSearch.req_DelGrp_Name,         ncsUtilSearch.IGNORE_THIS );       // store group delete request
	ncsUtilSearch.req_DelLine_Value                 = NcsUtilHtml.getRequestAttribute_asInt( request, ncsUtilSearch.req_DelLine_Name,        ncsUtilSearch.IGNORE_THIS );       // store line delete request

	// request vars ... action
	String req_Option_Value                         = NcsUtilHtml.getRequestAttribute(       request, ncsUtilSearch.req_Option_Name,         "" );  // store requested action

	// request vars ... search base
	ncsUtilSearch.req_SearchBase_E                  = NcsUtilHtml.getRequestAttribute( request,  ncsUtilSearch.req_SearchBase_E_Name, xml_searchBase ); 
	ncsUtilSearch.req_SearchBase_E                  = NcsUtilBasics.stringCutAfterString( ncsUtilSearch.req_SearchBase_E, "!" ); // remove comments
	ncsUtilSearch.req_SearchBase_L                  = NcsUtilHtml.getRequestAttribute( request,  ncsUtilSearch.req_SearchBase_L_Name, "" ); 
	ncsUtilSearch.req_SearchBase_L                  = NcsUtilBasics.stringCutAfterString( ncsUtilSearch.req_SearchBase_L, "!" ); // remove comments

	ncsUtilSearch.req_maxResults                    = NcsUtilHtml.getRequestAttribute( request, ncsUtilSearch.req_maxResults_Name, xml_maxResults ); 
	if ( ncsUtilSearch.bDebug )  logger.debug( "ncsUtilSearch.req_maxResults=" + ncsUtilSearch.req_maxResults );

	// remove types
	if ( NcsUtil.stringNotEmpty( ncsUtilSearch.req_SearchBase_L )) 
	{ // if we only have one base, add to history

		if ( ncsUtilSearch.req_SearchBase_L.indexOf( "|" )<0 ) 
			ncsUtilSearch.req_SearchBase_L =  NcsUtil.getTypedName( ncsCommon.getTree().getNs(), NcsUtil.getUntypedName( ncsUtilSearch.req_SearchBase_L ), false );
		if ( ncsUtilSearch.req_SearchBase_E.indexOf( "|" )<0 ) 
		{
			ncsUtilSearch.req_SearchBase_E =  NcsUtil.getTypedName( ncsCommon.getTree().getNs(), NcsUtil.getUntypedName( ncsUtilSearch.req_SearchBase_E ), true );
			NcsUtil.historyAddItem( ncsCommon.getTaskContext(), ncsCommon.getTree().getNs(), ncsUtilSearch.req_SearchBase_E );
		}
	}

	if ( NcsUtil.stringEmpty( ncsUtilSearch.req_SearchBase_L ))    ncsUtilSearch.req_SearchBase_L = ( ncsUtilSearch.alSearchBase.size() == 0 ? "" : ncsUtilSearch.alSearchBase.get(0).toString() );
	// out.println( "3c - ncsUtilSearch.req_SearchBase_E=" + ncsUtilSearch.req_SearchBase_E + " / ncsUtilSearch.req_SearchBase_L=" + ncsUtilSearch.req_SearchBase_L + "<br>"); 

	ncsUtilSearch.saTasks										= xml_sharedTask.split( ncsUtilSearch.parSeparator );
	ncsUtilSearch.saPages										= xml_sharedPageId.split( ncsUtilSearch.parSeparator );
	ncsUtilSearch.saButtons										= xml_sharedTaskButton.split( ncsUtilSearch.parSeparator );
	ncsUtilSearch.saAttrSearch									= xml_searchAttr.split( ncsUtilSearch.parSeparator ); 
	ncsUtilSearch.saAttrDisplay								= xml_displayAttr.split( ncsUtilSearch.parSeparator ); 
	ncsUtilSearch.saAttrDisplay2								= ( NcsUtil.stringNotEmpty( xml_level2_displayAttr ) ? xml_level2_displayAttr.split( ncsUtilSearch.parSeparator ) : new String[] {} );
	ncsUtilSearch.sLevel2_displayFormat						= xml_level2_displayFormat;

	ncsUtilSearch.bShowObject1									= ncsUtilSearch.saAttrDisplay.length > 0; 
	ncsUtilSearch.bShowObject2									= ncsUtilSearch.saAttrDisplay2.length > 0; 

	// out.println(  "parCheck.xml_searchBase=" + xml_searchBase  + "<br>" );
	// clear ncsUtilSearch.alSearchBase and reset from XML
	ncsUtilSearch.alSearchBase									= new ArrayList();
	if ( NcsUtil.stringNotEmpty( xml_searchBase ))
				  ncsUtilSearch.alSearchBase					= NcsUtil.arrayToArrayList( xml_searchBase.split( ncsUtilSearch.parSeparator ) );

	ncsUtilSearch.searchProperties							= new NcsProperties( "/" + xml_searchProperties, request );

	// some of the vars may reference keys, not just plain text ...
	xml_textBeforeMask											= ncsUtilSearch.searchProperties.getProperty( xml_textBeforeMask,     "" ); 
	xml_textAfterMask												= ncsUtilSearch.searchProperties.getProperty( xml_textAfterMask      ); 
	xml_textBeforeResults										= ncsUtilSearch.searchProperties.getProperty( xml_textBeforeResults  ); 
	xml_textAfterResults											= ncsUtilSearch.searchProperties.getProperty( xml_textAfterResults   ); 

	// define operators and ldap syntax
	ncsUtilSearch.sa2OperAttr									=	ncsUtilSearch.getOperators( xml_searchOperatorAllowed );
	ncsUtilSearch.sa2OperAttr									=  ncsUtilSearch.getLocalizedText( ncsUtilSearch.sa2OperAttr,		"Operator.",  ncsUtilSearch.searchProperties );

	// get localized strings for the internal array sa2OperGroup (operator to combine search groups)
	ncsUtilSearch.sa2OperGroup									=  ncsUtilSearch.getLocalizedText( ncsUtilSearch.sa2OperGroup,	"Operator.",  ncsUtilSearch.searchProperties );

	// get list of attributes for search and their local translations
	ncsUtilSearch.sa2AttrSearch								=	ncsUtilSearch.getArray( xml_searchAttr );      // attributes read from xml
	ncsUtilSearch.sa2AttrSearch								=  ncsUtilSearch.getLocalizedText( ncsUtilSearch.sa2AttrSearch,	"Attribute.", ncsUtilSearch.searchProperties );

	ncsUtilSearch.sa2AttrDisplay								=	ncsUtilSearch.getArray( xml_displayAttr );      // attributes show from xml
	ncsUtilSearch.sa2AttrDisplay								=  ncsUtilSearch.getLocalizedText( ncsUtilSearch.sa2AttrDisplay,	"Attribute.", ncsUtilSearch.searchProperties );
  
			  
	// 2012-01 backward comp - xml_fullName is now string, was boolean
	ncsUtilSearch.bShowDN	= ( xml_fullName.equalsIgnoreCase( "DN" ) || xml_fullName.equalsIgnoreCase( "true" ));
	ncsUtilSearch.bShowCN	= ( xml_fullName.equalsIgnoreCase( "CN" ) || xml_fullName.equalsIgnoreCase( "false" ));

	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_ATTR_SEARCH,						ncsUtilSearch.sa2AttrSearch	);
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_ATTR_DISPLAY,						ncsUtilSearch.sa2AttrDisplay	);
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_OPER_SEARCH,						ncsUtilSearch.sa2OperAttr	);

	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_SHOW_CN,							ncsUtilSearch.bShowCN	);
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_SHOW_DN,							ncsUtilSearch.bShowDN	);

	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchAllowChange,			xml_searchAllowChange );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchRecurse,				xml_searchRecurse );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_useSSL,						xml_useSSL );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchOS,						xml_searchOS );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_fullName,						xml_fullName );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_launch,						xml_launch );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_displayAuto,					xml_displayAuto );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_displayCompact,				xml_displayCompact );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_displayExport,				xml_displayExport );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_multiSelect,					xml_multiSelect );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchOnStart,				xml_searchOnStart );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_customReport,				xml_customReport );

	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_sharedTask,					xml_sharedTask ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_sharedPageId,				xml_sharedPageId ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_sharedTaskButton,			xml_sharedTaskButton  ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchBase,					xml_searchBase ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchClass,					xml_searchClass ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchAttr,					xml_searchAttr ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchOperatorDefault,	xml_searchOperatorDefault ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchOperatorAllowed,	xml_searchOperatorAllowed ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchProperties,			xml_searchProperties ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchFilter,				xml_searchFilter ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_searchFilterExclude,		xml_searchFilterExclude ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_displayAttr,					xml_displayAttr ); 
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_parentControl,				xml_parentControl );
	ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_callback,						xml_callback ); 
	//ncsUtilSearch.setOption( NcsUtilSearch.OPTION_xml_columnOne,					xml_columnOne );
  
%>

<%
  if ( bSelectorPopup ) {
    ncsUtilSearch.bShowExportOptions = false;
%>
   <script type='text/javascript'>
      function returnValue( sDN )
      {
         try
         {
           opener.document.getElementsByName( "<%= xml_parentControl %>" )[0].value = sDN;
           <% // do we have a callback (passed in launchUrlDirect/xxx_launchSelector)?
            if ( NcsUtil.stringNotEmpty( xml_callback ) ) 
            { 
              String sControlName = xml_parentControl;
              if ( sControlName.startsWith( "_" )) sControlName = NcsUtil.stringCutBeforeString( sControlName, "_" );
              out.println( "opener." + xml_callback + "( '" + sControlName +"', sDN );" );
            }
           %>
         }
         catch(e)
         {
           alert ( e );
         }
         window.close();
      }
   </script>
<% } %>

<%-- carry over parameters into next jsp --%> 
<c:forEach var="arCarryOver" items="${arCarryOver}"><c:out value="${arCarryOver}" escapeXml="false" /></c:forEach>

<!-- inc_ncsSearch_parCheck.jsp end -->
<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_debugVars.jsp" --%>
<%-- ------------------------------------------------------------------------------------------------- --%>


