<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_searchMask.jsp" --%>
<%-- used in ncs_Search --%>
<!-- inc_ncsSearch_searchMask.jsp start -->
<%-- ------------------------------------------------------------------------------------------------- --%>
<%-- process search options --%>
<%@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_parCheck.jsp" %>
<%-- ------------------------------------------------------------------------------------------------- --%>
<%
  String sBgColorHead                   = "bgcolor='#EEEEEE' ";
  // do we need to show a search base selector?
  int     iSearchBaseCount              = ncsUtilSearch.alSearchBase.size();
  
  boolean bSearch_ShowBaseSelector      = ( iSearchBaseCount != 1 );

  // do we want to show the search mask only, or compact display (mask & results)
  boolean bSearch_ShowMask        = ( req_Option_Value.equalsIgnoreCase( NcsUtilSearch.sOptionNone ) || xml_displayCompact || bSearch_ShowBaseSelector );

  // no attr to search for, hide mask (possible when the search filter contains all relevant info //  and xml_searchOnStart==true)
  boolean bSearch_HideAttrMask        = (( ncsUtilSearch.saAttrSearch.length == 0 ) || ( xml_searchLines == 0 ) || ( NcsUtil.stringEmpty( xml_searchAttr )));
  //if ( bSearch_HideAttrMask ) bSearch_ShowMask = false;

  ncsUtilSearch.saAttrLocal      = ncsUtilSearch.getLocalizedText( ncsUtilSearch.saAttrDisplay,  "Attribute.", ncsUtilSearch.searchProperties );   // level 1 display attr
  ncsUtilSearch.saAttrLocal2     = ncsUtilSearch.getLocalizedText( ncsUtilSearch.saAttrDisplay2, "Attribute.", ncsUtilSearch.searchProperties );   // level 2 display attr  
  
  if ( bSearch_ShowMask ) {
    session.setAttribute ( NcsUtil.sTempVar, "" );  // clear old session data
%>

<script type='text/javascript'>

  // store new group count in form field and reload
  function incGroupCount() 
  {
    var field = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_searchGroups_Name ) %>' )[0];
    if ( field !== null ) 
    {
      field.value = <%= String.valueOf( req_searchGroups_Value+1 ) %> ;
      //alert( 'incGroupCount: <%= String.valueOf( req_searchGroups_Value+1 ) %> / <%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_searchGroups_Name ) %>' );
      submitForm( '<%= NcsUtilSearch.sOptionNone %>' );
    }
  }

  // store number of group (to be deleted) in form field and reload
  function deleteGroup( sGroupNr ) 
  {
    var field1 = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_DelGrp_Name ) %>' )[0];
    var field2 = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_searchGroups_Name ) %>' )[0];
    //alert( 'deleteGroup: ' + sGroupNr + '/' + '<%= String.valueOf( req_searchGroups_Value -1 ) %>' );
    if ( field1 !== null ) 
    {
      field1.value = sGroupNr;
      if ( field2 !== null )
      {
        field2.value = '<%= String.valueOf( req_searchGroups_Value -1 ) %>';
      }
      submitForm( '<%= NcsUtilSearch.sOptionNone %>' );
    }
  }

  // store new line count for selected group in form field and reload
  function setLineCount ( sGroupName, sNewValue ) 
  {
    var field = document.getElementsByName( sGroupName )[0];
    if ( field !== null ) 
    {
      field.value = sNewValue;
      submitForm( '<%= NcsUtilSearch.sOptionNone %>' );
    }
  }

  // store number of group/line (to be deleted) in form field and reload
  function deleteLine( sGroupNr, sLineNr ) 
  {
    var field = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_DelLine_Name ) %>' )[0];
    if ( field !== null ) 
    {
      field.value = 1000*sGroupNr + sLineNr;
    }
  }

  //      <%--  make a tag or group visible or hide it --%>
  function makeVisible( sFieldname, bShow )
  { // target tag must include "style='visibility:visible;display:inline' or 'visibility:visible;display:none'"
    var field = document.getElementsByName( sFieldname )[0];
    if ( field === null ) return;
    field.style.visibility    = (( bShow ) ? 'visible' : 'hidden' );
    //problems with netscape -- cannot set display to none!
    //netscape wants to focus the field after setting display to none --> crash!!!
    //visibility=hidden still keeps a placeholder for the object --> no crash
    //field.style.display	  = (( bShow ) ? 'inline'  : 'none'   );
  }

  function trim(str)
  {
     return str.replace(/^\s*|\s*$/g,"");
  }

  function warnIfNeedsTrim( sFieldvalue )
  {
    var sMsg = '';
    if ( sFieldvalue !== trim(sFieldvalue) ) sMsg = 'Warning: Field begins/ends with blanks or tabs' ;
    if ( sMsg !== '' )                 alert( sMsg );
  }
