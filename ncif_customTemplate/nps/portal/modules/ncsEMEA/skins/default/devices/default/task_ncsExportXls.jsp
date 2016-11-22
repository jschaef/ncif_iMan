<%@ page contentType="application/vnd.ms-excel" %><%@page import="com.novell.ncsEMEA.util.*, java.util.*, com.novell.nps.sessionManager.*, org.apache.log4j.Logger" %><%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export_vars.jsp" %><% /**

		// deprecated - see changes for XLS in inc_export.jsp

		// in FireFox 3.5: check "Tools"/"Options"/"Applications"
 *
 *  accepted keys/parameters in form request (see include/inc_export_vars.jsp):
 *    sPar_separator
 *    sPar_preformatted
 *    sPar_quote
 *    sPar_format
 *    sPar_print
 *    sPar_title
 *    sPar_extension
 * 
 */
   Logger logger = Logger.getLogger( "Export" );
   String par_separator = NcsUtil.getRequestParameter( request, sPar_separator, "" );
   String par_quote     = NcsUtil.getRequestParameter( request, sPar_quote, "" );
   String par_format    = NcsUtil.getRequestParameter( request, sPar_format, "html" );

   ArrayList alDataXls = ( ArrayList ) session.getAttribute( NcsUtil.sTempVar );
   for ( int iRow=0; iRow<alDataXls.size(); iRow ++ ){
      ArrayList alRowXls = ( ArrayList ) alDataXls.get(iRow);  // make sure to set an ArrayList of ArrayLists into sTempVar, otherwise this will throw
      for ( int iCol=0; iCol<alRowXls.size(); iCol++ ){
         if ( iCol>0 ) out.print( par_separator ); 
         out.print( par_quote + alRowXls.get(iCol).toString() + par_quote ); 
      }
      out.println( "" ); 
   }
%>
