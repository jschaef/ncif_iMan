<%
    //
    // helper jsp declaring some shared variables
    //     < % @ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_export_vars.jsp" % >
    //
    
	String EXPORT_FORM				= "exportData";         // name of the submit form


	String sPar_print					= "par_print";          // print button trigger
	String sPar_format				= "par_format";         // output format (html, xls, txt)
	String sPar_filename				= "par_filename";			// output filename, e.g. "myExport"
	String sPar_separator			= "par_separator";      // xls separator, e.g., ";"
	String sPar_quote					= "par_quote";          // xls quote char, e.g. "'"
	String sPar_preformatted		= "par_preformatted";   // if "TRUE", no output formatting into table, show as is
	String sPar_title					= "par_title";          // display title
	String sPar_data					= "par_data";           // output data
	String sPar_extension			= "par_extension";      // file extension (with option "save")
	String sPar_css					= "par_css";            // file extension (with option "save")
    //
    // see inc_export for example and explanations
%>