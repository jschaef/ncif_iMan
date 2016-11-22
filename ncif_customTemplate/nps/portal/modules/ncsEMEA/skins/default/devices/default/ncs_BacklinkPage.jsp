<%@  page import="com.novell.webaccess.common.JSPConduit, com.novell.emframe.dev.eMFrameUtils"%>
<%   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");

   if (session.getAttribute("DeviceType").equals("pocket")) {
      c.set("mvmode", "mvtxt");
   } else {
      c.set("mvmode", "mvsel");
   } %>



<HTML>
<HEAD>
	<TITLE><%= c.var("bookTitle") %></TITLE>

	<LINK rel='stylesheet' href='<%= c.getModulesUrl() + "/dev/css/hf_style.css" %>'>
	<jsp:include page='<%= c.getPath("dev/PageScripts_inc.jsp") %>' flush="true" />
	<jsp:include page='<%= c.getPath("dev/eMFrameScripts_inc.jsp") %>' flush="true" />
	<jsp:include page='<%= c.getPath("dev/OSScripts_inc.jsp") %>' flush="true" />
	<jsp:include page='<%= c.getPath("dev/ValidateIntegerScripts_inc.jsp") %>' flush="true" />

 <% c.set("MVStringEditor_mode", c.var("mvmode")); %>
	<jsp:include page='<%= c.getPath("dev/MVStringEditorScripts_inc.jsp") %>' flush="true" />

	<script language="JavaScript">
         function isPageValid()
         {
            document.form.objBacklinks.value=mvGetValuesAsPack("objBacklinkList");
            return true;
         }

         function init()
         {
            mvLoadFromPack("objBacklinkList", "<%= c.toScript(c.var("objBacklinks")) %>");
            mvFocus("objBacklinkList");
            returnFromOS();
         }
	</script>
</HEAD>




<BODY onload="init()">

<FORM name="form" method=post action="webacc" onSubmit="return false">

 <jsp:include page='<%= c.getPath("dev/Messagebar_inc.jsp") %>' flush="true" />
	<jsp:include page='<%= c.getPath("dev/BookVars_inc.jsp") %>' flush="true" />

<%--        
   <h3>  	<%= request.getAttribute("javax.servlet.include.request_uri").toString()	%>	 </h3>
   <h3>   <%=	request.getAttribute("GI_ID").toString()	%>	 </h3>
--%>

   <h3><%= c.var("page_info") %></h3>

   <h3><%= c.var("attributeDisplayName") %>:</h3>
   
<p>
   <INPUT name='objBacklinks' type='hidden' value="">


 <%-------------------------------------------------------%>
 <%-- Note: we are not currenlty disabling this control --%>
 <%--       if the user doesn't have rights.            --%>
 <%-------------------------------------------------------%>

 <% c.set("MVStringEditor_size", "10");
      c.set("MVStringEditor_mode", c.var("mvmode"));
      c.set("MVStringEditor_name", "objBacklinkList");
      c.set("MVStringEditor_minLength", "1");
      c.set("MVStringEditor_maxLength", "256");
      c.set("MVStringEditor_ignoreCase", "true");
      c.set("MVStringEditor_enforceUnique", "true");
      c.set("MVStringEditor_width", "450");
      c.set("MVStringEditor_history", "true");

      c.set("MVStringEditor_objectTypeName", "User");

      String key = "eDirRights$target$" + c.var("primaryAttributeName");
      if (c.var(key).equals("R") || c.var(key).equals("NONE")) {    c.set("MVStringEditor_readonly", "true");    }
   %>


   <jsp:include page='<%= c.getPath("dev/MVStringEditor_inc.jsp") %>' flush="true" />

</FORM>


<%--
  <h2> 
  GI_ID:  <%=  request.getAttribute("GI_ID").toString()	%>                          <br>
  taskId: <%=  request.getAttribute("taskId").toString()	%>                         <br>
  JSP:    <%=  request.getAttribute("javax.servlet.include.request_uri").toString()	%>
  </H2>
--%>


<jsp:include page='<%= c.getPath("dev/OSFooter_inc.jsp") %>' flush="true" />
</BODY>
</HTML>
