<%--
    // common java & jsp stuff used by Novell Consulting Services (NCS)
    // 
    // include into JSP with 
    // 	 <%@ include file="/portal/modules/ncsEMEA/include/helper.jsp"  %>
    //
    // Set Vars with 	
    //  <% NcsUtil.setRequestAttribute( request, "ncsTitle", "NCS Demo Title" ); %>
    //     
    //   <%
    //      ArrayList al = new ArrayList( );
    //      al.add( "aaa" ); al.add( "bbb" ); al.add( "ccc" );
    //      request.setAttribute( "myString",      al.get(0) );
    //      request.setAttribute( "myArrayList",   al );
    //   %>
    //
    //      Test 1:  <c:out value="${myString}"/>     <br>
    //      Test 2:  <c:out value="${myArrayList}"/>  <br>
    //      <c:forEach var="test" items="${myArrayList}">
    //         Test 3:  <c:out value="${test}"/>      <br>
    //      </c:forEach>
    //
    // Retrieve/Display eDas Vars with 	
    //  <x:out select="$myVar/."/>  // extract info from XML
    //	<c:out value="${myVar}"/>   // show as XML
    //  <iman:taskHeader title="${ncsTitle}"/>
    //	
    //	<c:out value="${requestScope['thisJsp']}"/>
    //	<c:out value="${requestScope['javax.servlet.include.request_uri']}"/>
    //	<%= request.getAttribute("javax.servlet.include.request_uri").toString()	%>	
    //			
    //	xpath x:if
    //	<x:if select="$edasXml/edas/myVar/value!='xxx'">yes</x:if>
    //	<x:if select="not($edasXml/edas/myVar/value='xxx')">no</x:if>
    //	<x:if select="($edasXml/edas/myVar/value='0') or (string-length($edasXml/edas/myVar/value)=0)">checked</x:if>
    //
    //  Get current page name:
    //     <h3> <%= request.getAttribute("javax.servlet.include.request_uri").toString() %> </h3>
    //
    //  Get current task/book name:
    //           <h4>     ncs_thisJspShort:  (<%=	ncs_thisJspShort	%>)   </h4>
    //           <h4>     ncs_thisJsp:       (<%=	ncs_thisJsp	%>)        </h4>
    //           <h4>     ncs_thisTask:      (<%=	ncs_thisTask	%>)       </h4>
    //
    //  Overwrite default attribute display name
    //      <% ncsUtil_xyz.useCustomDisplayName( "Surname" ); %>  
    // 
    // check attributes:  <c:if test="${eDir$target$company != ''}">DISABLED</c:if>
    //
    // using c:catch in jsp ...
        <c:catch var="e">
        ...
        </c:catch>
        <c:if test="${e!=null}">
           Exception:<c:out value="${e}" /> 
        </c:if>

        getting info for <fmt ...>
          <fmt:setLocale value="${ClientLocale}"/>
          <fmt:setBundle basename="DevResources"/>
           ... size='<fmt:message key="UI.textboxSize"/>' 
          
         <fmt:setBundle basename="de/xyz/imanager/resources" var="xyz" />
         ... <fmt:message key="Attribute.personalTitle" bundle="${xyz}" /> 
          
--%>
<%@page import="com.novell.webaccess.common.JSPConduit,
                com.novell.admin.ns.*,
                com.novell.admin.ns.nds.*,
                com.novell.admin.ns.nds.jclient.*,
                com.novell.admin.ns.SchemaDefinition.*,
                com.novell.application.console.snapin.*,
                com.novell.emframe.dev.*,
                com.novell.nps.sessionManager.*,
                java.util.*,
                org.apache.log4j.Logger,
                com.novell.ncs.lib.general.*,
                com.novell.ncs.lib.nldap.*,
                com.novell.ncsEMEA.util.*" %>
<%@include file="/portal/modules/ncsEMEA/include/ncsAttrInfo.jsp"  %>
<fmt:setBundle var="fw"   basename="FwResources"/>   <%-- <fmt:message key="myKey" bundle="${fw}" />    --%>
<%!
  Logger logger             = Logger.getLogger( NcsUtil.class );

  // deprecated ...
  Logger ncsLogger          = Logger.getLogger( NcsUtil.class );

