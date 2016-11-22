<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_getPar.jsp" --%>
<%-- used in ncs_Search & ncs_Delegate  --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<%--

task to generate a list of objects with delegation feature


ncs_Search   use xml declaration like ...

<task>
    <id>task_SearchCarLicenseView</id>
    <order>92</order>
    <version>2.0.0</version>
    <required-version>2.0.0</required-version>
    <class-name>com.novell.emframe.dev.EmptyTask</class-name>
    <merge-template>ncsEMEA.task_ncsSearch</merge-template> 
    <error-template>dev.GenFatal</error-template> 
    <resource-properties-file>com.novell.ncs.resources</resource-properties-file>
    <display-name-key>ncs.task_SearchCarLicenseView</display-name-key>
    <description-key>ncs.task_SearchCarLicenseView</description-key>
    <role-assignment>role_CarLicenseView</role-assignment>
    <role-assignment>role_CarLicenseEdit</role-assignment>
    <url-param>
        <param-key>sharedTask</param-key>
        <param-value>ncs.shared_book_CarLicenseView</param-value>
    </url-param>
    <url-param>
        <param-key>sharedPageId</param-key>
        <param-value>ncs.page_User_EditCarLicense</param-value>
    </url-param>
    <url-param>
        <param-key>searchBase</param-key>
        <param-value>o=xyz|ou=abc,o=def</param-value>
    </url-param>
    <url-param>
        <param-key>useSSL</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>searchClass</param-key>
        <param-value>inetOrgPerson</param-value>
    </url-param>
    <url-param>
        <param-key>searchProperties</param-key>
        <param-value>com/novell/ncs/search.properties</param-value>
    </url-param>
    <url-param>
        <param-key>searchOperatorAllowed</param-key>
        <param-value>equals|exists|existsNot|beginsWith|contains|similar|less|lessEqual|greater|greaterEqual|endsWith|isTrue|isFalse</param-value>
    </url-param>
    <url-param>
        <param-key>searchAttr</param-key>
        <param-value>givenname|sn|l|ou|carLicense</param-value>
    </url-param>
    <url-param>
        <param-key>searchOperatorDefault</param-key>
        <param-value>beginsWith|beginsWith|contains|contains|contains</param-value>
    </url-param>
    <url-param>
        <param-key>searchRecurse</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>displayAttr</param-key>
        <param-value>givenname|sn|l|ou|carLicense|TelephoneNumber</param-value>
    </url-param>
<optional>
    <url-param>
        <param-key>maxResults</param-key>
        <param-value>100</param-value>
    </url-param>
    <url-param>
        <param-key>customReport</param-key>
        <param-value>false</param-value>
    </url-param>
    <url-param>
        <param-key>parentControl</param-key>
        <param-value>form.myInput</param-value>
    </url-param>
    <url-param>
        <param-key>sharedTaskButton</param-key>
        <param-value>Edit</param-value>
    </url-param>
    <url-param>
        <param-key>displayCompact</param-key>
        <param-value>false</param-value>
    </url-param>
    <url-param>
        <param-key>displayAuto</param-key>
        <param-value>false</param-value>
    </url-param>
    <url-param>
        <param-key>searchType</param-key>
        <param-value>ldap</param-value>
    </url-param>
    <url-param>
        <param-key>searchGroups</param-key>
        <param-value>1</param-value>
    </url-param>
    <url-param>
        <param-key>searchLines</param-key>
        <param-value>3</param-value>
    </url-param>
    <url-param>
        <param-key>searchAllowChange</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>displayExport</param-key>
        <param-value>false</param-value>
    </url-param> 
    <url-param>
        <param-key>exportCsvQuoteCharacter</param-key>
        <param-value>"</param-value>
    </url-param> 
    <url-param>
        <param-key>fullName</param-key>
        <param-value>false</param-value>
    </url-param>
    <url-param>
        <param-key>launch</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>level2_searchAttr</param-key>
        <param-value>assistant</param-value>
    </url-param>
    <url-param>
        <param-key>level2_displayAttr</param-key>
        <param-value>CN|Given Name|Surname</param-value>
    </url-param>
    <url-param>
        <param-key>level2_displayFormat</param-key>
        <param-value>compact</param-value>
    </url-param>
    <url-param>
        <param-key>multiSelect</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>searchOnStart</param-key>
        <param-value>true</param-value>
    </url-param>
    <url-param>
        <param-key>textBeforeMask</param-key>
        <param-value>msg.myText1</param-value>
    </url-param>
    <url-param>
        <param-key>textAfterMask</param-key>
        <param-value>msg.myText2</param-value>
    </url-param>
    <url-param>
        <param-key>textBeforeResults</param-key>
        <param-value>msg.myText3</param-value>
    </url-param>
    <url-param>
        <param-key>textAfterResults</param-key>
        <param-value>msg.myText4</param-value>
    </url-param>
    <url-param>
        <param-key>textBeforeCustomAttr</param-key>
        <param-value></param-value>
    </url-param>
    </optional>   
