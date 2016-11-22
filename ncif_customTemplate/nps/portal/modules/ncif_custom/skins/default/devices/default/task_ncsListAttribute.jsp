<%@ page import="com.novell.ncsEMEA.util.*, com.novell.nps.gadgetManager.BaseGadgetInstance" %>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<%--

task to generate a delegation dropdown list from the attributes of a specified object


task_ncsListAttribute   use xml declaration like ...


  <task>
      <id>task_ncsListAttribute</id>
      <version>2.0.0</version>
      <required-version>2.0.0</required-version>
      <class-name>com.novell.emframe.dev.EmptyTask</class-name>
      <merge-template>ncsEMEA.task_ncsListAttribute</merge-template> 
      <display-name-key>task_ncsListAttribute</display-name-key>
      <description-key>task_ncsListAttribute</description-key>
      <resource-properties-file>com.novell.ncif.resources</resource-properties-file>
      <role-assignment>NCIF Management</role-assignment>

		<url-param>
          <param-key>sharedTask</param-key>
          <param-value>fw.ModifyObject</param-value>
      </url-param>
      <url-param>
          <param-key>sharedPageId</param-key>
          <param-value></param-value>
      </url-param>
      <url-param>
          <param-key>searchObjectDn</param-key>
          <param-value>DeviceTemplateList.ncif-configuration.global.<%= o_base %></param-value>
      </url-param>
      <url-param>
          <param-key>searchAttribute</param-key>
          <param-value>Member</param-value>
      </url-param>
      <url-param>
          <param-key>launch</param-key>
          <param-value>false</param-value>
      </url-param>
      <url-param>
          <param-key>displayFormat</param-key>
          <param-value>SELECT</param-value>
      </url-param>
      <url-param>
          <param-key>displayTitleKey</param-key>
          <param-value>Select Template</param-value>
      </url-param>
      <url-param>
          <param-key>searchProperties</param-key>
          <param-value>com/novell/ncif_common/resources.properties</param-value>
      </url-param>
      <url-param>
          <param-key>displayAttr</param-key>
          <param-value>future use</param-value>
      </url-param>
      <url-param>
          <param-key>fullName</param-key>
          <param-value>future use</param-value>
      </url-param>
		
  </task>


--%>

<%@ taglib uri="/WEB-INF/iman.tld"  prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld"     prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld"   prefix="fmt" %>

<% 
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>

<%
  final String parSeparator           = "[|]"; 

  // single value
  String xml_searchProperties       = NcsUtil.getRequestAttribute( request, "searchProperties",			"" ); 
  String xml_searchObjectDn         = NcsUtil.getRequestAttribute( request, "searchObjectDn",			"" ); 
  String xml_searchAttribute        = NcsUtil.getRequestAttribute( request, "searchAttribute",			"" ); 
  String xml_fullName					= NcsUtil.getRequestAttribute( request, "fullName",					"" ); 
  String xml_launch						= NcsUtil.getRequestAttribute( request, "launch",						"false" ); 
  String xml_displayFormat				= NcsUtil.getRequestAttribute( request, "displayFormat",				"SELECT" ); 
  String xml_displayTitleKey			= NcsUtil.getRequestAttribute( request, "displayTitleKey",			"" ); 

  // multi value: buttons/tasks
  String xml_sharedPageId           = NcsUtil.getRequestAttribute( request, "sharedPageId",				"" ); 
  String xml_sharedTask             = NcsUtil.getRequestAttribute( request, "sharedTask",					"" ); 
  String xml_sharedTaskButton       = NcsUtil.getRequestAttribute( request, "sharedTaskButton",			"" ); 

  // multi value: level dependent
  String xml_displayAttr            = NcsUtil.getRequestAttribute( request, "displayAttr",				 "" ); 
 
  // replace tree specific placeholder
  xml_searchObjectDn						= xml_searchObjectDn.replace( "%O_BASE%", o_base );
 
/* hard code for testing ...
 ... hard code for testing
*/
  
	final NcsProperties properties    = new NcsProperties( "/" + xml_searchProperties, request );

	String[]    sa_sharedPageId       = xml_sharedPageId.split( parSeparator );
	String[]    sa_sharedTask         = xml_sharedTask.split( parSeparator );
	String[]    sa_sharedTaskButton   = xml_sharedTaskButton.split( parSeparator );

	String[]    sa_displayAttr        = xml_displayAttr.split( parSeparator );


	int         iLevels               = sa_displayAttr.length;
	ArrayList[] alLevel               = new ArrayList[iLevels];
	String      sOptionsBase          = ""; // options of first list
	String[]    jsArray               = new String[iLevels];
	String[]    jsLevel               = new String[iLevels];

	String		sLevel						= "0";
	int         iLevel                = 0;
  
	NDSNamespace ns						=	NcsUtil.getNDSNamespace( request );

	String		 sOptionList			= NcsUtil.getAttributeAsOptionList( ns, xml_searchObjectDn, xml_searchAttribute );

	boolean		bDebug					= false; // true;  // 