// table line - e.g., new subheader
// sample call:  	< %= ncsTableSubtitle ( "Optional Information" ) % >
private String ncsTableSubtitle ( String strSubtitle )
{
        return ( "<TR><TD height='20'></TD></TR>"
        +"<TR><TD colspan='2' bgcolor='#E0E0E0'>" + strSubtitle + "</TD></TR>"
        +"<TR><TD height='8'></TD></TR>" );
}

 public String sMandatory()
  { // add a hint for the user ... e.g.,             <% -- ncs_Hint = sMandatory(); -- % >
//    return ( " <font size='-1' color='red'>(*)</font> " );
    return ( "<font size='-1' color='red'>*</font> " );
  }

/*
	// marker for mandatory attributes
	// sample call:  	
      <TD align=left>
         < %= sMandatory( "Given_Name" ) % >
         <c:out value="${Given_NameDisplayName}"/>:&nbsp;&nbsp;
      </TD>
 // the info can be checked from javascript, since an extra hidden field ("mandatory_" + sFieldName) is added
*/
//      * example 
//               success = !( missingMandatoryField( form.mandatory_company,   form._company, '<c:out value="${companyDisplayName}"/>' )
//                        ||  missingMandatoryField( form.mandatory_manager,   form._manager, '<c:out value="${managerDisplayName}"/>'  ) )
//               if(!success)
//               {
//                  return false;
//               }
  public String sMandatory( String sFieldName )
  { // * add string if field is mandatory 
    // * add a marker so we can detect from JavaScript if a mandatory field is missing ...
    String s = "<INPUT type='hidden' value='" + sFieldName + "' id='mandatory_" + sFieldName + "' name='mandatory_" + sFieldName + "'>";
    return ( s + "<font id='mandatoryFlag_"+sFieldName + "' style='visibility:visible'>" + sMandatory() + "</font>"); // can be set/removed with JS
  }


 public boolean bValidTask ( String sThisTask, String sTaskList )
  { // is this task in task list?
    return ( NcsUtil.stringNotEmpty(sThisTask) && ( sTaskList.indexOf(sThisTask) >= 0 ) );
  }

 public String sOption ( String sThisTask, String sTaskList, String sString )
  { // add string if this task is in task list
    return ( bValidTask( sThisTask, sTaskList ) ? sString : "" );
  }

 public String sMandName ( String sFieldName, String sThisTask, String sTaskList )
  { // obsolete
    return ( bValidTask( sThisTask, sTaskList ) ? "mandatory_" + sFieldName : "undef" );
  }

 public String sMandHint ( String sFieldName, String sThisTask, String sTaskList )
  { // add string if field is mandatory
    // add a marker so we can detect from JavaScript if the field is mandatory  & add a hint for the user ...
    return ( sOption( sThisTask, sTaskList, sMandatory( sFieldName ) ) );
  }
