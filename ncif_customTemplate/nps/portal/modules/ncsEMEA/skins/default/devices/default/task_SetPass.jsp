<%--
		this is a clone of the 2.7 base.SetPass with a modified version of TC_inc.jsp to disallow changing the target object
--%>
<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8"
			 import="com.novell.webaccess.common.JSPConduit,
						com.novell.emframe.dev.eMFrameUtils,

						com.novell.webaccess.common.JSPConduit2,
						com.novell.emframe.dev.eMFrameFactory,
						java.util.Locale,
						com.novell.nps.utils.Utils,
						com.novell.emframe.fw.FwUtils,
						java.util.ResourceBundle,

						com.novell.nps.utils.Utils" %>

<%
   JSPConduit c = JSPConduit.getJSPConduit(request);

   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<HTML>
<HEAD>
	<TITLE><%= c.string("ProductName") %></TITLE>
	<LINK rel='stylesheet' href='<%= c.getModulesUrl() %>/dev/css/hf_style.css'>

   <jsp:include page='<%= c.getPath("dev/eMFrameScripts_inc.jsp") %>' flush="true" />
   <jsp:include page='<%= c.getPath("dev/OSScripts_inc.jsp") %>' flush="true" />
   <jsp:include page='<%= c.getPath("dev/TCScripts_inc.jsp") %>' flush="true"/>



   <SCRIPT language="JavaScript">

      var ENABLED_COLOR = "white";
      var DISABLED_COLOR = "#EFEEE9";

   function isTargetValid()
   {

   	  return validateTargetChooser();

   }


     function onTargetChooserTextChange(control)
     {

             control=eval(control);

             if(control.value!="" || control.value.length>0)
             {

               	 validateTargetChooser();
             	 enableSimplePassword(control);
             }


     }

      function isValid()
      {

         var form = document.forms[0];
         if(form.SetPswdNewPassword.value != form.SetPswdVerifyPassword.value)
         {
            alert("<%= c.string("SetPassword.PasswordsDontMatch") %>");
            return false;
         }

         if (form.SetPswdNewPassword.value.length == 0)
         {
            var message = "<%= c.toScript(c.string("CreateUser.PasswordAlert")) %>";
            if (!confirm(message))
            {
               form.SetPswdNewPassword.focus();
               return false;
            }
         }

      }

      function onPageLoad()
      {

<% if (!session.getAttribute("DeviceType").equals("pocket") && c.var("Task.SetPassword.Param.Auth").equals("NDS"))
{ %>
         // added for simple password
         <% if(c.var("targetName").length() == 0)
         {%>
            if (document.form.selectedObject.value.length == 0)
            {
               document.form.enableUniversalPassword.value = 'false';
               document.form.enableUniversalPassword.disabled = 'true';
               document.form.enableUniversalPassword.style.backgroundColor = DISABLED_COLOR;
            }
         <%}
}%>		document.form.single.focus();  // this is added to focus the text boxes which takes the object names
										//we know "single" is the name of the control
      }

<% if (!session.getAttribute("DeviceType").equals("pocket") && c.var("Task.SetPassword.Param.Auth").equals("NDS"))
{ %>
      function enableSimplePassword(control)
      {
         with(document.form)
         {
            control = eval(control);

            if (control.value != " " || control.value.length>0)
            {

               enableUniversalPassword.value = 'true';
               enableUniversalPassword.disabled = false;
               enableUniversalPassword.style.backgroundColor = ENABLED_COLOR;
               enableUniversalPassword.checked = false;
            }
         }
      }

      function enableSimplePasswordCallBack(control, results)
      {

          with(document.form)
         {
            control = eval(control);
            control.value = results[0];
            if(control.value!="" || control.value.length>0)
            {
             	validateTargetChooser();
	            enableSimplePassword(control);
            }
         }
      }
<% } %>
   </SCRIPT>
</HEAD>

