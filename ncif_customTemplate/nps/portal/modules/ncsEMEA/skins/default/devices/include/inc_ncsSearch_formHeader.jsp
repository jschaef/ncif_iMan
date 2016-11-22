<%-- ------------------------------------------------------------------------------------------------- --%>
<%-- declare form start & hidden input --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_formHeader.jsp" --%>
<%-- used in task_ncsSearch.jsp --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_formHeader.jsp  - start ... -->
<FORM name="Next" method=post action="webacc">
<% 
//      c.set("TaskHeader.title",   ncsCommon.getProperty( ncs_thisTaskId ) );
      c.set("TaskHeader.title", ncsUtilSearch.searchProperties.getProperty( ncs_thisTaskId, "Search" ) );       // 2.0.2
      c.set("TaskHeader.iconUrl", c.plus("dir/", "Search_Policy.gif"));
      c.set("TaskHeader.iconAlt", ncs_thisTaskShort ); 
%>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

   <%-- required ...                                                                                     --%>
   <input type='hidden' name='GI_ID'         value='<%= ncs_thisTaskId %>'>
<%--
   <script type='text/javascript'>
      var GI_ID         = getFieldByNameOrId( "GI_ID" );
      if ( GI_ID != undefined ) GI_ID.value       = '<%= ncs_thisTaskId %>';
   </script>
--%>

   <%-- required for EmptyTask - if specified here, the page reloads after sumbit(), otherwise it exits  --%>
   <INPUT type='hidden' name='nextState'     value='initialState'>

   <%-- optional: error page ...                                                                         --%>
   <INPUT type='hidden' name='error'         value='dev.GenErr'>

   <%-- required if delegation to other task is used                                                     --%>
   <INPUT type='hidden' name='<%= NcsUtilSearch.sFieldName_targetNames %>'   value=''>

<!-- inc_ncsSearch_formHeader.jsp  - ... end -->
