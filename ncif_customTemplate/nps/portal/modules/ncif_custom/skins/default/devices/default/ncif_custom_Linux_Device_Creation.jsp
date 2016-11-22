<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>
<iman:stringtable bundle="DevResources" />
<iman:stringtable bundle="FwResources" />
<%
   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("FwResources");
%>

<%@ include file="/portal/modules/ncif_custom/include/helper.jsp"  %>

<%-- Empty xml, since we don't have an object to read --%>
<x:parse xml="<edas></edas>" var="edasXml"/>

<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <iman:stylesheet/>
   <iman:uihandlerTools/>


   <iman:eMFrameScripts/>
   <iman:validateNumberScripts/>
   <iman:osScripts/>
   <iman:mvedScripts/>
<iman:calendarScripts/><jsp:include page='<%= c.getPath("dev/XmlScripts_inc.jsp") %>' flush="true" /><LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'><jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" /><iman:calendarScripts/>

   <SCRIPT>
	
	function onInit()
      {
         var form = document.forms[0];
         form._CN.focus();
         returnFromOS();
      }

      function onExit(action)
      {
			debugger;
         var form=document.forms[0];

         var success = notifyAllOfExit();
         if(!success)
         {
            return false;
         }

         if(form.eDir$target$CN.value.indexOf('<value')<0)
         {
            alert(formatMessage("<iman:string key="General.provideMandatoryAttribute"/>", ["<iman:toScript><c:out value="${CNDisplayName}"/></iman:toScript>"]));
            return false;
         }
         if(form.eDir$target$ncifMACAddresses.value.indexOf('<value')<0)
         {
            alert(formatMessage("<iman:string key="General.provideMandatoryAttribute"/>", ["MAC Address (e.g. 00:0c:29:18:7d:a1)"]));
            return false;
         }


         var containerInput = document.form.eDir$target$createContext.value;
         var radioButton = (form.eDir$target$createContext[0] && form.eDir$target$createContext[0].type == "radio");
         if(!radioButton)
         {
            if ((containerInput==null) || (containerInput.length==0))
            {
               alert("<iman:string key="Creator.InvalidContainerName"/>");
               return false;
            }
         }

			if ( success ) success = wsValidate( action );
			return( success );
//         return true;
      }

      var ENABLED_COLOR = "white";
      var DISABLED_COLOR = "#EFEEE9";

      function enableTemplate(control)
      {
         with(document.forms[0])
         {
            var tf = eDir$target$createSourceObjectForClone;
            if (control.checked == true)
            {
               tf.disabled = false;
               tf.style.backgroundColor = ENABLED_COLOR;
            }
            else
            {
               tf.disabled = true;
               tf.value = "";
               tf.style.backgroundColor = DISABLED_COLOR;
            }
         }
      }

	   function checkDefaultKey(evt)
      {
         var form = document.forms[0];
         var keyCode = evt.which ? evt.which : evt.keyCode;
         // 13 is the Enter key code
         if (keyCode == 13)
         {
            if(onExit() != false)
            {
               document.forms[0].submit();
               return false;
            }
         }
         return true;
      }
   </SCRIPT>
</HEAD>


<body onLoad="onInit();">
<FORM name="form" method="post" action="webacc" onSubmit="onExit();">

   <!---- EDAS and System Variables ---->
   <INPUT type=hidden name="taskId" value="<c:out value="${taskId}"/>">
   <INPUT type=hidden name="eDirCommand" value="create">
   <INPUT type=hidden name="merge" value="dev.GenConf">
   <INPUT type=hidden name="error" value="dev.GenErr">
   <INPUT type=hidden name="nextState" value="eDasServiceAccess">
   <INPUT type=hidden name="eDir$target$createClassName" value="<c:out value="${createClassName}"/>">

   <c:set var="eDirCommandString" value="create" />

   <!---- Shared Form Code ---->


   <!-- Automatic Aux Class Extension -->
   <INPUT type=hidden name="eDir$target$auxillaryClassExtension" value="ncifDevice,@CUSTOMER.ATTR.PREFIX.NCIF@Device" >


   <%