<BODY TEXT="#000000" LINK="#000000" VLINK="#000000" ALINK="#000000" bgcolor="#FFFFFF" onLoad="returnFromOS(); onPageLoad();">
<FORM name="form" method=post action="webacc" onSubmit="return isTargetValid() && isValid() " >

   <!-- MFRAME VARIABLES -->
   <INPUT type=hidden name="taskId"            value="<%= c.var("taskId") %>">
   <INPUT type=hidden name="error"             value="dev.GenErr">
   <INPUT type=hidden name="nextState"         value="doSetPassword">
   <INPUT type=hidden name="nextPage"          value="">
   <INPUT type=hidden name="activePage"        value="">
   <INPUT type=hidden name="eDirCommand"       value="read">
   <INPUT type=hidden name="eDirSearch"        value="<%= c.var("eDirSearch") %>">
   <INPUT type=hidden name="merge"	           value="dev.GenConf">


   <% c.set("TaskHeader.title", c.string("SetPassword.Header"));
      c.set("TaskHeader.iconUrl", "dir/User.gif");
      c.set("TaskHeader.iconAlt", c.string("ObjectType.User"));

      c.set("SimplePassword.formName", "document.form");
      c.set("SimplePassword.contextControlName", "document.form.selectedObject");
      c.set("SimplePassword.labelsAbove", "true");
      c.set("SimplePassword.tableCellPadding", "1");
      c.set("SimplePassword.dsPasswordControlName", "document.form.SetPswdNewPassword");
      c.set("SimplePassword.TCExists","true");
      String onFieldSize = "";
      String passwordFieldSize = "";
      if (!session.getAttribute("DeviceType").equals("pocket"))
      {
         onFieldSize = c.string("UI.textboxSize");
         passwordFieldSize = c.string("UI.textboxSize");
      }
      else
      {
         onFieldSize = c.string("PocketUI.textboxSizeOneButton");
         passwordFieldSize = c.string("PocketUI.textboxSize");
      }
   %>

   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" /><BR>
   <jsp:include page='<%= c.getPath("dev/Messagebar_inc.jsp") %>' flush="true" />

<TABLE width="100%" border="0" cellspacing="0" cellpadding="1">
   <tr>

    <% c.set("TC.controlName", "selectedObject");

	       c.set("TC.quickFindEnabled","true");
       if(!c.var("targetName").equals(""))
       {
           c.set("TC.initialValues","P:"+c.var("targetName")+"P");
       }
         if (!session.getAttribute("DeviceType").equals("pocket") && c.var("Task.SetPassword.Param.Auth").equals("NDS"))
       {
	       c.set("TC.callBack","enableSimplePasswordCallBack");
	       c.set("TC.onChange","true");
       }
	       %>

    <td class="mediumtext">

<%--
		 <jsp:include page='<%= c.getPath("dev/TC_inc.jsp") %>' flush="true" />
