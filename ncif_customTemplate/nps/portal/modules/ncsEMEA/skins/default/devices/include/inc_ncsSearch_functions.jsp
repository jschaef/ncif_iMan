<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_functions.jsp" --%>
<%-- 
   used in ncs_Search & ncs_Delegate
   replaces the obsolete inc_ncsSearch_functions - functionality moved to NcsUtilSearch 

   if you get "Symbol not found" exceptions with older tasks (before 2006-11), 
      it is usually sufficient to add prefix "ncsUtilSearch." to these symbols
--%>   
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_functions.jsp start -->
<%
    NcsUtilSearch ncsUtilSearch   = new NcsUtilSearch( request, response );
    ncsUtilSearch.out             = out;
    ArrayList     arCarryOver     = new ArrayList( 20 ); 
%>
<!-- inc_ncsSearch_functions.jsp end -->