</task>


ncs_Delegate:   use xml declaration like ...

  <task>
      <id>task_ncsDelegate</id>
      <version>2.0.0</version>
      <required-version>2.0.0</required-version>
      <class-name>com.novell.emframe.dev.EmptyTask</class-name>
      <merge-template>ncsEMEA.task_ncsDelegate</merge-template> 
      <display-name-key>task_ncsDelegate</display-name-key>
      <description-key>task_ncsDelegate</description-key>
      <resource-properties-file>com.novell.ncsEMEA.resources</resource-properties-file>
      <role-assignment>roles_ncsTestRole</role-assignment>
      <url-param>
          <param-key>parentControl</param-key>
          <param-value>form.myInput</param-value>
      </url-param>
      <url-param>
          <param-key>sharedTask</param-key>
          <param-value>fw.ModifyObject,shared_task_ncsEMEADeleteObjects,ncsDemo_shared_task_Ldif</param-value>
      </url-param>
      <url-param>
          <param-key>sharedTaskButton</param-key>
          <param-value>,btndelete,btnexport</param-value>
      </url-param>
      <url-param>
          <param-key>sharedPageId</param-key>
          <param-value></param-value>
      </url-param>
      <url-param>
          <param-key>searchBase</param-key>
          <param-value>novell</param-value>
      </url-param>
    <url-param>
        <param-key>searchOS</param-key>
        <param-value>false>/param-value>
    </url-param>
      <url-param>
          <param-key>searchClass</param-key>
          <param-value>User</param-value>
      </url-param>
      <url-param>
          <param-key>searchFilter</param-key>
          <param-value></param-value>
      </url-param>
      <url-param>
          <param-key>searchFilterExclude</param-key>
          <param-value></param-value>
      </url-param>
      <url-param>
          <param-key>searchRecurse</param-key>
          <param-value>true</param-value>
      </url-param>
      <url-param>
          <param-key>fullName</param-key>
          <param-value>true</param-value>
      </url-param>
      <url-param>
          <param-key>launch</param-key>
          <param-value>false</param-value>
      </url-param>
      <url-param>
          <param-key>displayFormat</param-key>
          <param-value>TD</param-value>
      </url-param>
      <url-param>
          <param-key>displayKeyTitle</param-key>
          <param-value></param-value>
      </url-param>
      <url-param>
          <param-key>displayAttr</param-key>
          <param-value>Given Name,Surname,Description</param-value>
      </url-param>
      <url-param>
          <param-key>displayAuto</param-key>
          <param-value>false</param-value>
      </url-param>
  </task>


--%>
<%-- ------------------------------------------------------------------------------------------------- --%>

<%--

Description:

In lists with multiple options, options are separated by "|"

parentControl
  Purpose:  If used as replacement for Object Selector, form variable that receives the selected name
  Default:  ""
  Examples: form._manager
  Notes:    normally use as alternative to button links (sharedTask)

sharedTask 
  Purpose:  "," separated list of tasks to call for the selected object
  Default:  ""
  Examples: ncs.shared_book_CarLicenseView

sharedPageId (for future use)
  Purpose:  "," separated list of default pages for the respective books (if sharedTask refers to a book)
  Default:  ""
  Examples: ncs.page_User_EditCarLicense

sharedTaskButton (for future use)
  Purpose:  list of buttons for the respective tasks - the first task does not have a button
  Default:  -
  Examples: btnedit|btnrename
  Available Options: see available buttons in portal\modules\dev\images\[language]\

searchOS  (for delegation)
  Purpose:  Do not perform a search, but emulate the standard initial object selector (useful when setting searchBase)
  Default:  false
  Examples: true

