<%--
shared task

  <task>
      <id>task_ncsReplaceValues</id>
      <info>simple task: one jsp - multiple loads</info>
      <version>2.0.0</version>
      <required-version>2.0.0</required-version>
      <class-name>com.novell.emframe.dev.EmptyTask</class-name>
      <merge-template>ncsEMEA.task_ncsReplaceValues</merge-template> 
      <display-name-key>task_ncsReplaceValues</display-name-key>
      <description-key>task_ncsReplaceValues</description-key>
      <resource-properties-file>com.novell.ncsDemo.resources</resource-properties-file>
      <role-assignment>ncsDemo_roles_ncsDemoRole</role-assignment>
      <url-param>
          <param-key>attributes</param-key>
          <param-value>Given Name|Full Name|Telephone Number|Facsimile Telephone Number</param-value>
      </url-param>
      <url-param>
          <param-key>operations</param-key>
          <param-value>valueAdd|valueDel|valueRepl|valueSet|valueClear|valueReplSubstring</param-value>
      </url-param>
      <url-param>
          <param-key>confirmation</param-key>
          <param-value>true</param-value>
      </url-param>
      <url-param>
          <param-key>resource-properties-file</param-key>
          <param-value>com.novell.ncsEMEA.resources</param-value>
      </url-param>
      <url-param>
          <param-key>rememberInput</param-key>
          <param-value>true</param-value>
      </url-param>
  </task>
  
properties:
  


attributes.header.init=Attribute Change - Choose the desired operation
attributes.header.doPreview=Attribute Change - Current values
attributes.header.doOperation=Attribute Change - Change results

attributes.selection.valueAdd=Add Value
attributes.selection.valueDel=Delete Value
attributes.selection.valueSet=Set Value
attributes.selection.valueClear=Clear Values
attributes.selection.valueRepl=Replace Value
attributes.selection.valueReplSubstring=Replace Value Substring

attributes.selection.header=Select Attribute to change
attributes.selection.prompt=Attribute
attributes.operations.header=Select Attribute Operation
attributes.operations.prompt=Operation
attributes.value.display=Attribute Value
attributes.attrValOld.display=Attribute Value
attributes.attrValNew.display=New Value

attributes.values.current=Current Attribute Values
attributes.values.change=Attribute Change Results


  
  
--%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>

<% 
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>
<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>
<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>
<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>

<BODY>
   <% 
      NcsUtilBasics.garbageCollection( 10000000 ); // req'ed if we have many objects
      boolean        bRememberInput = NcsUtil.getRequestParameter( request, "rememberInput",    "false" ).equalsIgnoreCase( "TRUE" );
      String         sPropertyFile  = NcsUtil.getRequestParameter( request, "resource-properties-file", "" );
      NcsProperties  ncsCustom      = new NcsProperties( sPropertyFile + ".properties", request );
      ncsCommon.setPropertyFileName( sPropertyFile + ".properties" );

      c.set("TaskHeader.iconUrl", "dir/Person.gif");
      c.set("TaskHeader.title",   ncsCustom.getProperty( ncs_thisTaskId, ncs_thisTaskId ));
      c.set("TaskHeader.iconAlt", ncs_thisTaskId ); // ncs_thisTaskId )); 
    %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

<%!
  
   final String OP_ADD        = "valueAdd";
   final String OP_SET        = "valueSet";
   final String OP_DEL        = "valueDel";
   final String OP_CLR        = "valueClear";
   final String OP_REP        = "valueRepl";
   final String OP_SUB        = "valueReplSubstring";

   final String KEY_ATTRNAME  = "attrName";
   final String KEY_ATTROPER  = "attrOper";
   final String KEY_VALOLD    = "attrValOld";
   final String KEY_VALNEW    = "attrValNew";
   
   
   public boolean showAttrValOld( String sAttrOper )
   {
      return ( sAttrOper.equals( OP_DEL ) || sAttrOper.equals( OP_REP ) || sAttrOper.equals( OP_SUB ) );
   }

   public boolean showAttrValNew( String sAttrOper )
   {
      return ( sAttrOper.equals( OP_ADD ) || sAttrOper.equals( OP_SET ) || sAttrOper.equals( OP_REP ) || sAttrOper.equals( OP_SUB ) );
   }
   
   public boolean allowOperation( String sAttrName, String sAttrOper, String sAttrValOld, String sAttrValNew )
   {
      boolean result = true;
      if ( NcsUtil.stringEmpty( sAttrName )) result = false;
      if ( NcsUtil.stringEmpty( sAttrOper )) result = false;

      if ( sAttrOper.equals( OP_ADD ) && sAttrValNew.equals( "" ) ) result = false;
      if ( sAttrOper.equals( OP_DEL ) && sAttrValOld.equals( "" ) ) result = false;
      if ( sAttrOper.equals( OP_REP ) && sAttrValOld.equals( "" ) ) result = false;
      if ( sAttrOper.equals( OP_SUB ) && sAttrValOld.equals( "" ) ) result = false;
      return ( result );
   }
   
