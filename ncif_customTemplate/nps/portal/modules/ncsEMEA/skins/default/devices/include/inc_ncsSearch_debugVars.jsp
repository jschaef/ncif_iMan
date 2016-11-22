<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_debugVars.jsp" --%>
<%-- ------------------------------------------------------------------------------------------------- --%>

<% if ( !ncsUtilSearch.bDebug ) out.println( "<!--" ); %>
<table>
   <tr><td colspan="2">ncsUtilSearch.bDebug= <%= String.valueOf( ncsUtilSearch.bDebug ) %></td> </tr>
   <tr><td>saTasks</td>                  <td>[<%= xml_sharedTask %>:       (<%= String.valueOf( ncsUtilSearch.saTasks.length ) %>)      <%= NcsUtil.stringArrayToString( ncsUtilSearch.saTasks ) %>]</td> </tr>
   <tr><td>saPages</td>                  <td>[<%= xml_sharedPageId %>:     (<%= String.valueOf( ncsUtilSearch.saPages.length ) %>)      <%= NcsUtil.stringArrayToString( ncsUtilSearch.saPages ) %>]</td> </tr>
   <tr><td>saButtons</td>                <td>[<%= xml_sharedTaskButton %>: (<%= String.valueOf( ncsUtilSearch.saButtons.length ) %>)    <%= NcsUtil.stringArrayToString( ncsUtilSearch.saButtons ) %>]</td> </tr>
   <tr><td>saAttrSearch</td>             <td>[<%= xml_searchAttr %>:       (<%= String.valueOf( ncsUtilSearch.saAttrSearch.length ) %>) <%= NcsUtil.stringArrayToString( ncsUtilSearch.saAttrSearch ) %>]</td> </tr>

   <tr><td>req_SearchBase_L</td>         <td>[<%= ncsUtilSearch.req_SearchBase_L %>]</td></tr>  
   <tr><td>req_SearchBase_E</td>         <td>[<%= ncsUtilSearch.req_SearchBase_E %>]</td></tr>  
   <tr><TD>sSearchFilter</TD>            <TD><%= ncsUtilSearch.sSearchFilter %></td></tr>

   <tr><td>saAttrDisplay</td>            <td>[<%= NcsUtil.stringArrayToString( ncsUtilSearch.saAttrDisplay,"|" ) %>]</td></tr>
   <tr><td>saAttrLocal</td>              <td>[<%= NcsUtil.stringArrayToString( ncsUtilSearch.saAttrLocal,"|" ) %>]</td></tr>
   <tr><td>saAttrDisplay2</td>            <td>[<%= NcsUtil.stringArrayToString( ncsUtilSearch.saAttrDisplay2,"|" ) %>]</td></tr>
   <tr><td>saAttrLocal2</td>             <td>[<%= NcsUtil.stringArrayToString( ncsUtilSearch.saAttrLocal2,"|" ) %>]</td></tr>   
   
   <tr><td>xml_sharedTask</td>           <td>[<%= xml_sharedTask %> / <%= xml_sharedTaskButton %>]</td></tr>
   <tr><td>xml_sharedPageId</td>         <td>[<%= xml_sharedPageId %>]</td></tr>
   <tr><td>xml_searchBase</td>           <td>[<%= xml_searchBase %> ( <%= String.valueOf(ncsUtilSearch.alSearchBase.size()) %> )]</td></tr>  
   <tr><td>xml_searchClass</td>          <td>[<%= xml_searchClass %>]</td></tr> 
   <tr><td>xml_searchFilter</td>         <td>[<%= xml_searchFilter %>] </td></tr>
   <tr><td>xml_searchFilterExclude</td>  <td>[<%= xml_searchFilterExclude %>] </td></tr>
   <tr><td>xml_searchAttr</td>           <td>[<%= xml_searchAttr %>]</td></tr>
   <tr><td>xml_searchOperatorDefault</td><td>[<%= xml_searchOperatorDefault %>]</td></tr>
   <tr><td>xml_searchOperatorAllowed</td><td>[<%= xml_searchOperatorAllowed %>]</td></tr>
   <tr><td>xml_searchProperties</td>     <td>[<%= xml_searchProperties %>]</td></tr>  
   <tr><td>xml_searchGroups</td>         <td>[<%= String.valueOf(xml_searchGroups) %>]</td></tr>  
   <tr><td>xml_searchLines</td>          <td>[<%= String.valueOf(xml_searchLines) %>]</td></tr>  
   <tr><td>xml_searchAllowChange </td>   <td>[<%= String.valueOf(xml_searchAllowChange) %>]</td></tr>  
   <tr><td>xml_searchRecurse</td>        <td>[<%= String.valueOf(xml_searchRecurse) %>]</td></tr>  
   <tr><td>xml_searchOS</td>             <td>[<%= String.valueOf(xml_searchOS) %>]</td></tr>  
   <tr><td>xml_multiSelect</td>          <td>[<%= String.valueOf(xml_multiSelect) %>]</td></tr>  
   <tr><td>xml_searchOnStart</td>        <td>[<%= String.valueOf(xml_searchOnStart) %>]</td></tr>  
   <tr><td>xml_displayAttr</td>          <td>[<%= xml_displayAttr %>]</td></tr>
   <tr><td>xml_parentControl</td>        <td>[<%= xml_parentControl %>]</td></tr>
   
   <tr><td>xml_displayAuto</td>          <td>[<%= String.valueOf(xml_displayAuto) %>]</td></tr>  
   <tr><td>xml_displayCompact</td>       <td>[<%= String.valueOf(xml_displayCompact) %>]</td></tr>  
   <tr><td>xml_fullName</td>             <td>[<%= xml_fullName %>]</td></tr>  
   <tr><td>xml_launch</td>               <td>[<%= String.valueOf(xml_launch) %>]</td></tr>  

</table>
<% if ( !ncsUtilSearch.bDebug ) out.println( "-->" ); %>

<%-- 
	<-- 
	  <%= NcsUtilDebug.debug( request ) %>
	-->
--%>