searchBase (ldap notation for search, edir notation for delegation)
  Purpose: Base for the search, can be empty (to show an OS), one value (will be hidden) or multiple values (list box)
           Each element may contain a display name (appended with '!') - default: display=DN
  Default:  -
  Examples: o=Novell|ou=abc,o=def!ABC|ou=xyz,o=def

searchClass (ldap notation)
  Purpose:  Determine a base class for the search 
  Default:  -
  Examples: inetOrgPerson
            (objectClass=inetOrgPerson)
            <![CDATA[(&(objectClass=inetOrgPerson)(abc=xyz))]]>

searchType (for future use)
  Purpose:  
  Default:  ldap
  Examples: ldap

maxResults
  Purpose:  maximum Number of returned matches
  Default:  unlimited
  Examples: 100

searchGroups
  Purpose:  Number of search blocks to display initially
  Default:  1
  Examples: 1

searchLines
  Purpose:  Number of search lines to display in first initial search block
  Default:  1
  Examples: 3

searchAllowChange
  Purpose:  Allow user to change the search mask
  Default:  true
  Examples: false

searchProperties
  Purpose:  properties file with localized display texts
  Mandatory  
  Examples: com/novell/ncs/search.properties

searchOperatorAllowed
  Purpose:  list available operators for search
  Default:  -
  Examples: equals|exists
  Available Options: equals|exists|existsNot|beginsWith|contains|similar|less|lessEqual|greater|greaterEqual|endsWith|isTrue|isFalse

searchAttr (ldap notation)
  Purpose:  list of LDAP attributes to be available in search mask
				Comment in [..]:										[test]givenName				ignored in search, considered in getting localized name
  Default:  -
  Examples: givenname|sn|l|[user]ou|carLicense

searchOperatorDefault
  Purpose:  Default operator for the respective attribute (see searchAttr)
  Default:  
  Examples: beginsWith|beginsWith|contains|contains|contains

searchRecurse
  Purpose:  search recursive or just selected container
  Default:  true
  Examples: false

useSSL
  Purpose:  default to SSL search, even if connection uses non-SSL, better check the SSL setting in iManager server config
  Default:  false
  Examples: true

displayAttr (ldap notation)
  Purpose:  Attributes to show in the results list; 'concatenated' attributes are allowed (e.g., 'manager:sn', 'manager:manager:sn')
				MV attributes allowed								groupMembership:CN
				Pseudo attributes:									CN, DN, CONTEXT/PARENT
				CONST expression instead of attribute:			[CONST:test this]				creates separate constant column
				Comment in [..]:										[test]givenName				ignored in search, considered in getting localized name/header
  Default:  -
  Examples: givenname|sn|l|ou|manager:CN|carLicense|TelephoneNumber


displayAttrTask
  Purpose:	launch a specific task for the selected attribute. E.g., clicking on the 'manager' column launches adifferent task than clicking on 'groupMembership' 
  Default:  -
  Examples: givenname|sn|l|ou|carLicense|TelephoneNumber


level2_searchAttr (edir notation)
  Purpose:  DN attribute for 2nd level search - leave away for one level reports
  Default:  -
  Examples: assistant

level2_displayAttr (edir notation)
  Purpose:  Attributes to show in the results list - leave away for one level reports
  Default:  -
  Examples: CN|Given Name|Surname
  
level2_displayFormat 
  Purpose:  if "compact", show level #2 display in same line as level #1; otherwise 2+ lines
  Values:   default (<empty>), compact
  Default:  -
  Examples: compact
  
displayCompact
  Purpose:  compact output puts the results under the search mask (vs into new screen)
  Default:  true
  Examples: false

displayAuto		deprecated
  Purpose:  automatically show target task if only 1 match found
  Default:  true
  Examples: false

displayExport
  Purpose:  show buttons to save/export/print results
  Default:  true
  Examples: false

exportCsvQuoteCharacter
  Purpose:  enclose individual values in CSV export
  Default:  "
  Examples: '
  
fullName
  Purpose:  display full DN vs short name
					if true/DN		the first report column is a DN link to sharedTask
					if false/CN		the first report column is a CN link to sharedTask
					if custom		the first column link is not used. You may use the "[TASK=sharedTask]" specifier to create links in other columns
  Default:  CN  // 2012-01: changed from "true"
  Values:   true|DN, false|CN, custom
  Examples: false

