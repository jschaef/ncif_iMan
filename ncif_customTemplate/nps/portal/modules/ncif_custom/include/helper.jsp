<%--
    // common java & jsp stuff used by Novell Consulting Services (NCS)
    // 
    // include into JSP with 
    // 	 <%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>
    //
    // get localized vars ...
    //  <%= ncsUtil_ncif_custom.getProperty(       "Attribute.test" ) %>
--%>
<%@page import="com.ncif.imanager.NcsUtil_ncif_custom" %>

<%@include file="/portal/modules/ncsEMEA/include/helper.jsp"%>

<fmt:setLocale value="${ClientLocale}"/>
<fmt:setBundle var="ncif" basename="com.novell.ncif_custom.resources"/> 


<%!
	String		o_base					= "@CUSTOMER.ORGNAME@";		// custom specific organisation injected here
	String		ou_global				= "global"						+ "." + o_base;
	String		ou_config				= "ncif-configuration"		+ "." + ou_global;

	// if the tree name contains specific string fragments, use different o_base
	String[]		saTreeFragment			=	new String[]{ "-DEV",		"-TST",		"-LAB" };		// identifier
	String[]		saBase					=	new String[]{ "@CUSTOMER.ORGNAME@-dev",	"@CUSTOMER.ORGNAME@-tst",	"@CUSTOMER.ORGNAME@-lab" };	// alternative base
	
	/** 

	Example:
		< %= getMvCheckboxesFromList( request, ncsCommon.getTree().getOe(), "ncifXMLSnippets", "ncifXMLSnippets" ) % >

		<SCRIPT language="javascript">
			function checkAllncifXMLSnippets(myFormName)
			{
			  for(var i=0;i<mvcheckbox_count_ncifXMLSnippets; i++)
			  {
				  if(myFormName._ncifXMLSnippetscheckAll.checked)
				  {
					 eval("myFormName._ncifXMLSnippets" + i + ".checked='checked'");
					 eval("mvcheckbox_onclick('ncifXMLSnippets', i )");
				  }
				  else
				  {
					 eval("myFormName._ncifXMLSnippets" + i + ".checked=null");
				  }
			  }
			}
		</SCRIPT>

	*/
	String getMvCheckboxesFromList( HttpServletRequest request, ObjectEntry oeTree, String sListCn, String sAttribute )
	{
		StringBuffer	result			=	new StringBuffer( NcsUtilBasics.CRLF );
		String			sListDN			=	sListCn + "." + ou_config;
		ArrayList		alOptions		=	NcsUtil.getAttrArrayList( oeTree, sListDN, "L" );
		ArrayList		alCurrent		=	NcsUtil.getAttributeFromEdas( request, sAttribute );

		for ( int i=0; i<alOptions.size(); i++ )
		{
			String		sObjName			=	(String) alOptions.get(i);
			String		sSelected		=	alCurrent.contains( sObjName ) ? "checked" : "";
			result.append( "<INPUT type=\"checkbox\" name=\"_" + sAttribute + i + "\" onClick=\"mvcheckbox_onclick('" + sAttribute + "', " + i + ");\" value=\"" + sObjName + "\" " + sSelected + ">" + sObjName + "<br>");
			result.append( NcsUtilBasics.CRLF );
		}

		result.append( "<SCRIPT>" + NcsUtilBasics.CRLF );
		for ( int i=0; i<alOptions.size(); i++ )
		{
			result.append( "mvcheckbox_onclick( '" + sAttribute + "', " + i + ");" );
			result.append( NcsUtilBasics.CRLF );
		}
		// pass mvcheckbox count back to calling JSP
		result.append( "var mvcheckbox_count_" + sAttribute + " = " + alOptions.size() + ";" + NcsUtilBasics.CRLF  );
		
		result.append( "</SCRIPT>" + NcsUtilBasics.CRLF );
		return( result.toString() );
	}

	/* read attribute values and display in option list
	*/
	String getSelectOptionsFromList( HttpServletRequest request, ObjectEntry oeTree, String sListCn, String sAttribute )
	{
		StringBuffer	result			=	new StringBuffer( NcsUtilBasics.CRLF );
		String			sListDN			=	sListCn + "." + ou_config;
		ArrayList		alOptions		=	NcsUtil.getAttrArrayList( oeTree, sListDN, "L" );
		ArrayList		alCurrent		=	NcsUtil.getAttributeFromEdas( request, sAttribute );

		for ( int i=0; i<alOptions.size(); i++ )
		{
			String		sObjName			=	(String) alOptions.get(i);
			String		sSelected		=	alCurrent.contains( sObjName ) ? "selected" : "";
			result.append( "<OPTION value='" + sObjName + "' " + sSelected + ">" + sObjName );
			result.append( NcsUtilBasics.CRLF );
		}
		return( result.toString() );
	}

	/* run a query for specified objects and display in option list
	*/
	String getSelectOptionsFromScan( HttpServletRequest request, ObjectEntry oeTree, String sBaseDN, String sObjectClass, boolean bRecurse, String sReturnInfo, String sAttribute )
	{
		StringBuffer	result			=	new StringBuffer( NcsUtilBasics.CRLF );
		try
		{
			NcsObjScanner	ncsObjScanner	=	new NcsObjScanner( oeTree, sBaseDN, bRecurse, sObjectClass, "" );
			ncsObjScanner.setReturnInfo( sReturnInfo );
			ArrayList	alCurrent		=	NcsUtil.getAttributeFromEdas( request, sAttribute );
			ArrayList	alOptions		=	ncsObjScanner.toArrayList();
			for ( int i=0; i<alOptions.size(); i++ )
			{
				String	sObjName			=	(String) alOptions.get(i);
				String	sSelected		=	alCurrent.contains( sObjName ) ? "selected" : "";
				result.append( "<OPTION value='" + sObjName + "' " + sSelected + ">" + sObjName );
				result.append( NcsUtilBasics.CRLF );
			}
		}
		catch ( Exception ex )
		{
			result.append( "<OPTION value='" + ex + "' selected >" + ex );
		}
		return( result.toString() );
	}

	/* run a query for specified objects and display parent containers in option list
	*/
	String getSelectOptionsFromScan_Parent( HttpServletRequest request, ObjectEntry oeTree, String sBaseDN, String sObjectClass, boolean bRecurse, String sReturnInfo, String sAttribute )
	{
		StringBuffer	result			=	new StringBuffer( NcsUtilBasics.CRLF );
		try
		{
			NDSNamespace	ns					=	NcsUtil.getNDSNamespace( request );
			NcsObjScanner	ncsObjScanner	=	new NcsObjScanner( oeTree, sBaseDN, bRecurse, sObjectClass, "" );
			ncsObjScanner.setReturnInfo( sReturnInfo );
			ArrayList	alCurrent		=	NcsUtil.getAttributeFromEdas( request, sAttribute );
			ArrayList	alOptions		=	ncsObjScanner.toArrayList();
			for ( int i=0; i<alOptions.size(); i++ )
			{
				String	sObjName			=	NcsUtil.getParentObject( ns, (String) alOptions.get(i) ); // (String) alOptions.get(i);
				String	sSelected		=	alCurrent.contains( sObjName ) ? "selected" : "";
				result.append( "<OPTION value='" + sObjName + "' " + sSelected + ">" + sObjName );
				result.append( NcsUtilBasics.CRLF );
			}
		}
		catch ( Exception ex )
		{
			result.append( "<OPTION value='" + ex + "' selected >" + ex );
		}
		return( result.toString() );
	}