</script>
<% } %>

<%-- ------------------------------------------------------------------------------------------------- --%>

  <%= NcsUtil.sInputBoxWithMemory ( request, "hidden", ncsUtilSearch.req_Option_Name, NcsUtilSearch.sOptionInit ) %>
  <%= NcsUtil.sInputBoxWithMemory ( request, "hidden", ncsUtilSearch.req_searchGroups_Name, String.valueOf( xml_searchGroups ) ) %>

  <%= HelperHtml.sInputBox ( "hidden", ncsUtilSearch.req_DelGrp_Name,   "", "" ) %>
  <%= HelperHtml.sInputBox ( "hidden", ncsUtilSearch.req_DelLine_Name,  "", "" ) %>

<%  if ( bSearch_ShowMask ) { %>

   <%= xml_textBeforeMask %>

   <% 
      String sTableBorder = "1";  // if we show the mask, use border.
      if ( bSearch_HideAttrMask && ( iSearchBaseCount == 1 )) sTableBorder = "0";
   %>
    <TABLE width='100%' border='<%= sTableBorder %>' rules=groups class="mediumtext" cellspacing='0'>

    <%-- html thead (visual: header titles) --%>
    <thead> 

    <%-- --------------------------------------------------------------------------- --%>

      <%-- searchBase --%>
      <% 
       if ( ncsUtilSearch.bDebug ) logger.info( "req_SearchBase_L=" + ncsUtilSearch.req_SearchBase_L );
       if ( ncsUtilSearch.bShowMaskWithSearchBase ) 
       {
          String sDefault_SearchBase   = "";
          // (re)calc search base ... // react appropriately, if 0, 1, or more search bases are given
          switch ( iSearchBaseCount )
          {
             case ( 0 ): // no search base specified: use object selector (transport base in req_SearchBase_E)
                c.set("OS.Control", ncsUtilSearch.req_SearchBase_E_Name);
                c.set("OS.TypeFilter", "[containers]");
                c.set("OS.History", "true");
                %>
                <TR valign=middle <%= sBgColorHead %><%= NcsUtil.css_data_tr %> >
                   <TD colspan='9'><b>&nbsp;<%= ncsUtilSearch.searchProperties.getProperty( ncsUtilSearch.sKey_colHead_searchBase ) %>:</b>&nbsp;&nbsp;&nbsp;
                      <INPUT type=text name="<%= ncsUtilSearch.req_SearchBase_E_Name %>" value="<%= ncsUtilSearch.req_SearchBase_E %>" size="<%= c.string("UI.textboxSize") %>" style="width:<%= c.string("UI.textboxPixel") %>" >
                      <jsp:include page='<%= c.getPath("dev/OS_inc.jsp") %>' flush="true" />
                   </TD>
                </TR>
                <TR  <%= sBgColorHead %><%= NcsUtil.css_data_tr %>><TD height="8" colspan='9'></TD></TR>
                <% 
                break;
             case ( 1 ): // one search base specified: use as hidden base (transport base in req_SearchBase_L)
                ncsUtilSearch.req_SearchBase_L = NcsUtil.stringCutAfterString( ncsUtilSearch.alSearchBase.get(0).toString(), "!" );
                %>
                <INPUT type=hidden name="<%= ncsUtilSearch.req_SearchBase_L_Name %>" value="<%= ncsUtilSearch.req_SearchBase_L %>" >
                <% 
                break;
             default: // multiple search bases specified: use drop down list (transport base in alSearchBase/req_SearchBase_L)
                if ( NcsUtil.stringEmpty( ncsUtilSearch.req_SearchBase_L )) // get the selected base from cookie
                {  // calc the default selection
                   // get from cookie
                   ncsUtilSearch.req_SearchBase_L = ncsUtilSearch.cookie_searchBase;
                   // get from requ with cookie as default
                   ncsUtilSearch.req_SearchBase_L = NcsUtil.getRequestAttribute( request, ncsUtilSearch.req_SearchBase_L_Name, ncsUtilSearch.req_SearchBase_L );
                   ncsUtilSearch.req_SearchBase_L = ncsUtilSearch.req_SearchBase_L.replace( '.', ',' );
                   ncsUtilSearch.req_SearchBase_L = ncsUtilSearch.req_SearchBase_L.replaceAll( "[']", "" );
                   sDefault_SearchBase = NcsUtil.ldap2dn( ncsUtilSearch.req_SearchBase_L );
                }
                %>
                <%-- take the list of LDAP names and display as dropdown list with default selection --%>
                <TR valign=middle  <%= sBgColorHead %><%= NcsUtil.css_data_tr %>>  
                    <TD colspan='9'><font style='width:200px'>  &nbsp;<%= ncsUtilSearch.searchProperties.getProperty( ncsUtilSearch.sKey_colHead_searchBase )%>:</font>&nbsp;&nbsp;&nbsp;
                      <%= NcsUtil.sListboxWithMemory( request, ncsUtilSearch.req_SearchBase_L_Name, ncsUtilSearch.alSearchBase, sDefault_SearchBase, "style='width:" + c.string("UI.textboxPixel") + "'" ) %>
                      <script type='text/javascript'> sortListbox( '<%= ncsUtilSearch.req_SearchBase_L_Name %>', 0 ); </script>
                    </TD>
                </TR>
                <TR <%= sBgColorHead %><%= NcsUtil.css_data_tr %>><TD height="8" colspan='9'></TD></TR>
                <% 
                break;
          }
       }
       %>

    <%-- --------------------------------------------------------------------------- --%>

      <%-- maxResults --%>
      <% 
       // maxResults is an optional config string (before 2008-11 an int) that may contain such info:
       //   a single value      e.g. "100"                  -> fixed max result count
       //   a list of values    e.g. "10|20|100|250|0!all"  -> selectable result max (values may have a different display value appended with "!")
       //   nothing                                         -> unlimited results
       if ( NcsUtilBasics.stringNotEmpty( xml_maxResults  ))
       {
          String[] saMaxResult = xml_maxResults.split( "[|]" );
          switch ( saMaxResult.length )
          {
             case ( 1 ):  // one value specified - use it, do not show anything
                %>
                <INPUT type=hidden name="<%= ncsUtilSearch.req_maxResults_Name %>" value="<%= ncsUtilSearch.req_maxResults %>" >
                <% 
                break;
             default:     // multiple value specified: create drop down list
                ArrayList alMaxResults = NcsUtilBasics.stringArrayToArrayList( saMaxResult );
                %>
                <TR valign=middle  <%= sBgColorHead %><%= NcsUtil.css_data_tr %>>  
                    <TD colspan='9'><font style="width:200px">  &nbsp;<%= ncsUtilSearch.searchProperties.getProperty( ncsUtilSearch.sKey_colHead_maxResults )%>:</font>&nbsp;&nbsp;&nbsp;
                      <%= NcsUtil.sListboxWithMemory( request, ncsUtilSearch.req_maxResults_Name, alMaxResults, ncsUtilSearch.req_maxResults, "style='width:" + c.string("UI.textboxPixel") + "'" ) %>
                    </TD>
                </TR>
                <TR <%= sBgColorHead %><%= NcsUtil.css_data_tr %>><TD height="8" colspan='9'></TD></TR>
                <%
                break;
          }
       }
      %>

    <%-- --------------------------------------------------------------------------- --%>

      <% if ( xml_searchGroups > 0 ) { %>
         <TR <%= NcsUtil.css_data_tr %>><TD height="8" colspan='9'></TD></TR>
         <tr align=left valign=bottom  <%= NcsUtil.css_data_tr %>>
            <th>&nbsp;</TH>
            <th><%= ncsUtilSearch.searchProperties.getProperty( "colHead.attribute" ) %></TH>
            <th><%= ncsUtilSearch.searchProperties.getProperty( "colHead.operatorValue" ) %></TH>
            <th><%= ncsUtilSearch.searchProperties.getProperty( "colHead.value" ) %></TH>
            <th><%= ncsUtilSearch.searchProperties.getProperty( "colHead.operatorValues" ) %></TH>
         </tr>
         <TR <%= NcsUtil.css_data_tr %>><TD height="8" colspan='9'></TD></TR>
      <% } %>
    </thead> 

    <%-- --------------------------------------------------------------------------- --%>

    <%-- html TFOOT (visual: body) --%>
    <TFOOT>

   <%
      if ( !bSearch_HideAttrMask ) 
		{

         for ( int iGroup=1; iGroup <= req_searchGroups_Value+1; iGroup++ ) 
         {
           String sGroup = ncsUtilSearch.sPrefixGrp + String.valueOf( iGroup );
           boolean isValidGroup    = ( iGroup <= req_searchGroups_Value );
           boolean isDynamicGroup  = ( iGroup >= 2 );
           boolean isFirstGroup    = ( iGroup == 1 );
      %>

         <tr valign=middle <%= sBgColorHead %><%= NcsUtil.css_data_tr %>>
         <TD valign=bottom align=center  >
           <%-- may not be allowed ... --%>
           <% if ( xml_searchAllowChange ) { %>
             <%-- button to remove group --%>
             <%= ncsUtilSearch.buttonDelGroup( isDynamicGroup && isValidGroup, iGroup, c.getModulesUrl() + "/ncsEMEA/images/minus.gif" ) %>
             <%-- button to add group --%>
             <%= ncsUtilSearch.buttonAddGroup( !isValidGroup,                          c.getModulesUrl() + "/ncsEMEA/images/plus.gif" ) %>
           <% } %> 
         </TD>
         <TD valign=middle colspan='3'>
           <%-- operator to combine groups --%>
           <% if ( isDynamicGroup && isValidGroup ) { %>
             <%= HelperHtml.sListboxWithMemory( request, ncsUtilSearch.sMakeLabel( iGroup, ncsUtilSearch.IGNORE_THIS, ncsUtilSearch.sPrefixGrpOp), ncsUtilSearch.sa2OperGroup, ncsUtilSearch.sa2OperGroup[1][2], "", 1, 2 ) %>
           <% } %> 
           <% if ( xml_searchAllowChange || isValidGroup ) { %> 
           &nbsp; <b><%= ncsUtilSearch.searchProperties.getProperty( "colHead.group" ) %> <%= String.valueOf( iGroup ) %> </b>
           <% } %> 
         </TD>
         <TD align=center valign=middle colspan='5'>&nbsp;</TD>
         </tr>

       <% if ( isValidGroup ) { %>

         <% // how many lines are displayed ?
           int req_Lines_Value      = NcsUtil.getRequestAttribute_asInt(  request, ncsUtilSearch.sMakeShiftedLabel( iGroup, ncsUtilSearch.IGNORE_THIS, ncsUtilSearch.sPrefixLine ), ( isFirstGroup ? xml_searchLines : 1 ));
           boolean isMultiLine     = (req_Lines_Value > 1);
         %>

         <%-- store line count of group --%>
         <%= NcsUtil.sInputBoxWithMemory ( request, "hidden", ncsUtilSearch.sMakeLabel( iGroup, ncsUtilSearch.IGNORE_THIS, ncsUtilSearch.sPrefixLine ), String.valueOf( req_Lines_Value ) ) %>

         <%
           for ( int iLine=0; iLine<req_Lines_Value; iLine++ ) 
           { // make one attribute line ... 
             String sLine = String.valueOf( iLine );
             boolean isFirstline       = ( iLine == 0 );
             boolean isLastline        = ( iLine == req_Lines_Value-1 );
             String  sCurrentAttr      = NcsUtil.getRequestAttribute ( request, ncsUtilSearch.sMakeShiftedLabel( iGroup, iLine, ncsUtilSearch.sPrefixAttr ),  ncsUtilSearch.getDefaultSelection( iLine, xml_searchAttr,            "Attribute.", ncsUtilSearch.searchProperties ) );
             String  sCurrentOperator  = NcsUtil.getRequestAttribute ( request, ncsUtilSearch.sMakeShiftedLabel( iGroup, iLine, ncsUtilSearch.sPrefixValOp ), ncsUtilSearch.getDefaultSelection( iLine, xml_searchOperatorDefault, "Operator.",  ncsUtilSearch.searchProperties ) );
             String  sCurrentInput     = NcsUtil.getRequestAttribute ( request, ncsUtilSearch.sMakeShiftedLabel( iGroup, iLine, ncsUtilSearch.sPrefixValTxt ), "" );
           %>
         <tr <%= sBgColorHead %><%= NcsUtil.css_data_tr %>>

         <TD valign=bottom align=center >
           <%-- may not be allowed ... --%>
           <% if ( xml_searchAllowChange ) { %>
             <%-- button to delete line - one line must remain --%>
             <%= ncsUtilSearch.buttonDelLine( ( isMultiLine ),  iGroup, iLine, req_Lines_Value, c.getModulesUrl() + "/ncsEMEA/images/minus.gif" ) %>
             <%-- button to delete last line and group - one group must remain --%>
             <%= ncsUtilSearch.buttonDelGroup(( !isFirstGroup && !isMultiLine ), iGroup,        c.getModulesUrl() + "/ncsEMEA/images/minus.gif" ) %>
           <% } %> 
         </TD>

         <TD>
           <%-- show attribute name: static text // or listbox --%>
            <%= HelperHtml.sListboxWithDefault( ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixAttr), ncsUtilSearch.sa2AttrSearch, sCurrentAttr, "", 0, 2 ) %>
         </TD>

         <TD>
           <%-- store operator --%>
           <% // operator for one attribute ... generate JS code to handle change
             String jsChangeOperatorFct  = "checkCombination_" + ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValOp ); 
             jsChangeOperatorFct         = jsChangeOperatorFct.replace('.', '_') + "()"; // make JS compliant
           %>
           <%-- show attribute operator list name --%>
            <%= HelperHtml.sListboxWithDefault( ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValOp), ncsUtilSearch.sa2OperAttr, sCurrentOperator, "onChange='javascript:" + jsChangeOperatorFct + ";'", 1, 2 ) %>

           <script type='text/javascript'>
             function <%= jsChangeOperatorFct %>
             {  // the operator for one attribute changed - make attribute input field [in]visible
               var sOp   = getFieldValueByName( '<%= ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValOp ) %>'); // operator
               var sValT = getFieldValueByName( '<%= ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValTxt ) %>'); // text value
               var sVal  = sValT;
               var bAllowValue = (( sOp === '<%= ncsUtilSearch.sInvalid %>' ) || ( sOp.indexOf( '<%= ncsUtilSearch.sSomeVal %>' ) >= 0 ));
               // alert ( sOp + " - " + bAllowValue );
               makeVisible( '<%= ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValTxt ) %>',  bAllowValue );
             }
           </script>
         </TD>

         <TD nowrap>
           <% String sScript = " onblur='warnIfNeedsTrim( this.value );' onKeyPress='if(event.keyCode==13) submitForm( \"" + NcsUtilSearch.sOptionSearch + "\" );'"; %>
           <%= NcsUtil.sInputBox( "text " + ncsUtilSearch.sVisible( true ), ncsUtilSearch.sMakeLabel( iGroup, iLine, ncsUtilSearch.sPrefixValTxt ), sCurrentInput, sScript )     %>
           <script type='text/javascript'>
             <%= jsChangeOperatorFct %>; // call JS to enable/disable input field dependent on operator
           </script>
         </TD>

         <TD>
           <%-- group internal operator --%>
           <% if ( isMultiLine && isFirstline ) { %> 
             <%= HelperHtml.sListboxWithMemory( request, ncsUtilSearch.sMakeLabel( iGroup, ncsUtilSearch.IGNORE_THIS, ncsUtilSearch.sPrefixLineOp ), ncsUtilSearch.sa2OperGroup, ncsUtilSearch.sa2OperGroup[0][2], "", 1, 2 ) %>
           <% } %> 

         <%-- may not be allowed ... --%>
         <% if ( xml_searchAllowChange ) { %>
           <%-- button to add line --%>
           <%= ncsUtilSearch.buttonAddLine( ( isLastline ), iGroup, req_Lines_Value, c.getModulesUrl() + "/ncsEMEA/images/plus.gif" ) %>
         <% } %>
         </TD>

         </tr>
           <% } // for each line %>
         <TR <%= NcsUtil.css_data_tr %>><TD height="8"></TD></TR>
         <% } // is valid group %>
      <% } // for each group %> 
   <% } %>
    
    
   <% 
      boolean bSearch_ShowAttributeSelector = xml_customReport && (!bSearch_HideAttrMask);
      if ( bSearch_ShowAttributeSelector ) { %>
   
      <TR <%= NcsUtil.css_data_tr %>><TD height="12"></TD></TR>
      <TR <%= NcsUtil.css_data_tr %>>         
        <TD height="8" colspan='5'> 
           <script type='text/javascript'>
              function changeVisibility( sField, bShow )
              { // initial stype must include "style='visibility:visible;display:inline' or 'visibility:visible;display:none' "
               var field = getFieldByNameOrId( sField );
               if ( field === null ) return;
               field.style.visibility  = (( bShow ) ? 'visible' : 'hidden' );
               field.style.display		= (( bShow ) ? 'inline'  : 'none'   );
              }

              function checkAllAttr( val )
              {
                for ( var i=0; i<document.forms[0].elements.length; i++ )
                {
                  var elem = document.forms[0].elements[i];
                  if ( elem.name.indexOf( '<%= ncsUtilSearch.sPrefixCheckbox %>') !== 0 ) continue;
                  if (elem.type === "checkbox")
                  {
                    elem.checked = val;
                  }
                }
              }
				  
				// save CB change when clicked
				function cbClick( )
				{
					//debugger;
					var arCookie		= [];
					for ( var i=0; i<document.forms[0].elements.length; i++ )
					{
						var elem = document.forms[0].elements[i];
						if ( elem.name.indexOf( '<%= ncsUtilSearch.sPrefixCheckbox %>') !== 0 ) continue;
						if (( elem.type === "checkbox" ) && elem.checked )
						{
							var attrName = elem.name.replace( '<%= ncsUtilSearch.sPrefixCheckbox %>', '' );
							arCookie.push( attrName );
						}
					}
					var sCookieName1	= "<%= ncsUtilSearch.cookiePrefix %>_saAttrDisplay";
					var sCookieVal1   = "|" + arCookie.join( "|" ) + "|" + "; expires="	+ dateAdd( null, 0, 3, 0 ).toGMTString();	
					document.cookie = sCookieName1 + "=" + sCookieVal1;
				}
				  
           </script>
           <b><%= xml_textBeforeCustomAttr %></b> &nbsp;
           <div name='customAttributes_contents' id='customAttributes_contents' style='visibility:visible;display:none' >
                 (
                <font style='cursor:pointer;' onclick='changeVisibility( "customAttributes_note", true );changeVisibility( "customAttributes_contents", false );'> 
                  <u><%= ncsUtilSearch.getCustomProperty( "search.customAttributes.hide", "Hide selection" )%></u>, 
                </font>
                <font style='cursor:pointer;' onclick='checkAllAttr( true );'> 
                  <u><%= ncsUtilSearch.getCustomProperty( "search.customAttributes.select",   "Check all" ) %></u>, 
                </font>
                <font style='cursor:pointer;' onclick='checkAllAttr( false );'> 
                  <u><%= ncsUtilSearch.getCustomProperty( "search.customAttributes.deselect", "Uncheck all" ) %></u>
                </font>
                 )
                 <%=  ncsUtilSearch.selectCustomDisplayAttr_mask( ) %>
           </div>
           <div name='customAttributes_note' id='customAttributes_note' style='visibility:visible;display:inline' >
              <font style='cursor:pointer;' onclick='changeVisibility( "customAttributes_note", false );changeVisibility( "customAttributes_contents", true );'> 
                 (<u><%= ncsUtilSearch.getCustomProperty( "search.customAttributes.show", "Show/Change selection" ) %></u>) 
              </font>
           </div>
        </TD>
      </TR>
   <% } // xml_customReport %>
    </TFOOT>
    <%-- html tbody (visual: empty) --%>  <tbody> </tbody>