launch
  Purpose:  lauch the target task as new window (vs same frame)
  Default:  true
  Examples: false

multiSelect
  Purpose:  show the results with checkboxes and allow for multiple selection
  Default:  false
  Examples: true

searchOnStart
  Purpose:  show results when loading page
  Default:  false
  Examples: true
  
textBeforeMask
  Purpose:  show custom text over search mask
  Default:  <empty>
  Examples: msg.myText
  
textAfterMask
  Purpose:  show results when loading page
  Default:  false
  Examples: msg.myText
  
textBeforeResults
  Purpose:  show results when loading page
  Default:  false
  Examples: msg.myText
  
textAfterResults
  Purpose:  show results when loading page
  Default:  false
  Examples: msg.myText
  


example for OS button replacement:

   <!-- "ncsEMEA.shared_searchSelector" must be declared as shared task with std search settings -->
   <a href='#' onclick='manager_launchSelector( "ncsEMEA.shared_searchSelector", "&parentControl=_manager" );' >
   <img alt="Select Manager" title="Select Manager for <%= ncsCommon.getTarget().getCn() %>" src="/nps/portal/modules/dev/images/os.gif" border=0 align="absmiddle" ></a>

   <!-- settings defined there can be overwritten with "&" parameters -->
   e.g.,
   <a href='#' onclick='manager_launchSelector( "ncsEMEA.shared_searchSelector", "&searchBase=o=Novell|o=Org&searchClass=<%= com.novell.emframe.dev.eMFrameUtils.urlEncode( "(objectClass=organizationalPerson)" ) %>&parentControl=_manager" );' >
   <img alt="Select Manager" title="Select Manager for <%= ncsCommon.getTarget().getCn() %>" src="/nps/portal/modules/dev/images/os.gif" border=0 align="absmiddle" ></a>

   <!-- history button code -->
   <a href="#" onClick="javascript:doHist(this,'_manager','User','',''); return false">
   <img alt="Object History" title="Object History" src="/nps/portal/modules/dev/images/history.gif" border=0 align="absmiddle" ></a>
   <IFRAME src="/nps/Empty.html" style="visibility: hidden" name="exchangerFrame" id="exchangerFrame" width="0" height="0" marginwidth="0" marginheight="0"></IFRAME>
   <!-- end history button code -->

   <script type='text/javascript'>
     function manager_launchSelector( sSharedTask, sParam )
     {
       launchUrlDirect( "", sSharedTask, "", "Window", "width=800,height=500,location=no,dependent=yes,resizable=yes,menubar=no,scrollbars=yes", sParam );
     }
   </script>
                             


