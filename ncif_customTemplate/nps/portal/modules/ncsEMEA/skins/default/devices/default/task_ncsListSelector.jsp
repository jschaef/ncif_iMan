<%@ page import="com.novell.ncsEMEA.util.*, com.novell.nps.gadgetManager.BaseGadgetInstance" %>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>


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

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<%
  final String parSeparator           = "[|]"; 

  // single value
  String xml_searchProperties       = NcsUtil.getRequestAttribute( request, "searchProperties",      "" ); 
  String xml_searchBase             = NcsUtil.getRequestAttribute( request, "searchBase",            "" ); 

  // multi value: buttons/tasks
  String xml_sharedPageId           = NcsUtil.getRequestAttribute( request, "sharedPageId",          "" ); 
  String xml_sharedTask             = NcsUtil.getRequestAttribute( request, "sharedTask",            "" ); 
  String xml_sharedTaskButton       = NcsUtil.getRequestAttribute( request, "sharedTaskButton",      "" ); 

  // multi value: level dependent
  String xml_searchClass            = NcsUtil.getRequestAttribute( request, "searchClass",           "" ); 
  String xml_displayAttr            = NcsUtil.getRequestAttribute( request, "displayAttr",           "" ); 
  String xml_searchLevelKeys        = NcsUtil.getRequestAttribute( request, "searchLevelKeys",       "" ); 



  boolean xml_searchRecurse         = "true".equalsIgnoreCase( NcsUtil.getRequestAttribute( request, "searchRecurse",      "true" )); 
  boolean xml_launch                = "true".equalsIgnoreCase( NcsUtil.getRequestAttribute( request, "launch",             "true" )); 

  
  

/* hard code for testing ...
  xml_searchBase                    = "ORG";
  xml_searchClass                   = NcsUtilSchemaEdir.class_OU  + "|" + NcsUtilSchemaEdir.class_OU          + "|" + NcsUtilSchemaEdir.class_Group; 
  xml_searchProperties              = "com/novell/ncsDemo/resources.properties";

  xml_searchProperties              = NcsUtilSp.sPropertiesFile;

  xml_searchBase                    = NcsUtilSp.spCont_ADDomains;
  xml_sharedPageId                  = ""; 
  xml_sharedTask                    = "sp.shared_book_ADGroupEdit|shared_task_ncsEMEARenameObject"; 
  xml_sharedTaskButton              = "btnedit|btnrename"; 

  // multi value: level dependent
  xml_searchClass                   = NcsUtilSchemaEdir.class_OU  + "|" + NcsUtilSchemaEdir.class_OU          + "|" + NcsUtilSchemaEdir.class_Group; 
  xml_displayAttr                   = NcsUtilSchemaEdir.attr_OU   + "|" + NcsUtilSchemaEdir.attr_Description  + "|" + NcsUtilSchemaEdir.attr_Description; 
  xml_searchLevelKeys               = "text.AD_Domain|text.AD_Farm|text.AD_Group"; 

  xml_searchRecurse                 = false;
  xml_launch                        = true;
  
 ... hard code for testing
*/
  
  final NcsProperties properties    = new NcsProperties( "/" + xml_searchProperties, request );

  String[]    sa_sharedPageId       = xml_sharedPageId.split( parSeparator );
  String[]    sa_sharedTask         = xml_sharedTask.split( parSeparator );
  String[]    sa_sharedTaskButton   = xml_sharedTaskButton.split( parSeparator );

  String[]    sa_searchClass        = xml_searchClass.split( parSeparator );
  String[]    sa_displayAttr        = xml_displayAttr.split( parSeparator );
  String[]    sa_searchLevelKeys    = xml_searchLevelKeys.split( parSeparator );
  
  
  int         iLevels               = sa_displayAttr.length;
  ArrayList[] alLevel               = new ArrayList[iLevels];
  String      sOptionsBase          = ""; // options of first list
  String[]    jsArray               = new String[iLevels];
  String[]    jsLevel               = new String[iLevels];
  
%>


<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>



<BODY>

<% 
  c.set("TaskHeader.title",   properties.getProperty( ncs_thisTask ));
  c.set("TaskHeader.iconUrl", "dir/Search_Policy.gif" );
  c.set("TaskHeader.iconAlt", "Selector" ); 
%>

<jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

<p>

<TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" >

   
   <%-- Select domain and farm ... --%>

   <%-- example call ...

      function onExit()
      {
         var form=document.forms[0];
         var sSelectedLevel_2 = getFieldValueByName( 'lb_level_2' );
         form.eDir$target$createContext.value = sSelectedLevel_2;
     ...
     }   
 
  <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" >
    <%
      boolean   bShowLevel_3    = true; // false; // 
    %>
    <%@ include file="/portal/modules/sp/include/select_AD_group.jsp" %>

  </table>

--%>


<%
  for ( int iLevel=0; iLevel < iLevels; iLevel++ )
  {
    boolean bFirstLevel = ( iLevel == 0 );
    boolean bLastLevel  = ( iLevel+1 >= iLevels );
    String  sLevel      = String.valueOf( iLevel );
    String  sNextLevel  = String.valueOf( iLevel+1 );
    String  sPrevLevel  = ( bFirstLevel ? "" : String.valueOf( iLevel-1 ));
    
    boolean bRecurse    = ( bFirstLevel ? xml_searchRecurse : true );
    
    alLevel[iLevel]     = NcsUtil.getObjectsAsArrayList( ncsCommon.getTree().getNs(),                           xml_searchBase, sa_searchClass[iLevel], "", "", bRecurse );
    jsArray[iLevel]     = NcsUtil.arrayListToHtmlList( alLevel[iLevel], "JS", ncsCommon.getTree().getNs(),      sa_displayAttr[iLevel], "", "", "", false, "" );

    if ( !bFirstLevel )
      jsLevel[iLevel]   = NcsUtil.putArrayListToScript( ncsCommon.getTree().getNs(),                            alLevel[iLevel],  sa_displayAttr[iLevel], sa_displayAttr[iLevel], "", "", true );

    if ( bFirstLevel )
        sOptionsBase    = NcsUtil.arrayListToHtmlList( alLevel[iLevel], "OPTION", ncsCommon.getTree().getNs(),  sa_displayAttr[iLevel], "", "", "", false, sa_displayAttr[iLevel] );
    else 
        sOptionsBase    = "";

%>

    <script type='text/javascript'>
      var sSelectedLevel_<%= sLevel %>  = "";
    
      function getInfoFromList<%= sLevel %>( sList, sAttribute, sTargetDhtml )
      { 
        <%= jsArray[ iLevel ] %>            
        sDescription = extractAttachedAttribute ( sList, sAttribute, "n/a" );
        //alert (  "<%= sLevel %>: " + sList + "/" + sAttribute + "/" + sTargetDhtml )
        dhtmlMessage( sTargetDhtml, sDescription );
      }

      function SelectLevel_<%= sLevel %>( )
      {
        sSelectedLevel_<%= sLevel %> = getFieldValueByName( "lb_level_<%= sLevel %>" );
        getInfoFromList<%= sLevel %>( 'lb_level_<%= sLevel %>', "<%= NcsUtilSchemaEdir.attr_OU %>", "level_<%= sLevel %>" );
        <% if ( !bLastLevel ) { %>
        SelectLevel_<%= sNextLevel %>_ByLevel_<%= sLevel %>( 'lb_level_<%= sLevel %>', 'lb_level_<%= sNextLevel %>', '');
        SelectLevel_<%= sNextLevel %>();
        <% } %>
      }
      
      <% if ( !bFirstLevel ) { %>
      function SelectLevel_<%= sLevel %>_ByLevel_<%= sPrevLevel %>( sList1, sList2, sAttrName )
      { 
        <%= jsLevel[ iLevel ] %>
        // alert (  "SelectLevel_<%= sLevel %>_ByLevel_<%= sPrevLevel %> " + sList<%= sPrevLevel %> + "/" + sList<%= sLevel %> + ":" + list1Value )
        filterListByValue(    sList2, "."+list1Value, "" );
        excludeGrandChildren( sList2, "."+list1Value );
        <% if ( !bLastLevel ) { %>
        SelectLevel_<%= sNextLevel %>_ByLevel_<%= sLevel %>( 'lb_level_<%= sLevel %>', 'lb_level_<%= sNextLevel %>', '');
        <% } %>
      }
      <% } %>
      
    </script>
      
   <TR>
      <TD><%= properties.getProperty( ncs_thisTask + ".level_" + sLevel ) %>:&nbsp;&nbsp;</TD>
      <TD>
        <SELECT name="lb_level_<%= sLevel %>" onchange="SelectLevel_<%= sLevel %>();" style='width:<iman:string key="UI.textboxPixel"/>' > 
          <%= ( bFirstLevel ? sOptionsBase : "" ) %>
        </SELECT>
        &nbsp;<font id='level_<%= sLevel %>'>&nbsp;</font>
      </TD>
   </TR>
   <TR><TD height="8"></TD></TR>

<%
  }