</table>

    <p>
    <%= ncsUtilSearch.searchProperties.getProperty( xml_textAfterMask, "" ) %>
    <iman:bar/>
    <script type='text/javascript'>
  
		//<%--
		//      * submit the form to reload or to create
		//      * example:  submitForm( 'xxx' );
		//--%>    
		function submitForm( sOption ) 
		{
			var form = document.forms[0];
			// store requested action to form field
			var field = document.getElementsByName( '<%= ncsUtilSearch.sMakeLabel( ncsUtilSearch.req_Option_Name ) %>' )[0];
			field.value  = sOption;
			<%-- reset to default, in case we reload the page and have modified GI_ID in the meantime --%>
			var GI_ID         = getFieldByNameOrId( "GI_ID" );
			if ( GI_ID !== null )  GI_ID.value       = '<%= ncs_thisTaskId %>';
			form.submit();        
		}

  </script>
	<%-- show search & cancel button --%>
   <% if ( !( bSearch_HideAttrMask && ( !bSearch_ShowBaseSelector ) && xml_searchOnStart )) { %>  
       <a href="#" onClick="javascript:submitForm( '<%= NcsUtilSearch.sOptionSearch %>');" >
       <IMG src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Search.image") %>"   alt="<%= c.string("Button.Search.alt") %>"     title="<%= c.string("Button.Search.alt") %>"      border=0></A>
       <% if ( !bSelectorPopup ) { %><iman:cancelBtn/><% } %>
   <% } %>

<% } %>

<!-- inc_ncsSearch_searchMask.jsp end -->