--%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_getPar.jsp start -->
<%
  int iDebug    = 0;
  int iResults  = 0;
  //
  // read custom parameters from XML ... 
  // store parameters in arCarryOver to pass to subsequent requests. 
  //   This is actually only needed, when parameters have been passed in URL (often with parentControl)
  //
  String xml_sharedTask             = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_sharedTask,					"",                arCarryOver, true ); 
  String xml_sharedPageId           = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_sharedPageId,				"",                arCarryOver, true ); 
  String xml_sharedTaskButton       = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_sharedTaskButton,			"",                arCarryOver, true ); 
  String xml_searchBase             = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchBase,					"",                arCarryOver, true ); 
  String xml_searchClass            = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchClass,				"",                arCarryOver, true ); 
  String xml_searchAttr             = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchAttr,					"",                arCarryOver, true ); 
  String xml_searchOperatorDefault  = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchOperatorDefault,	"beginsWith",      arCarryOver, true ); 
  String xml_searchOperatorAllowed  = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchOperatorAllowed,	"",                arCarryOver, true ); 
  String xml_searchProperties       = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchProperties,			"",                arCarryOver, true ); 
  String xml_searchFilter           = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchFilter,				"",                arCarryOver, true ); 
  String xml_searchFilterExclude    = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchFilterExclude,		"",                arCarryOver, true ); 
  String xml_displayAttr            = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_displayAttr,				"",                arCarryOver, true ); 
  String xml_parentControl          = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_parentControl,				"",                arCarryOver, true );
  String xml_callback               = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_callback,					"",                arCarryOver, true );  
  //String xml_columnOne              = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_columnOne,					"",                arCarryOver, true );	// CN|DN|custom (replace param "fullName")
  String xml_fullName					= NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_fullName,					"CN",              arCarryOver, true );

  String xml_textBeforeCustomAttr   = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_textBeforeCustomAttr,  "Display Attributes",      arCarryOver, true ); 
  String xml_textBeforeMask         = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_textBeforeMask,        "",                arCarryOver, true ); 
  String xml_textAfterMask          = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_textAfterMask,         "",                arCarryOver, true ); 
  String xml_textBeforeResults      = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_textBeforeResults,     "",                arCarryOver, true ); 
  String xml_textAfterResults       = NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_textAfterResults,      "",                arCarryOver, true ); 
  // some of the vars may reference keys, not just plain text - overwritten in parCheck.jsp ...

  // get the quote character for CSV export ... use ["] as default
  Object oExportCsvQuoteCharacter   = request.getAttribute( "exportCsvQuoteCharacter" );
  String sExportCsvQuoteCharacter;
  if ( null == oExportCsvQuoteCharacter )
     sExportCsvQuoteCharacter = "\\\"";                                                // nothing specified, use default ...
  else
     sExportCsvQuoteCharacter = oExportCsvQuoteCharacter.toString();
  if ( "\"".equals( sExportCsvQuoteCharacter )) sExportCsvQuoteCharacter = "\\\"";     // nothing specified, use default ...
  if ( "'".equals(  sExportCsvQuoteCharacter )) sExportCsvQuoteCharacter = "\\\'";     // nothing specified, use default ...

  // 2-level report - level2_searchAttr is a DN attribute, level2_displayAttr lists the 2nd level attributes 
  String xml_level2_searchAttr      = NcsUtilHtml.getRequestAttribute( request, "level2_searchAttr",     "",                arCarryOver, true ); 
  String xml_level2_displayAttr     = NcsUtilHtml.getRequestAttribute( request, "level2_displayAttr",    "",                arCarryOver, true ); 
  String xml_level2_displayFormat   = NcsUtilHtml.getRequestAttribute( request, "level2_displayFormat",  "",                arCarryOver, true ); 

//  int    xml_searchGroups           = NcsUtilHtml.getRequestAttribute_asInt(request, "searchGroups",          1 );
//  int    xml_searchLines            = NcsUtilHtml.getRequestAttribute_asInt(request, "searchLines",           1 );
  int		xml_searchGroups           = NcsUtilHtml.getRequestAttribute_asInt(request, NcsUtilSearch.OPTION_xml_searchGroups,          1 );
  int    xml_searchLines            = NcsUtilHtml.getRequestAttribute_asInt(request, NcsUtilSearch.OPTION_xml_searchLines,           1 );
  
  String xml_maxResults             = NcsUtilHtml.getRequestAttribute(      request, NcsUtilSearch.OPTION_xml_maxResults,       "",                arCarryOver, true ); 

  boolean xml_searchAllowChange     = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchAllowChange,  "true",                arCarryOver, true ));
  boolean xml_searchRecurse         = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchRecurse,      "true",                arCarryOver, true )); 
  boolean xml_useSSL                = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_useSSL,             "false",               arCarryOver, true ));
  boolean xml_searchOS              = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchOS,           "false",               arCarryOver, true ));
//boolean xml_fullName              = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_fullName,           "true",                arCarryOver, true )); 
  boolean xml_launch                = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_launch,             "true",                arCarryOver, true )); 
  boolean xml_displayAuto           = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_displayAuto,        "true",                arCarryOver, true )); 
  boolean xml_displayCompact        = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_displayCompact,     "true",                arCarryOver, true )); 
  boolean xml_displayExport         = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_displayExport,      "true",                arCarryOver, true )); 
  boolean xml_multiSelect           = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_multiSelect,        "false",               arCarryOver, true )); 
  boolean xml_searchOnStart         = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_searchOnStart,      "false",               arCarryOver, true )); 
  boolean xml_customReport          = "true".equalsIgnoreCase( NcsUtilHtml.getRequestAttribute( request, NcsUtilSearch.OPTION_xml_customReport,       "false",               arCarryOver, true )); 

  // store the carry over data into request
  request.setAttribute( "arCarryOver", arCarryOver );
%>
<!-- inc_ncsSearch_getPar.jsp end -->