%>


<%
  final NcsUtil_ncif_custom    ncsUtil_ncif_custom        = new NcsUtil_ncif_custom( request );
  
	String					ncif_mandatory			=	"";

	/* we may use 3 different envirnment with different tree names - overwrite default?
			the o_base depends on the tree name:
				@CUSTOMER.UPPER@					->	o=@CUSTOMER.ORGNAME@
				@CUSTOMER.UPPER@-DEV-TREE		->	o=@CUSTOMER.ORGNAME@-dev
				@CUSTOMER.UPPER@-TST-TREE		->	o=@CUSTOMER.ORGNAME@-tst
	*/
	String		sTreeName				=	ncsCommon.getTree().getPlainTreeName().toUpperCase();
	for ( int i=0; i<saTreeFragment.length; i++ )
	{
		if ( sTreeName.contains( saTreeFragment[i] ))
		{
			o_base												= saBase[i];		// PROD/TST/DEV
			ou_global											= "global"						+ "." + o_base;
			ou_config											= "ncif-configuration"		+ "." + ou_global;
			break;
		}
	}
%>

<%--  common javascript functions  --%>
<SCRIPT>
	
		/**
		 * e.g., in isPageValid( action )
		 * 
		 *			if ( success ) success = wsValidate( action );
		 *			return( success );
		 * 
		 *		workaround bug if standard regex validation does not work correctly 

		 * @param {type} action
		 * @returns {Boolean}
		 */
		function wsValidate( action )
		{
			
			var checkRegEx	= function( attrObj, values )
			{
				var result = true;
				if ( attrObj && attrObj.m_regExpression )
				{
					for( var j=0; j<values.length; j++ )
					{
						var sValue = values[j];
						var sMatch = sValue.match( attrObj.m_regExpression );
						if ( (sMatch == null ) || ( sMatch[0] !== sValue ))
						{
							result = false;
							alert( attrObj.m_regExpressionMsg );
						}
					}
				}
				return ( result );
			};
			
			
			debugger;
			var result = true;
			switch ( action )
			{
				case "apply":
				case "ok":
					try
					{
						var attrNames	= exitNotificationControlNames; // get field names
						for ( var i=0; i<attrNames.length; i++ )
						{
							var attrName		= attrNames[i];
							var attrData		= {};
							attrData.values	= unpack( mvGetValuesAsPack ( "_" + attrName ) );
							attrData.uiObject	= window [ "uiObject_"	+ attrName ];
							attrData.mv			= window [ "mv_"			+ attrName ];

							if ( result ) result = checkRegEx( attrData.uiObject, attrData.values );
							if ( result ) result = checkRegEx( attrData.mv,			attrData.values );
							if ( !result ) break;
						}
					}
					catch ( e )
					{
						debugger;
					}
					break;
				case "show":
				case undefined:
					debugger;
					break;
			}
			return ( result );
		}



</SCRIPT>