%>


<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>



<BODY>

<% 
  c.set("TaskHeader.title",   properties.getProperty( "task." + ncs_thisTask ));
  c.set("TaskHeader.iconUrl", "dir/Search_Policy.gif" );
  c.set("TaskHeader.iconAlt", "Selector" ); 
%>

<jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

<p>

<TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" >

   

    <script type='text/javascript'>
      var sSelectedLevel_<%= sLevel %>  = "";
    
      function getInfoFromList<%= sLevel %>( sList, sAttribute, sTargetDhtml )
      { 
        <%= jsArray[ iLevel ] %>            
        sDescription = extractAttachedAttribute ( sList, sAttribute, "n/a" );
        //alert (  "<%= sLevel %>: " + sList + "/" + sAttribute + "/" + sTargetDhtml )
        dhtmlMessage( sTargetDhtml, sDescription );
      }

      
    </script>
      
   <TR>
      <Th align="left" colspan="2"><%= properties.getProperty( xml_displayTitleKey ) %>:&nbsp;&nbsp;</Th>
   </TR>
   <TR><TD height="6"></TD></TR>
   <TR>
      <TD>
        <SELECT name="lb_selector" id="lb_selector" size="10" style='width:<iman:string key="UI.loginscripttextboxPixel"/>' > 
          <%= sOptionList %>
        </SELECT>
      </TD>
   </TR>
   <TR><TD height="8"></TD></TR>


  
    <TR><TD height="40"></TD></TR>

    <tr><TD></TD><td colspan='99' align=center >

    <script type='text/javascript'>
    
      function callFct( sTask, sPage )
      {
        var sTarget = getFieldValueByName( "lb_selector" );
		  if ( sTarget )
		  {
			var sHref   = delegationUrl_String ( sTarget, "<%= sa_sharedTask[0] %>", "<%= sa_sharedPageId[0] %>" );
			redirectFrame( sHref ); 			  
		  }
      }
   
    </script>
   
    </td></tr>
  
</table>

<% if ( !bDebug ) { %>  <!-- <% } %>

  <table width='100%'>
    <tr><td>xml_searchProperties</td>     <td>[<%= xml_searchProperties %>]</td></tr>  
    <tr><td>xml_searchObjectDn</td>       <td>[<%= xml_searchObjectDn %>]</td></tr>  
    <tr><td>xml_searchAttribute</td>      <td>[<%= xml_searchAttribute %>]</td></tr>  
    <tr><td>xml_sharedTask</td>           <td>[<%= xml_sharedTask %>]</td></tr>
    <tr><td>xml_sharedPageId</td>         <td>[<%= xml_sharedPageId %>]</td></tr>
    <tr><td>xml_displayAttr</td>          <td>[<%= xml_displayAttr %>]</td></tr>
    <tr><td>xml_fullName</td>             <td>[<%= xml_fullName %>]</td></tr>  
    <tr><td>xml_launch</td>               <td>[<%= xml_launch %>]</td></tr>  
    <tr><td>xml_displayFormat</td>        <td>[<%= xml_displayFormat %>]</td></tr>  
    <tr><td>xml_displayTitleKey</td>      <td>[<%= xml_displayTitleKey %>]</td></tr>  

    <tr><td>sa_sharedPageId</td>          <td>[<%= NcsUtil.stringArrayToString( sa_sharedPageId )  %>]</td></tr>  
    <tr><td>sa_sharedTask</td>            <td>[<%= NcsUtil.stringArrayToString( sa_sharedTask )  %>]</td></tr>  
    <tr><td>sa_sharedTaskButton</td>      <td>[<%= NcsUtil.stringArrayToString( sa_sharedTaskButton )  %>]</td></tr>  
    <tr><td>sa_displayAttr</td>           <td>[<%= NcsUtil.stringArrayToString( sa_displayAttr )  %>]</td></tr>  
  </table>
<% if ( !bDebug ) { %>  --> <% } %>


<iman:bar/>
<iman:button key="OK" onClick="callFct( )" />
<iman:cancelBtn/>

</body>
</HTML>