// ... functions        --------------------------------------------------------------------------------------
%>
<%
  // instantiations ...   --------------------------------------------------------------------------------------
  final String      sPropertiesNcs    = "/com/novell/ncsEMEA/resources.properties";

  // get current tree, current user, current target and other basics
  final NcsCommon   ncsCommon         = new NcsCommon( sPropertiesNcs, request );

  // get ldap credentials
  final NcsUtilLdap ncsUtilLdap       = new NcsUtilLdap ( request );

  // a couple of initial global helper variables ...
  String            ncs_Date          = (new java.util.Date()).toString();

  JSPConduit ncs_Conduit  = JSPConduit.getJSPConduit( request );
  String ncs_modulesPath  = ncs_Conduit.getModulesUrl();
  String ncs_tomcatPath   = getServletContext().getRealPath("");
  // e.g.: sys:\tomcat\4\webapps\nps 
  String ncs_tomcatVer    = getServletContext().getServerInfo();
  // e.g.: sApache Tomcat/4.1.18
  String ncs_tomcatCtx    = getServletContext().getServletContextName();
  // e.g.: "eXtend Director" or "Novell iManager 2.5"
  //String ncs_tomcatRes    = getServletContext().getResource("").toString();
  // e.g.: jndi:/localhost/nps
  String ncs_thisJsp      = NcsUtilHtml.getRequestAttribute( request, "javax.servlet.include.request_uri", "" ); //  request.getAttribute("javax.servlet.include.request_uri").toString(); // jsp name
  // e.g.: /nps/portal/modules/ncsEMEA/skins/default/devices/browser/test_scope_20030519.jsp
  String ncs_thisJspShort = ncs_thisJsp; 
  while ( ncs_thisJspShort.indexOf('/') >= 0 ) { ncs_thisJspShort = NcsUtilBasics.stringCutBeforeString( ncs_thisJspShort, "/", true ); }
  // e.g.: test_scope_20030519.jsp
  String ncs_thisTask     = NcsUtilHtml.getRequestAttribute( request, "GI_ID", "" );                             //  request.getAttribute("GI_ID").toString(); // book/task
  // e.g.: xxx.book_EditUserInformation OR book_EditUserInformation  // v2.0.1: "module.taskId" / v.2.0.2: "taskId"

  // e.g.: xxx.test_scope.jsp
  String ncs_thisJspId    = NcsUtilHtml.getRequestAttribute( request, "merge", "" );
  if ( NcsUtil.stringEmpty( ncs_thisJspId )) // if iManager calls "repeat task", "merge" is empty
    ncs_thisJspId    = ncs_thisJspShort;
  ncs_thisJspId      = ncs_thisJspId.replaceFirst( "[.](jsp|JSP)", "" ); // remove extension

  // for launched / delegated tasks - e.g.: xxx.test_scope.jsp
  String ncs_thisTaskDelegate  = NcsUtilHtml.getRequestAttribute( request, "delegate",  "" );
  String ncs_thisTaskLaunch    = NcsUtilHtml.getRequestAttribute( request, "launch",    "" );

  // overwrite, since for delegation, the taskId has a sequential number appended. don't if the value is nothing but "true"
  if ( NcsUtil.stringNotEmpty( ncs_thisTaskDelegate ))  
     if ( ncs_thisTaskDelegate.length() > 5 ) ncs_thisTask = ncs_thisTaskDelegate;  // can be "false" in 2.0.2
  if ( NcsUtil.stringNotEmpty( ncs_thisTaskLaunch ))    
     if ( ncs_thisTaskLaunch.length() > 5 )   ncs_thisTask = ncs_thisTaskLaunch;  // can be "false" in 2.0.2

  String ncs_thisTaskShort= NcsUtilBasics.stringCutBeforeString( ncs_thisTask, ".", true );
  // e.g.: book_EditUserInformation
  String ncs_thisTaskId   = NcsUtilHtml.getRequestAttribute( request, "taskId", "" );  
  ncs_thisTaskId          = NcsUtilBasics.stringCutAfterString( ncs_thisTaskId, "~" );   // cut off "~<number>" for shared task                          
  // e.g.: xxx.book_EditUserInformation OR book_EditUserInformation  // v2.0.1: "module.taskId" / v.2.0.2: "taskId"

  // e.g. "custom"
  String ncs_thisModule   = NcsUtilBasics.stringCutAfterString( ncs_thisJspId, ".", true );

  // use these variables to allow redirection of current task to self object (e.g., for self service tasks)
  String ncs_RedirectSelfUrl  = NcsUtil.makeDelegationUrl ( ncsCommon.getTaskContext(), ncsCommon.getUser().getDn(), ncs_thisTask, "", false, false );
  String ncs_RedirectAlertJS  = "<script type='text/javascript'>"   // auto-redirect to correct target & task
                              + "alert('Self-Service functions can only be called on your own user object');"
                              + "</script>";
  String ncs_RedirectJS       = "<script type='text/javascript'>"   // auto-redirect to correct target & task
                              + "parent.location.href ='" + ncs_RedirectSelfUrl + "';"      // current window
                              + "</script>";
  String ncs_RedirectSelfJS   = ncs_RedirectAlertJS + ncs_RedirectJS;

  String ncs_Language         = (( com.novell.nps.sessionManager.PortalSession) request.getSession()).getCurrentLocale().getLanguage();

  String ncs_gifInProgress    = "<IMG height='32' width='32' align='absmiddle'"
                                    + " src='"    + ncs_Conduit.getModulesUrl() + "/fw/images/wiz_InProgress.gif'"
                                    + " title='"  + ncs_Conduit.string("CfgWiz.Common.InProgress") + "'"
                                    + " alt='"    + ncs_Conduit.string("CfgWiz.Common.InProgress") + "'>";
  String ncs_Wait             = NcsUtil.strPleaseWait2( ncs_gifInProgress + "Collecting information - Please wait ..." );
  String ncs_Done             = "<script type='text/javascript'>dhtmlMessage( 'strPleaseWait', '' );</script>";

  String ncs_ConduitDump      = "n/a";
  try {
    ncs_ConduitDump = ncs_Conduit.dumpAll();  // may not be available ...
    }
  catch ( Exception e ) {};

  // used to display all variables from ncsInc include with < %= ncsInc_all % >
  String ncsInc_all = "<table border='0'><tr><td> OBSOLETE - USE ncsEMEA/include/helperDebug.jsp <td></tr></table>";

  // add string if field is mandatory
  String sMandatoryHint = ncsCommon.getProperty( "ncsEMEA_mandatoryHint" ) + "&nbsp;" + sMandatory( );
  
  
  // declaration of common shared tasks according to declarations in install.xml
  String shared_task_deleteObject     = "shared_task_ncsEMEADeleteObjects";
  String shared_task_renameObject     = "shared_task_ncsEMEARenameObject";
  String shared_task_setPassword      = "shared_task_ncsSetPassword";

