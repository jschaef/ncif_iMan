<%-- ------------------------------------------------------------------------------------------------- --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ncsSearch_customButtons.jsp" --%>
<%-- used in inc_ncsSearch_ResultsDisplay.jsp --%>
<%-- ------------------------------------------------------------------------------------------------- --%>
<!-- inc_ncsSearch_customButtons.jsp  - start ... -->

   <% // build a button for each custom task (see sharedTask/sharedTaskButton)
      String   sJsMultiSelect   = "callTaskWithMultipleObjects"; // unique name 
      
      String   sCustomButtons   = "";
      // boolean  bUsePost       = bShowResults && xml_multiSelect; // && xml_launch; // post vs. URL param
      if ( bShowResults && xml_multiSelect )
      {
   %>
      <script type='text/javascript'>

         var cbList   = document.getElementsByName( '<%= "cb_"+NcsUtil.sTargetNames %>' );
         
         function checkAllObjects( bVal )
         {
            if ( cbList != null ) 
            {
               for ( i = 0; i < cbList.length; i++) 
               {
                   cbList[i].checked = bVal;
               }
            }
         }
         

         function <%= sJsMultiSelect %>( sTask )
         {
            var saDN     = new Array();
            saDN.length  = 0; 
            if ( cbList != null ) 
            {
               for ( i = 0; i < cbList.length; i++) 
               {  // store checked objects to array ...
                  if ( cbList[i].checked ) 
                  {  
                     saDN.length         = saDN.length + 1;
                     saDN[saDN.length-1] = cbList[i].value;
                  }
               }
               
               if ( saDN.length<=0 ) 
               {
                  alert ('Nothing selected');
               }
               else 
               {
                  var packedNames   = pack ( saDN );
                  var bUsePost      = ( packedNames.length > 1900 ); // max URL ...
                  // alert ( saDN.length + " objects ->" + packedNames.length + ": " + bUsePost );
                  if ( bUsePost ) 
                  {  // no diff between launch & delegate
                     var GI_ID         = getFieldByNameOrId( "GI_ID" );
                     GI_ID.value       = sTask;
                     var targetNames   = getFieldByNameOrId( "targetNames" );
                     targetNames.value = packedNames;
                     //alert ( saDN.length + " objects ->" + packedNames.length + ": " + targetNames.value );
                     document.forms[0].submit();
                  } 
                  else 
                  {
                     <% if ( xml_launch ) { %>   
                        launchUrlDirect ( packedNames, sTask, '' );  
                     <% } else { %>
                        redirectFrame ( delegationUrlDirect ( packedNames, sTask, '' ));  
                     <% } %>

                  }
               }
            }
         }
      </script>
   <%
       // sCustomButtons += "<br><p>";
       sCustomButtons += "<font onclick='checkAllObjects( false );'><IMG src='/nps/portal/modules/dev/images/en/btnclearall_en.gif' alt='Clear All' title='Clear All' border=0></font>&nbsp;";
       sCustomButtons += "<font onclick='checkAllObjects( true );' ><IMG src='/nps/portal/modules/dev/images/en/btncheckall_en.gif' alt='Check All' title='Check All' border=0></font>&nbsp;";
       for ( int i=0; i<ncsUtilSearch.saTasks.length; i++ )
       {  // display respective sharedTaskButton image 
          String   sTask = ncsUtilSearch.saTasks[i];
          String   sBtn  = ""; 
          if ( NcsUtil.stringEmpty( sTask )) continue;
          if ( i<ncsUtilSearch.saButtons.length )
          {
            if ( NcsUtilBasics.stringEmpty( ncsUtilSearch.saButtons[i] ) )
              sBtn = "xml:sharedTaskButton[" + i + "] undefined";
            else
              sBtn = NcsUtil.getButtonImg( request, ncsUtilSearch.saButtons[i], ncsUtilSearch.saButtons[i] );
          }
          sCustomButtons += "&nbsp;<a href='#' onclick='" + sJsMultiSelect + "( \"" + ncsUtilSearch.saTasks[i] + "\" );'>" + sBtn + "</a>";
       }
%>




<% } %> 
   <%-- display generated buttons - requires inc_ncsSearch_customButtons.jsp - sCustomButtons can be added multiple times --%> 
   <%= sCustomButtons %> 
    
   <%-- test delegation with form parameters ... --%> 

   <%--

   <FORM name="Next" method=post action="webacc">
      <table>
         <tr>
            <td>GI_ID</td>
            <td><input type="text" name="GI_ID"       size="60"     value="<%= ncs_thisTaskId %>"></td>
         </tr>
         <tr>
            <td>targetNames</td>
            <td><input type="text" name="targetNames" size="60"     value="<%= sPacked %>"></td>
         </tr>
      </table>

      <p> <iman:bar/> <p>
      <iman:button key="OK" type="input"/>
      <iman:cancelBtn/>
   </FORM>
   --%>   

   <%-- ... test delegation with form parameters --%> 


<!-- inc_ncsSearch_customButtons.jsp  - ... end -->


















  