%>

<%
   String     sCurrentAction  = "init";
   String     sNextAction     = "";
   String     sPrevAction     = "";
   boolean    bShowCancel     = true;
   boolean    bShowNext       = true;
   boolean    bShowOK         = false;
   boolean    bShowBack       = false;
   boolean    bShowDone       = false;
   boolean    bShowRepeat     = false;

   boolean    bAllowOperation   = true;

   sCurrentAction                = NcsUtil.getRequestParameter( request, "sNextAction",   "init" );

   c.stringTable( sPropertyFile );

   ArrayList  arCarryOver     = new ArrayList(); 
   String sAttrName           =  NcsUtil.getRequestAttribute( request, KEY_ATTRNAME,      "", arCarryOver, !sCurrentAction.equalsIgnoreCase("init") );
   String sAttrOper           =  NcsUtil.getRequestAttribute( request, KEY_ATTROPER,      "", arCarryOver, !sCurrentAction.equalsIgnoreCase("init") );
   String sAttrValOld         =  NcsUtil.getRequestAttribute( request, KEY_VALOLD,        "", arCarryOver, !sCurrentAction.equalsIgnoreCase("init") );
   String sAttrValNew         =  NcsUtil.getRequestAttribute( request, KEY_VALNEW,        "", arCarryOver, !sCurrentAction.equalsIgnoreCase("init") );
   
   // if not passed in request, check for last time use ...
   if ( bRememberInput )
   {
      if ( NcsUtil.stringEmpty( sAttrName ))   sAttrName    = NcsUtil.getCookieValueByName( request, "sAttrName",   sAttrName );
      if ( NcsUtil.stringEmpty( sAttrValOld )) sAttrValOld  = NcsUtil.getCookieValueByName( request, "sAttrValOld", sAttrValOld );
      if ( NcsUtil.stringEmpty( sAttrValNew )) sAttrValNew  = NcsUtil.getCookieValueByName( request, "sAttrValNew", sAttrValNew );      
   }

   request.setAttribute( "arCarryOver", arCarryOver );
   NcsObject[] ncsTargets = ncsCommon.getTargets();
   StringBuffer   sbDisplay         = new StringBuffer( 30 );

   // state: init ... vars
   String         init_sAttrList   = NcsUtil.CRLF;      
   String         init_sOperList   = NcsUtil.CRLF;
   String         init_sOperHelp   = NcsUtil.CRLF;
   String         init_sOperInit   = NcsUtil.CRLF;
   String         init_sHintArray  = NcsUtil.CRLF;

   
   out.flush();

   // determine current state and calculate req'ed information ...
   if ( sCurrentAction.equalsIgnoreCase( "init" ) ) 
   {
      for ( int i=0; i<ncsTargets.length; i ++ )
      {
         sbDisplay.append( "<li>&nbsp;" + NcsUtil.getClassImg( request, ncsTargets[i].getType() ) + "&nbsp;" + ncsTargets[i].getDn() + "</li>" + NcsUtil.CRLF );
      }
      // display possible attributes
      ArrayList   alAttr      = NcsUtil.stringToArrayList( NcsUtil.getRequestParameter( request, "attributes", "" ), "[|]" );
      for ( int i=0; i<alAttr.size(); i++ )
      {
         String sAttrItem        = alAttr.get(i).toString();
         
         NDSAttributeDefinition  attrDef     = (NDSAttributeDefinition) ncsCommon.getTree().getNs().getAttributeDefinition( ncsCommon.getTree().getOe(), sAttrItem );
         //out.println( attrDef.getSyntax().getId() + ": " + attrDef.getSyntax().getName() + "<br>" + NcsUtilBasics.CRLF );
         
         init_sHintArray          += ( i==0 ? "'" : ", '" ) + ncsCustom.getProperty( "Attribute." + sAttrItem + ".hint.format", "" ) + "'";

         
         
         
         
         String sDisplayName  = ncsCustom.getProperty( "Attribute." + sAttrItem, sAttrItem );
         boolean bSelected    = ( sAttrItem.equalsIgnoreCase( sAttrName ));   // use selected as default
         //out.println( "Attribute." + sAttrItem + "=" + sAttrName + " - " + String.valueOf( bSelected ) + "<br>" + NcsUtil.CRLF );
         if ( sAttrOper.equals( "" ) ) bSelected = ( i == 0 );             // nothing selected, use first entry
         init_sAttrList            += "<OPTION value='" + sAttrItem + "' " + ( bSelected ? " SELECTED " : "" ) + "/>" + sDisplayName + "<br>" + NcsUtil.CRLF;
      }
      // display possible operations
      ArrayList   alOper      = NcsUtil.stringToArrayList( NcsUtil.getRequestParameter( request, "operations", "" ), "[|]" );
      for ( int i=0; i<alOper.size(); i++ )
      {
         String sOperItem        = alOper.get(i).toString();
         String sDisplayName  = ncsCustom.getProperty( "attributes.selection." + sOperItem, sOperItem );
         boolean bSelected    = ( sOperItem.equalsIgnoreCase( sAttrOper ));   // use selected as default
         if ( sAttrOper.equals( "" ) ) bSelected = ( i == 0 );             // nothing selected, use first entry
         if ( bSelected ) init_sOperInit = "showInputFields( '" + sOperItem + "' );"; // display on initial load
         init_sOperList       += "<INPUT TYPE='RADIO' onclick='showInputFields( this.value );' name='" +KEY_ATTROPER + "' value='" + sOperItem + "' " + ( bSelected ? " CHECKED " : "" ) + ">" + sDisplayName + "<br>" + NcsUtil.CRLF;
         // generate hint lines ...
         String sOperHelpKey  = "attributes.selection." + sOperItem + ".help";
         init_sOperHelp       += "<div id='attrRow_" + sOperItem +"' style='visibility:" + ( bSelected ? "visible" : "hidden" ) + "'>"
                              +  sDisplayName + ": " + c.string( sOperHelpKey ) 
                              +  "</div>" + NcsUtil.CRLF;
      }
   }

   if ( sCurrentAction.equalsIgnoreCase( "doPreview" ) ) 
   {
      bAllowOperation   = allowOperation( sAttrName, sAttrOper, sAttrValOld, sAttrValNew );
     if ( !bAllowOperation )
     {
        bShowNext = false;
        sbDisplay.append( "<h2><font color='red'>" + c.string( "attributes.operations.invalid") + "</font></h2><br>" );
     }
      for ( int i=0; i<ncsTargets.length; i ++ )
      {
         NcsObject   ncsObject   = ncsTargets[i];
         String      sAttrVal    = NcsUtil.getAttrAsString( ncsCommon.getTree().getOe(), ncsObject.getOe(), sAttrName );
         sbDisplay.append( "<tr>" );
         sbDisplay.append(    "<td>&nbsp;" + NcsUtil.getClassImg( request, ncsObject.getType() ) + "&nbsp;" + ncsObject.getDn()   + "&nbsp;</td>" );
         sbDisplay.append(    "<td>&nbsp;" + sAttrVal            + "</td>" );
         sbDisplay.append( "</tr>" + NcsUtil.CRLF );
      }
   }

   if ( sCurrentAction.equalsIgnoreCase( "doOperation" ) ) 
   {
     bAllowOperation = allowOperation( sAttrName, sAttrOper, sAttrValOld, sAttrValNew );
     if ( !bAllowOperation )
     {
        sbDisplay.append( "<h2><font color='red'>" + c.string( "attributes.operations.invalid") + "</font></h2><br>" );
     }
     else
     {
         int iOption = -1;
         if ( sAttrOper.equals( OP_ADD )) iOption = NcsUtil.ATTR_ADD_VALUE;
         if ( sAttrOper.equals( OP_REP )) iOption = NcsUtil.ATTR_REPLACE_VALUE;
         if ( sAttrOper.equals( OP_DEL )) iOption = NcsUtil.ATTR_DEL_VALUE;
         if ( sAttrOper.equals( OP_CLR )) iOption = NcsUtil.ATTR_CLEAR_VALUES;
         if ( sAttrOper.equals( OP_SET )) iOption = NcsUtil.ATTR_SET_VALUE;
         if ( sAttrOper.equals( OP_SUB )) iOption = 99;
         
         for ( int i=0; i<ncsTargets.length; i ++ )
         {
            NcsObject ncsObject = ncsTargets[i];
            HelperResult ncsResult = new HelperResult();
            ArrayList   alAttrVal1   = NcsUtil.getAttrArrayList( ncsCommon.getTree().getOe(), ncsObject.getOe(), sAttrName );
            String      sAttrVal1    = NcsUtil.arrayListToString( alAttrVal1, ";" );
            switch ( iOption ) 
            {
               case NcsUtil.ATTR_ADD_VALUE:
               case NcsUtil.ATTR_SET_VALUE:
               case NcsUtil.ATTR_REPLACE_VALUE:
               case NcsUtil.ATTR_DEL_VALUE:
               case NcsUtil.ATTR_CLEAR_VALUES:
                     ncsResult = NcsUtil.modAttributeValue3( ncsCommon.getTree().getOe(), ncsObject.getOe(), sAttrName, sAttrValOld, sAttrValNew, iOption );
                     break;
               case 99:
                     if ( sAttrVal1.indexOf( sAttrValOld ) >=0 )
                     {
                        for ( int iVal=0; iVal<alAttrVal1.size(); iVal++ )
                        {
                           String sValOld = alAttrVal1.get(iVal).toString();
                           String sValNew = NcsUtil.stringReplaceAll( sValOld, sAttrValOld, sAttrValNew );
                           logger.debug( sValOld + " -> " + sValNew );
                           if ( sValOld.equals( sValNew )) continue;
                           // replace each - don't collect each result ...
                           ncsResult = NcsUtil.modAttributeValue3( ncsCommon.getTree().getOe(), ncsObject.getOe(), sAttrName, sValOld, sValNew, NcsUtil.ATTR_REPLACE_VALUE );
                        }
                     }
                     break;
               case -1:
                     break;
            }
            logger.info( ncsCommon.getUser().getDn() + "->" + ncsObject.getDn() + " (" + sAttrOper + " " + sAttrName + "): '" + sAttrValOld + "' -> '" + sAttrValNew + "' - " + ( ncsResult.getSuccess() ? "success" : "error" ) );

            String sAttrVal2  = NcsUtil.getAttrAsString( ncsCommon.getTree().getOe(), ncsObject.getOe(), sAttrName );
            String sImg          = NcsUtil.getButtonImg( request, "", ( ncsResult.getSuccess() ? "success16" : "error16" ), ( ncsResult.getSuccess() ? "success" : "error" ) ); 
            String sInfo      = sImg + "&nbsp;" + ( ncsResult.getSuccess() ? "" : ncsResult.getResult() );

            
            sbDisplay.append( "<tr>" );
            sbDisplay.append(    "<td nowrap>&nbsp;" + NcsUtil.getClassImg( request, ncsObject.getType() ) + "&nbsp;" + ncsObject.getDn()     + "&nbsp;</td>" );
            sbDisplay.append(    "<td nowrap>&nbsp;" + sAttrVal1             + "</td>" );
            sbDisplay.append(    "<td nowrap>&nbsp;" + sAttrVal2             + "</td>" );
            sbDisplay.append(    "<td nowrap>&nbsp;" + sInfo                 + "</td>" );
            sbDisplay.append( "</tr>" + NcsUtil.CRLF );
         }
     }
   }
