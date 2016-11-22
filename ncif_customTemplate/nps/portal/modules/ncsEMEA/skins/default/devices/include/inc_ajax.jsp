
<%-- -------------------------------------------------------------------------------------------------  --%>
<%--@ include file="/portal/modules/ncsEMEA/skins/default/devices/include/inc_ajax.jsp"                 --%>
<%--   must be outside of form tag                                                                      --%>
<%-- -------------------------------------------------------------------------------------------------  --%>


<%-- ===========================================================================================================================  --%>


    <script language="Javascript">
        
        //var request             = false;    // shared XMLHttpRequest variable
        
        var pollingInterval = 0;        // polling interval (0 = no polling)
        var getVars         = '';       // variables to retrieve from session attributes
        var setVars         = '';       // variables to set in session attributes (not implemented)
        
        
        // get the XMLHttpRequest object
        function ajax_initialize( ) 
        {
            request = false;
            if (window.XMLHttpRequest) 
            { // Mozilla, Safari,...
                request = new XMLHttpRequest();
                if (request.overrideMimeType) request.overrideMimeType('text/xml');
                //alert ( "moz  " + request );
            } 
            else if (window.ActiveXObject) 
            { // IE
                try 
                {
                    request = new ActiveXObject("Msxml2.XMLHTTP");
                    //alert ( "ie " + request );
                } 
                catch (e) 
                {
                    try 
                    {
                        request = new ActiveXObject("Microsoft.XMLHTTP");
                    } 
                    catch (e) {}
                }
            }

            //alert ( "ok " + request );
            if ( !request ) 
            {
              alert('Ende :( Kann keine XMLHTTP-Instanz erzeugen');
              return false;
            }
            else 
            {
              return ( request );
            }
        }

        
         // initialize request 
         //request = ajax_initialize();
         
         
         // send request to JSP and specify callback function ajax_ProcessResponse()
         function ajax_Submit( request ) 
         {
            //alert ( "Submit <%= sResponder %>: " + request );
            request.open('POST', "<%= sResponder %>", true);
            request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            request.onreadystatechange = function() 
            {
                if (request.readyState == 4) {
                    if (request.status == 200) 
                    {
                      ajax_ProcessResponse( request.responseXML, request.responseText );
                    } 
                    else 
                    {
                      alert('Bei dem Request ist ein Problem aufgetreten (' + request.status + "): " + request.responseText );
                    }
                }
            }
            // getVars contains custom request parameters (e.g. 'test=abc'), in our case the variables to retrieve from the session
            request.send( getVars ); 
        }

        

        // internal function: recursively call ajax_Submit while ( pollingInterval > 0 )
        function doPolling( request )
        {
            // alert( pollingInterval );
            if ( pollingInterval > 0 )
            {
                ajax_Submit( request );
                // repeat this after delay ...
                setTimeout( "doPolling( request );", pollingInterval );
            }
        }
    
        // start recursively calling ajax_Submit with given interval
        function ajax_startPolling(  request, msDelay )
        {
           pollingInterval = msDelay;
           doPolling( request );
        }
    
        // stop recursively calling ajax_Submit
        function ajax_stopPolling()
        {
           pollingInterval = 0;
        }
        
        // define the variables to retrieve from session attributes (';' separated)
        //      e.g.: ajax_setVariablesToRetrieve( 'test1;test2' )
        // the retrieved variables can be analyzed in ajax_ProcessResponse()
        //      e.g.: var test1 = xmlAsDom.getElementsByTagName('test1')[0].firstChild.data;
        //
        function ajax_setVariablesToRetrieve( sVarNames )
        {
            getVars = '<%= NcsUtilAjax.CONST_GETVAR %>=' + escape(sVarNames);  // NOTE: no '?' before querystring
        }
    
        
        function ajax_getVariable( xmlAsDom, sVarName )
        {
          xmlValue = '';
          try
          {
            xmlValue = xmlAsDom.getElementsByTagName( sVarName )[0].firstChild.data;
          }
          catch (e) {}
          return ( xmlValue );
          }

          
        // get and display results from JSP
        // e.g. < response >  < count >123< /count > < time >(time)< /time > < /response >
        function ajax_ProcessResponse( xmlAsDom, xmlAsText )
        {
            // alert ( xmlAsText );
            //   call potentially undefined custom function to analyze results
            if ( self.ajax_CustomProcessResponse != undefined )  ajax_CustomProcessResponse( xmlAsDom, xmlAsText ); 
         }
         
    </script>

    
 <%-- ===========================================================================================================================  --%>
   
<%-- example


    <script type='text/javascript'>
        // get and display results from JSP
        // e.g. < response >  < count >123< /count > < time >(time)< /time > < /response >
        function ajax_CustomProcessResponse( xmlAsDom, xmlAsText )
        {
            // alert ( xmlAsText );
            document.getElementById("html_count").innerHTML   = ajax_getVariable( xmlAsDom, "count" );
            document.getElementById("html_time").innerHTML    = ajax_getVariable( xmlAsDom, "time" );
            document.getElementById("html_test1").innerHTML   = ajax_getVariable( xmlAsDom, "test1" );
            document.getElementById("html_test2").innerHTML   = ajax_getVariable( xmlAsDom, "test2" );
            document.getElementById("html_test3").innerHTML   = ajax_getVariable( xmlAsDom, "test3" );
         }
    </script>

     
     <form name="sessionAttributes">
        <input value="Go" type="button" onclick='ajax_setVariablesToRetrieve( "test1;test2;test3" ); ajax_Submit();'></p>
        count:  <font id="html_count">xxx</font>    <br>
        time:   <font id="html_time">xxx</font>     <br>
        test1:  <font id="html_test1">test1</font>  <br>
        test2:  <font id="html_test2">test2</font>  <br>
        test3:  <font id="html_test3">test3</font>  <br>

        <input value="Start Polling" type="button" onclick='ajax_setVariablesToRetrieve( "test1;test2;test3" ); ajax_startPolling( 1000 )'><p/>
        <input value="Stop  Polling" type="button" onclick='ajax_stopPolling()'><p/>
     </form>
  
     --%>
     
