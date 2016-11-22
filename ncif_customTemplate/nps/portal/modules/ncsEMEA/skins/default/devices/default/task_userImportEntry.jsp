<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<%--

BULK OBJECT IMPORT 

Example:

<task>
    <id>test_task_userImport</id>
    <order>800</order>
    <version>2.0.0</version>
    <required-version>2.0.0</required-version>
    <class-name>de.test.imanager.task_userImport</class-name>
    <display-name-key>test_task_userImport</display-name-key>
    <description-key>test_task_userImport</description-key>
    <resource-properties-file>de.test.resources</resource-properties-file>
    <role-assignment>test_roles_DPT-ADMIN</role-assignment>
    <url-param>
      <param-key>resource-properties-file</param-key>
      <param-value>/de/test/resources.properties</param-value>
    </url-param>
    <url-param>
      <param-key>merge-template-entry</param-key>
      <param-value>test/task_userImportEntry.jsp</param-value>
    </url-param>
    <url-param>
      <param-key>merge-template-results</param-key>
      <param-value>test/task_userImportResults.jsp</param-value>
    </url-param>
    <url-param>
      <param-key>object-class</param-key>
      <param-value>User</param-value>
    </url-param>
    <url-param>
      <param-key>object-parent</param-key>
      <param-value>User.DPT-ORACLE-PORTAL.test</param-value>
    </url-param>
    <url-param>
      <param-key>group-parent</param-key>
      <param-value>Groups.DPT-ORACLE-PORTAL.test</param-value>
    </url-param>
    <url-param>
      <param-key>attribute-separator</param-key>
      <param-value>,</param-value>
    </url-param>
    <url-param>
      <param-key>attribute-names</param-key>
      <param-value>CN,Surname,Given Name,Group Membership,Group Membership</param-value>
    </url-param>
    <url-param>
      <param-key>attribute-mandatory</param-key>
      <param-value>true,true,true,false,false</param-value>
    </url-param>
    <url-param>
      <param-key>attribute-display-keys</param-key>
      <param-value>CN,Surname,Given Name,Description,Group Membership</param-value>
    </url-param>
</task>

--%>



<%   JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<fmt:setBundle basename="DevResources"/>

<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>

<c:set var="tasktitle" value="User Import"/>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<BODY>

    <% 
        c.set("TaskHeader.title",   ncsCommon.getProperty( ncs_thisTaskId ) );
        c.set("TaskHeader.iconUrl", "dir/Group.gif");
        c.set("TaskHeader.iconAlt", c.var ("TranslatedClass")); 
    %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

   <form name="uploadForm" method="post" action="webacc?Autoparse=true" enctype="multipart/form-data">
      <INPUT type="hidden" name="error" value="dev.GenErr">
      <INPUT type="hidden" name="User.context" value="<c:out value="${User.context}" />">
      <INPUT type="hidden" name="taskId" value="<%= ncs_thisTaskId %>">
      <INPUT type="hidden" name="nextState" value="doUpload">
<p>



<%--
    NDSNamespace  ns = ncsCommon.getTree().getNs();
    out.println( "ns.name="         +  ns.name + "<br>" );

    ObjectEntry   oeTree = ncsCommon.getTree().getOe();
    out.println( "oeTree="          +  oeTree.getFullName() + "<br>" );

    String sName = ns.getUnrootedName( oeTree );
    out.println( "sName="          +  sName + "<br>" );
    out.println( "sName="          +  sName.length() + "<br>" );
    
    String sNew  = NcsUtil.stringConcatWithSeparator ( ".a.b.c", sName, "." );
    out.println( "sNew="          +  sNew + "<br>" );

--%>





   <TABLE cellspacing='0'>

     <TR><TD height="8"></TD></TR>

     <tr>
         <td colspan='2'><%= ncsCommon.getProperty( "import.SelectFile" ) %></td>
      </tr>
     <TR><TD height="8"></TD></TR>

      <tr>
         <td></td>
         <td class="mediumtext"><INPUT type="file" name="fileToUpload" size=80  style='width:400'  ></td>
      </tr>
     <TR><TD height="8"></TD></TR>
   
   </TABLE>
  
    <c:forEach var="arCarryOver" items="${arCarryOver}">
       <c:out value="${arCarryOver}" escapeXml="false" />
    </c:forEach>

   

      <BR><BR>
      <iman:bar/> 
      <iman:button key="OK" type="input"/>
      <iman:cancelBtn/>
      <iman:helpIcon helpFile="ncsEMEA/helpImport.html" /> 
   </form>

</body>
</HTML>