%>
   
<FORM name="Next" method=post action="webacc">
      <%-- optional: carry over custom vars ... --%>
      <c:forEach var="arCarryOver" items="${arCarryOver}">
         <c:out value="${arCarryOver}" escapeXml="false" />
      </c:forEach>

      <%-- required ... --%>
      <input type='hidden' name='GI_ID'         value='<%= ncs_thisTaskId %>'>

      <%-- required for EmptyTask - if specified here, the page reloads after submit(), otherwise it exits --%>
      <INPUT type='hidden' name='nextState'     value='initialState'>

      <%-- optional: error page ... --%>
      <INPUT type='hidden' name='error'         value='dev.GenErr'>

      <%-- optional: pass some variable ... --%>
      <INPUT type='hidden' name='ncs_option'    value='111'>

      <%-- optional: carry target names between pages ... --%>
      <INPUT type="hidden" name="<%= NcsUtil.sTargetNames %>"     VALUE="<%= eMFrameUtils.toTag( NcsUtil.getRequestAttribute( request, NcsUtil.sTargetNames, "" )) %>">  

     <br>

     <script type='text/javascript'>
         <%-- show correct number of input fields, dependent on operation --%>
         
         // optional: show an attribut specific hint from proerty file
         function showAttrHint( )
         {
            makeVisible( 'attrHint', true );
            var hintArray = new Array( <%= init_sHintArray %> );
         
            var form      = document.forms[0];
            var idx       = form.<%= KEY_ATTRNAME %>.selectedIndex;
            if ( idx <= hintArray.length ) 
            {
              document.getElementById( 'attrHint' ).firstChild.data = hintArray[idx];
              // alert( form.<%= KEY_ATTRNAME %>.selectedIndex + ': ' + form.<%= KEY_ATTRNAME %>.value + ' / ' + document.getElementById( 'attrHint' ).firstChild.data + '/' + document.getElementById( 'attrHint' ).data );
            }
         }
         
         function showInputFields( sAttrOper )
         {
            //alert ( sAttrOper );
            bShowValOld = (( sAttrOper == '<%= OP_DEL %>' ) || ( sAttrOper == '<%= OP_REP %>' ) || ( sAttrOper == '<%= OP_SUB %>' ));  
            makeVisible( 'attrRowOld', bShowValOld );
            bShowValNew = (( sAttrOper == '<%= OP_ADD %>' ) || ( sAttrOper == '<%= OP_SET %>' ) || ( sAttrOper == '<%= OP_REP %>' ) || ( sAttrOper == '<%= OP_SUB %>' ));  
            makeVisible( 'attrRowNew', bShowValNew );
            showOperatorHelp( sAttrOper );
         }
         
         
         function showOperatorHelp( sAttrOper )
         {
            //alert ( sAttrOper );
            makeVisible( 'attrRow_<%= OP_ADD %>' , ( sAttrOper == '<%= OP_ADD %>' ) );
            makeVisible( 'attrRow_<%= OP_DEL %>' , ( sAttrOper == '<%= OP_DEL %>' ) );
            makeVisible( 'attrRow_<%= OP_SUB %>' , ( sAttrOper == '<%= OP_SUB %>' ) );
            makeVisible( 'attrRow_<%= OP_SET %>' , ( sAttrOper == '<%= OP_SET %>' ) );
            makeVisible( 'attrRow_<%= OP_REP %>' , ( sAttrOper == '<%= OP_REP %>' ) );
            makeVisible( 'attrRow_<%= OP_CLR %>' , ( sAttrOper == '<%= OP_CLR %>' ) );
         }
         
     </script> 
        
     <h3><%= c.string( "attributes.header." + sCurrentAction ) %></h3>

     <p><br><p>
          