%>
   
    <script type='text/javascript'>
      SelectLevel_0( );
      
      // exclude grandchildren
      // e.g.: excludeGrandChildren( sList2, ".novell" ); // will remove all but direct children of ".novell"
      function excludeGrandChildren( sList, sParent )
      {
        var list = document.getElementsByName( sList )[0];
        if ( list == null )                return;
        if ( list.length == 0 )            return;
        for ( i=list.length-1; i>=0; i-- ) 
        {
          var listValue = list[i].value;
          listValue = deleteStringAfterSeparator ( listValue, sParent );
          if ( listValue.indexOf( "." ) >= 0 )
          {
            list[i] = null;
          }
        }
      }

      
    </script>
   
   

  
    <TR><TD height="40"></TD></TR>

    <tr><TD></TD><td colspan='99' align=center >

    <script type='text/javascript'>
    
      function callFct( sTask, sPage )
      {
        var sTarget = getFieldValueByName( "lb_level_<%= iLevels-1 %>" );
        var sHref   = delegationUrl_String ( sTarget, sTask, sPage );
        
        redirectFrame( sHref ); 
      }
   
    </script>
   
    <%
      for ( int i = 0; i<sa_sharedTaskButton.length; i++ )
      {
        String sButton = "<a href='#' onclick='callFct( \"" + sa_sharedTask[i] + "\", \"\" );'>" 
                        + NcsUtil.getButtonImg( request, ncs_Language, sa_sharedTaskButton[i], sa_sharedTaskButton[i] ) 
                        + "</a>&nbsp; &nbsp; &nbsp;";
    %>
    <%= sButton %> 
    <%  } %>
      
    </td></tr>
  
</table>

<!--
  <table width='100%'>
    <tr><td>xml_searchProperties</td>     <td>[<%= xml_searchProperties %>]</td></tr>  
    <tr><td>xml_searchBase</td>           <td>[<%= xml_searchBase %>]</td></tr>  
    <tr><td>xml_sharedPageId</td>         <td>[<%= xml_sharedPageId %>]</td></tr>
    <tr><td>xml_sharedTask</td>           <td>[<%= xml_sharedTaskButton %> / <%= xml_sharedTask %> ]</td></tr>
    <tr><td>xml_searchClass</td>          <td>[<%= xml_searchClass %>]</td></tr> 
    <tr><td>xml_displayAttr</td>          <td>[<%= xml_displayAttr %>]</td></tr>
    <tr><td>xml_searchLevelKeys</td>      <td>[<%= xml_searchLevelKeys %>]</td></tr>    
    <tr><td>xml_searchRecurse</td>        <td>[<%= xml_searchRecurse %>]</td></tr>
    <tr><td>xml_launch</td>               <td>[<%= xml_launch %>]</td></tr>  

    <tr><td>sa_sharedPageId</td>          <td>[<%= NcsUtil.stringArrayToString( sa_sharedPageId )  %>]</td></tr>  
    <tr><td>sa_sharedTask</td>            <td>[<%= NcsUtil.stringArrayToString( sa_sharedTask )  %>]</td></tr>  
    <tr><td>sa_sharedTaskButton</td>      <td>[<%= NcsUtil.stringArrayToString( sa_sharedTaskButton )  %>]</td></tr>  
    <tr><td>sa_searchClass</td>           <td>[<%= NcsUtil.stringArrayToString( sa_searchClass )  %>]</td></tr>  
    <tr><td>sa_displayAttr</td>           <td>[<%= NcsUtil.stringArrayToString( sa_displayAttr )  %>]</td></tr>  
    <tr><td>sa_searchLevelKeys</td>       <td>[<%= NcsUtil.stringArrayToString( sa_searchLevelKeys )  %>]</td></tr>  
  </table>
-->







<iman:bar/>

</body>
</HTML>