--%>

			<!-- Begin TC_inc.jsp (Default) -->
			<%
				JSPConduit2 c2 = JSPConduit2.getJSPConduit(request);
				c2.stringTable("DevResources");

				//------------------- Handle Deprecations ------------------------------
				//TC.objectTypeName and TC.objectTypeNames deprecated... replaced with TC.osTypeFilter
				if (c2.var("TC.osTypeFilter").equals(""))
				{
					if (!c2.var("TC.objectTypeNames").equals(""))
					{
						//use value from deprecated parameter TC.objectTypeNames
						c2.set("TC.osTypeFilter",c2.var("TC.objectTypeNames"));
					}
					else if (!c2.var("TC.objectTypeName").equals(""))
					{
						//use value from deprecated parameter TC.objectTypeNames
						c2.set("TC.osTypeFilter",c2.var("TC.objectTypeName"));
					}
				}

				//TC.initialValue deprecated.... replaced with TC.initialValues
				if (c2.var("TC.initialValues").equals(""))
				{
					c2.set("TC.initialValues", c2.var("TC.initialValue"));
				}

				//TC.prompt deprecated.... replaced with TC.title
				if (c2.var("TC.title").equals(""))
				{
					c2.set("TC.title", c2.var("TC.prompt"));
				}


				//-------------------- Validate Parameters -----------------------------
				if (c2.var("TC.title").equals(""))
				{
					c2.set("TC.title", c2.var("TC.defaultPrompt"));
				}

				String target = eMFrameUtils.getSingleTarget(request);
				if (target!=null)
				{
					target = Utils.toTag(target);
				}
				else
				{
					String[] initialValues =  eMFrameUtils.unpack(c2.var("TC.initialValues"), eMFrameFactory.getMContext(request));
					if (initialValues!=null && initialValues.length>0) target = Utils.toTag(initialValues[0]);
					else target="";
				}

				String pack = c2.var("TC.packedObjectTypeNames");
				if (pack==null)
				{
					pack = "";
				}
			%>

			<SCRIPT>
				window.controlName = "<%= c2.var("TC.controlName") %>";
				window.packedObjectTypeNames = "<%= pack %>";

				<%
				Locale locale = FwUtils.getCurrentLocale(pageContext.getSession());
				ResourceBundle devRes = ResourceBundle.getBundle("DevResources", locale);

				String types = (String)pageContext.findAttribute("TC.packedObjectTypeNames");
				if (types==null)
				{
					types="";
				}
				out.println();
				out.println("   function validateTargetChooser()");
				out.println("   {");
				out.println("      var f = document.forms[0];");
				out.println("      var list = new Array();");
				out.println("     list[0] = f.single.value;");

				out.println("    var packedValue = pack(list);");
				out.println("   if (packedValue==null || packedValue==\"\")");
				out.println("    {");
				out.println("      alert(\""+devRes.getString("General.NeedsObjectName")+"\");");
				out.println("       return false;");
				out.println("    }");
				out.println("    else");
				out.println("    {");
				out.println("       eval(\"f.\" + window.controlName).value = packedValue;");
				out.println("    }");

				out.println("    return true;");
				out.println("  }");
			%>
			</SCRIPT>

			<INPUT type="hidden" name="<%= c2.var("TC.controlName") %>" value="<%=c2.var("TC.initialValues")%>" size="40">

			<INPUT type="text" name="single" readonly value="<%= target %>" size="<%= c2.string("PocketUI.textboxSizeOneButton") %>" style="width:<%= c2.string("UI.textboxPixel") %>">
<%--
			<iman:os typeFilter="${requestScope['TC.osTypeFilter']}" control="single" history="true"/>
--%>
			<BR>

			<!-- End TC_inc.jsp (Default) -->



	 </td>

  </tr>


   <tr><td class=mediumtext><%= c.string("SetPassword.NewPassword") %></td></tr>
   <tr><td><input type=password name="SetPswdNewPassword" value="" size=<%= passwordFieldSize %> maxlength="127"></td></tr>

   <tr><td class=mediumtext><%= c.string("SetPassword.RenterPassword") %></td></tr>
   <tr><td><input type=password name="SetPswdVerifyPassword"  value="" size=<%= passwordFieldSize %> maxlength="127"></td></tr>

<% if(!session.getAttribute("DeviceType").equals("pocket") && c.var("Task.SetPassword.Param.Auth").equals("NDS")){%>
   <tr><td colspan="3"><hr noshade size="1"></td></tr>

   <jsp:include page='<%= c.getPath("base/SetSimplePassword_inc.jsp") %>' flush="true" />
<% } %>

</TABLE>

   <jsp:include page='<%= c.getPath("dev/Bar_inc.jsp") %>' flush="true" />
   <INPUT type=image name="OkButton" alt="<%= c.string("Button.OK.alt") %>" src="<%= c.getModulesUrl() + "/dev/images/" + c.string("Button.OK.image") %>" border=0><jsp:include page='<%= c.getPath("dev/Cancel_inc.jsp") %>' flush="true" />

</FORM>
<jsp:include page='<%= c.getPath("dev/OSFooter_inc.jsp") %>' flush="true" />
</BODY>
</HTML>