<%
   // determine current state and perform specific action
   if ( sCurrentAction.equalsIgnoreCase( "init" ) ) 
   {
%>
     

     <table border="0" width="100%">
      <colgroup><col width='20%'/><col width='33%'/><col/></colgroup>
      <%-- display attribute as drop down list --%>
       <tr class='css_data_tr1'>
            <td colspan='3' nowrap align="left"><%= NcsUtil.getButtonImg( request, "", "highlight_arrow", "Select" ) %> &nbsp;<b><%= c.string( "attributes.selection.header") %></b></td>
       </tr>
       <tr>
            <td>&nbsp;<%= c.string( "attributes.selection.prompt") %>:&nbsp;</td>
            <td>
                <SELECT   ONCHANGE='showAttrHint();' ONBLUR='showAttrHint();' name='<%= KEY_ATTRNAME %>' id='<%= KEY_ATTRNAME %>'>
                  <%= init_sAttrList %>   
                </SELECT>
            </td>
            <td id='attrHint' class="mediumtext">&nbsp;</td>
            <script type='text/javascript'>showAttrHint( ); </script>
       </tr>

       <tr><td height="12"></td></tr>
      
      <%-- display change operations as radio button list--%>
       <tr class='css_data_tr1'>
         <td colspan='3' nowrap><%= NcsUtil.getButtonImg( request, "", "highlight_arrow", "Select" ) %> &nbsp;<b><%= c.string( "attributes.operations.header") %></b></td>
       </tr>
       <tr>
            <td width='25%'>&nbsp;<%= c.string("attributes.operations.prompt") %>:&nbsp;</td>
            <td width='33%'><%= init_sOperList %></td>            
            <td valign='top'>
                <table border='0' width='100%'>
                  <colgroup><col width='50%'><col width='50%'></colgroup>
                   <tr id='attrRowOld' style='visibility:visible'>
                     <td><input type='text' name='<%= KEY_VALOLD %>' value='<%= sAttrValOld %>'></td>
                     <td nowrap><%= c.string( "attributes.attrValOld.display") %></td>
                   </tr>
                   <tr id='attrRowNew' style='visibility:hidden'>
                     <td><input type='text' name='<%= KEY_VALNEW %>' value='<%= sAttrValNew %>'></td>
                     <td nowrap><%= c.string( "attributes.attrValNew.display") %></td>
                   </tr>
               </table>
            </td>            
            <script type='text/javascript'><%= init_sOperInit %><%-- restore original value --%></script>
       </tr>
       
       <tr>
            <td colspan="3" nowrap>&nbsp;<%= c.string("attributes.operations.help") %>:&nbsp;</td>
       </tr>
       <tr>
            <td colspan="3"><%= init_sOperHelp %> </td>
       </tr>
       
<%--
      // debug: show current cookies
      Cookie[]       cookies     = request.getCookies();
      if ( cookies != null ) 
      {
         String         sCookiePrefix  = NcsUtil.getRequestAttribute( request, "GI_ID", "cookie" );
         out.println( "<table>" );
         for ( int i=0; i<cookies.length; i++ )
         {
            out.println( 
                  "<tr><td>" + cookies[i].getName() + "</td><td>"
               + (( cookies[i].getName().indexOf( sCookiePrefix ) >= 0 ) ? "<b>" : "" )
               + cookies[i].getValue() 
               + (( cookies[i].getName().indexOf( sCookiePrefix ) >= 0 ) ? "</b>" : "" )
               + "</td></tr>" );
         }
         out.println( "</table>" );
      }
--%>
       
       <tr><td colspan='3' height="12"></td></tr>
     </table>
     
   <p><br><p>     

     <%-- show selected objects --%>
     <table border='0' frame='box'  rules="groups">
        <thead>
            <tr bgcolor="#DDDDDD"><th nowrap align="left"><%= NcsUtil.getButtonImg( request, "", "dir/object16", "Objects" ) %> &nbsp;<b><%= c.string( "attributes.objects.header") %> (<%= ncsTargets.length %>)</b></th></tr>
        </thead>
        <tbody>
            <tr bgcolor="#EEEEEE"><td nowrap align="left"><ul><%= sbDisplay.toString() %></ul></td></tr>
        </tbody>
     </table>       
 
<% } %>