%><%--  common javascript functions  --%>
<script type='text/javascript'>  <%-- // javascript functions that require JSP code - keep in JSP --%>   
    <% GregorianCalendar srvDate = new GregorianCalendar(); // get server date with Java, then pass to JS date ... %>
    var srvDate = new Date( <%= srvDate.get( Calendar.YEAR ) %>, <%= srvDate.get( Calendar.MONTH ) %>,  <%= srvDate.get( Calendar.DATE ) %>, <%= srvDate.get( Calendar.HOUR_OF_DAY ) %>, <%= srvDate.get( Calendar.MINUTE ) %>, <%= srvDate.get( Calendar.SECOND ) %> );      
</script>

<script>
	<%--  save some common Java variables to javascript, optional but relevant to access these variables in external script files like ncsScripts.js --%>
	var ncs = new Object();
	ncs.Date				= "<%= ncs_Date %>";
	ncs.modulesPath   = "<%= ncs_modulesPath %>";
	ncs.tomcatPath		= "<%= ncs_tomcatPath %>";
	ncs.tomcatVer		= "<%= ncs_tomcatVer %>";
	ncs.tomcatCtx		= "<%= ncs_tomcatCtx %>";
	ncs.thisJsp			= "<%= ncs_thisJsp %>";
	ncs.thisJspShort	= "<%= ncs_thisJspShort %>";
	ncs.thisTask		= "<%= ncs_thisTask %>";
	ncs.thisJspId		= "<%= ncs_thisJspId %>";
	ncs.thisModule		= "<%= ncs_thisModule %>";
	ncs.Language		= "<%= ncs_Language %>";
</script>


<%-- use external JS file or internal JS functions - internal for debugging, but lower performance
  <script type='text/javascript'> <%@include file="/portal/modules/ncsEMEA/javascripts/ncsScripts.js"%> </script>
--%>
  <script language="JavaScript" src="/nps/portal/modules/ncsEMEA/javascripts/ncsScripts.js"></script>
<!--
    <pre>
        ncs_thisJsp           <%= ncs_thisJsp              %>
        ncs_thisJspId         <%= ncs_thisJspId            %>
        ncs_thisTask          <%= ncs_thisTask             %>
        ncs_thisTaskShort     <%= ncs_thisTaskShort        %>
        ncs_thisTaskId        <%= ncs_thisTaskId           %>
        NcsCommon             <%= NcsCommon.VERSION        %>
    </pre>  
-->
<LINK rel="stylesheet" href="/nps/portal/modules/ncsEMEA/css/hf_style.css">