//      c.set("TaskHeader.title", c.var("Task.displayName"));
//      c.set("TaskHeader.iconUrl", c.plus("dir/", c.var("GifName")));
//      c.set("TaskHeader.iconAlt", c.var("TranslatedClass"));
      c.set("TaskHeader.title",	ncsUtil_ncif_custom.getProperty("task." + ncs_thisTask ));
      c.set("TaskHeader.iconUrl", c.plus("dir/", "@CUSTOMER.ATTR.PREFIX.NCIF@Device.gif"));
      c.set("TaskHeader.iconAlt", ncsUtil_ncif_custom.getProperty( "ObjectType.@CUSTOMER.ATTR.PREFIX.NCIF@Device" ));
   %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

   <% if (c.var("createClassName").equals("Country")) { %>
      <p class="instructions"><iman:string key="Creator.CountrySelectPrompt" /></p>
   <% } else { %>
      <p class="instructions"><iman:string key="Creator.GenericSelectPrompt"/></p>
   <% } %>


   <!---- UI Created by UiHandlers ---->
   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


   <%-- CN --%>
   <TR>
      <TD align="left" colspan="2">
			<%=	ncsUtil_ncif_custom.getProperty( "ObjectType.@CUSTOMER.ATTR.PREFIX.NCIF@Device" )	%> name:<font color="red">*</font>&nbsp;&nbsp;
      </TD>
   </TR>
   <TR>
      <TD>
         <c:if test="${edasRights.target.CN.writeable}">
            <INPUT type="hidden" name="eDir$target$CN" value="<c:out value="${eDir$target$CN}" escapeXml="false"/>">
         </c:if>
         <INPUT type="text" name="_CN" id="spinner_CN" value="<x:out select="$edasXml/edas/CN/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"  maxlength=64 onchange='return validateLengthField(this, 1, 64); postUiHandlerEvent("CN", "change")'<c:if test="${!edasRights.target.CN.writeable}">DISABLED</c:if> >
      </TD>
      <TD valign="top">
         <c:set var="mode"><x:out select="$edasXml/edas/CN/@mode"/></c:set>
         <iman:mooMode name="_CN_mode" value="${mode}" multi="true" />
      </TD>
   </TR>
   <SCRIPT>
      window.uiObject_CN = new UiObject();
      <c:if test="${edasRights.target.CN.writeable}">
         addToNotificationList('CN', 'uih_textfield');
         addActionHandler('CN', 'uiah_textfield');
      </c:if>
   </SCRIPT>
   <SCRIPT>
      window.uiObject_CN.m_lowerBound = 1;
      window.uiObject_CN.m_upperBound = 64;
      window.uiObject_CN.m_type = "string";
   </SCRIPT>
   <TR><TD height="9"></TD></TR>

   <%-- null --%>
   <TR>
      <TD><iman:string key="Creator.Context"/><font color="red">*</font></TD>
   </TR>
   <TR>
      <TD>
         <INPUT type=text name="eDir$target$createContext" value="<%= eMFrameUtils.getSingleTarget(request) %>"size="<iman:string key="UI.textboxSize"/>" style="width:<iman:string key="UI.textboxPixel"/>" onkeypress="return checkDefaultKey(event)">
         <iman:os typeFilter="ncifConfiguration" control="eDir$target$createContext" history="true"/>
      </TD>
   </TR>
   <SCRIPT>
      window.uiObject_null = new UiObject();
      <c:if test="${true}">
      </c:if>
   </SCRIPT>
   <TR><TD height="9"></TD></TR>

   <%-- ncifIPAddresses --%>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifIPAddresses.jspf"  %>

   <%-- ncifMACAddresses --%>
	<% ncif_mandatory = sMandatory(); %>
	<%@ include file="/portal/modules/ncif_custom/skins/default/devices/include/ncifMACAddresses.jspf"  %>

   </TABLE><BR>

   <iman:bar/>
   <iman:button key="OK" onClick="if(onExit() != false) document.forms[0].submit()" />
   <iman:cancelBtn/>

</FORM>
<iman:osFooter/>
</BODY>
</HTML>