<%
   if ( sCurrentAction.equalsIgnoreCase( "doPreview" ) ) 
   {
%>
      <%-- remember the selection ... --%>
      <% if ( bRememberInput ) { %>
         <%= NcsUtil.setCookieScript( request, "sAttrName",    sAttrName ) %>
         <%= NcsUtil.setCookieScript( request, "sAttrValOld",  sAttrValOld ) %>
         <%= NcsUtil.setCookieScript( request, "sAttrValNew",  sAttrValNew ) %>
      <% } %>

     <table border='1' frame='box' rules="none">
       <%-- display current attribute values --%>
       <tr class='css_data_tr1' bgcolor="#DDDDDD"><th colspan='2' nowrap align="left"><b><%= c.string( "attributes.values.current") %></b></th></tr>
       <tr bgcolor="#EEEEEE">
         <th nowrap align="left"><%= c.string( "Attribute.dn") %></th>
         <th nowrap><%= ncsCustom.getProperty( "Attribute." + sAttrName ) %></th>
       </tr>
       <%= sbDisplay.toString() %>
      </table>       

   <p><br><p>      
      
     <table border='0' frame='box' rules="rows">
       <tr>
         <td>&nbsp;<%= c.string( "attributes.operations.prompt" ) %>:&nbsp;</td>
         <td>&nbsp;<%= c.string( "attributes.selection." + sAttrOper ) %></td>
       </tr>
    <% if ( showAttrValOld( sAttrOper )) { %>
       <tr>
         <td>&nbsp;<%= c.string( "attributes.attrValOld.display" ) %>:&nbsp;</td>
         <td>&nbsp;<%= sAttrValOld %></td>
       </tr>
    <% } %>
    <% if ( showAttrValNew( sAttrOper )) { %>
       <tr>
         <td>&nbsp;<%= c.string( "attributes.attrValNew.display" ) %>:&nbsp;</td>
         <td>&nbsp;<%= sAttrValNew %></td>
       </tr>
    <% } %>
         
     </table>       
<% } %>

<%
   if ( sCurrentAction.equalsIgnoreCase( "doOperation" ) ) 
   {
     if ( !bAllowOperation )
     { %>        
       <%= sbDisplay.toString() %>
<%   } else { %>
     <table border='0' frame='box' rules="rows">
        <%-- display current attribute values --%>
        <tr class='css_data_tr1' bgcolor="#DDDDDD"><th colspan='4' nowrap align="left"><b><%= c.string( "attributes.values.change") %></b></th></tr>
        <tr bgcolor="#EEEEEE">
          <th nowrap align="left"><%= c.string( "Attribute.dn") %></th>
          <th align="center" nowrap><%= ncsCustom.getProperty( "Attribute." + sAttrName ) %><br><%= c.string( "attributes.attrValOld.display" ) %></th>
          <th align="center" nowrap><%= ncsCustom.getProperty( "Attribute." + sAttrName ) %><br><%= c.string( "attributes.attrValNew.display" ) %></th>
          <th align="center" nowrap>&nbsp;</th>
        </tr>
        <%= sbDisplay.toString() %>
      </table>
<%   }
   }

%>     

<%--@ include file="/portal/modules/ncsEMEA/include/helperDebug.jsp" --%>

<%  // (dis)enable buttons
   if ( sCurrentAction.equalsIgnoreCase( "init" ) ) {
      bShowNext         = bAllowOperation;  
      bShowOK           = false; // bAllowOperation;  
      bShowBack         = NcsUtil.stringEmpty( NcsUtil.getRequestParameter( request, "sNextAction", "" ));  
      bShowCancel       = true;  
      sNextAction       = "doPreview"; // "doOperation"; // "init"; // 
      sPrevAction       = "";
   } 
   if ( sCurrentAction.equalsIgnoreCase( "doPreview" ) ) {
      bShowNext         = bAllowOperation;  
      bShowOK           = false; // bAllowOperation;  
      bShowBack         = true;  
      bShowCancel       = true;  
      sNextAction       = "doOperation"; // "init"; // "doPreview"; // 
      sPrevAction       = "init";
   } 
   if ( sCurrentAction.equalsIgnoreCase( "doOperation" ) ) {
      bShowNext         = false;  // false; // 
      bShowOK           = false; // true;  // 
      bShowBack         = true;  // false; // 
      bShowDone         = true;
      bShowRepeat       = true;
      bShowCancel       = false;  
      sNextAction       = "init"; 
      sPrevAction       = "init";
   } 
%>     
   <input type="hidden" name="sNextAction" value='<%= sNextAction %>'>

     
<!--
     <hr>
     <table border="1">
       <tr><td colspan='2'><b><%= ncs_Date %></b></td></tr>
       <tr><td>taskId</td>             <td><%= ncs_thisTaskId %></td></tr>
       <tr><td>ncs_thisJspId</td>      <td><%= ncs_thisJspId %></td></tr>
       <tr><td>ncs_initialJsp</td>     <td><%= NcsUtil.getRequestParameter( request, "ncs_initialJsp",      "" )     %></td></tr>
       <tr><td>ncs_taskOption</td>     <td><%= NcsUtil.getRequestAttribute( request, "ncs_taskOption",      "n/a" )  %></td></tr>
       <tr><td>ncs_thisJsp</td>        <td><%= ncs_thisJsp %></td></tr>
       <tr><td>ncs_taskState</td>      <td><c:out value="${ncs_taskState}"/></td></tr>
       <tr><td>sNextAction</td>        <td><%= sNextAction     %></td></tr>
       <tr><td>someOption</td>         <td><%= NcsUtil.getRequestAttribute( request, "someOption",   "n/a" )  %></td></tr>
       <tr><td>targetNames</td>        <td><%= NcsUtil.getRequestAttribute( request, "targetNames",   "n/a" )  %></td></tr>

       <tr><td>attributes</td>         <td><%= NcsUtil.getRequestParameter( request, "attributes",      "" )     %></td></tr>
       <tr><td>operations</td>         <td><%= NcsUtil.getRequestParameter( request, "operations",      "" )     %></td></tr>
       <tr><td>confirmation</td>       <td><%= NcsUtil.getRequestParameter( request, "confirmation",    "" )     %></td></tr>
       <tr><td>rememberInput</td>      <td><%= NcsUtil.getRequestParameter( request, "rememberInput",   "" )     %></td></tr>
       <tr><td>resource-prop-file</td> <td><%= NcsUtil.getRequestParameter( request, "resource-properties-file",      "" )     %></td></tr>
       <tr><td>sAttrName</td>          <td><%= sAttrName %></td></tr>
       <tr><td>sAttrOper</td>          <td><%= sAttrOper %></td></tr>
       <tr><td>sAttrValOld</td>        <td><%= sAttrValOld %></td></tr>
       <tr><td>sAttrValNew</td>        <td><%= sAttrValNew %></td></tr>
       <tr><td>sCurrentAction:</td>    <td><%= sCurrentAction %></td></tr>
       <tr><td>sPrevAction:</td>       <td><%= sPrevAction %></td></tr>
       <tr><td>sNextAction</td>        <td><%= sNextAction %></td></tr>

       <tr><td>bShowCancel</td>        <td><%= String.valueOf( bShowCancel ) %></td></tr>
       <tr><td>bShowNext</td>          <td><%= String.valueOf( bShowNext ) %></td></tr>
       <tr><td>bShowOK</td>            <td><%= String.valueOf( bShowOK ) %></td></tr>
       <tr><td>bShowBack</td>          <td><%= String.valueOf( bShowBack ) %></td></tr>
       <tr><td>bShowDone</td>          <td><%= String.valueOf( bShowDone ) %></td></tr>

       <tr><td>attrValOld</td>          <td><%= c.string( "attributes.attrValOld.display") %></td></tr>
       <tr><td>attrValNew</td>          <td><%= c.string( "attributes.attrValNew.display") %></td></tr>

     </table>
     <br>
-->     

<p/>

      <%-- more flexible alternative: use submit and script --%>
       <script type='text/javascript'>
          
        function done( )
        {
            document.forms[0].nextState.value = '';
            document.forms[0].submit();
        }

        function repeat( )
        {
            document.forms[0].sNextAction.value = 'init';
            document.forms[0].nextState.value = '';
            document.forms[0].submit();
            href = '<%= NcsUtil.makeDelegationUrl( ncsCommon.getTaskContext(), "", ncs_thisTask, "", "", false, false ) %>';
        }

        function onExit( nextAction )
        {  // optional enhancements ... 
           return true;
        }
        
        function goBack()
        {
            <% if ( NcsUtil.stringEmpty( sPrevAction )) { %>
            history.back();
            <% } else { %>
            document.forms[0].sNextAction.value = '<%= sPrevAction %>';
            document.forms[0].submit();
            <% } %>
        }
        
      </script>

      <iman:bar/>
      <% if ( bShowCancel ) { %> <jsp:include page='<%= c.getPath("dev/Cancel_inc.jsp") %>' flush="true" /><% } %>
      <% if ( bShowRepeat ) { %>  <A href="Javascript: if(onExit() != false) document.forms[0].submit();"><IMG  src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.RepeatTask.image") %>" alt="<%= c.string("Button.RepeatTask.alt") %>"  title="<%= c.string("Button.RepeatTask.alt") %>"   border=0></A><% } %>
      <% if ( bShowBack )   { %>  <a href="#" onClick="javascript:goBack();" ><IMG                              src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Back.image") %>"       alt="<%= c.string("Button.Back.alt") %>"        title="<%= c.string("Button.Back.alt") %>"         border=0></A><% } %>
      <% if ( bShowNext )   { %>  <A href="Javascript: if(onExit() != false) document.forms[0].submit();"><IMG  src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Next.image") %>"       alt="<%= c.string("Button.Next.alt") %>"        title="<%= c.string("Button.Next.alt") %>"         border=0></A><% } %>
      <% if ( bShowOK )     { %>  <A href="Javascript: if(onExit() != false) document.forms[0].submit();"><IMG  src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.OK.image") %>"         alt="<%= c.string("Button.OK.alt") %>"          title="<%= c.string("Button.OK.alt") %>"           border=0></A><% } %>
      <% if ( bShowDone )  { %>   <a href="#" onClick="javascript:repeat();" ><IMG                                src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.Done.image") %>" alt="<%= c.string("Button.Done.alt") %>" title="<%= c.string("Button.Done.alt") %>"  border=0></A><% } %>
   </form>

   <% NcsUtilBasics.garbageCollection( 10000000 ); %>

</BODY>
</HTML>
