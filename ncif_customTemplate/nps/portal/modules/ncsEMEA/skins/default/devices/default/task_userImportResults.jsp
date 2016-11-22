<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<%@ taglib uri="/WEB-INF/iman.tld"  prefix="iman" %>
<%@ taglib uri="/WEB-INF/c.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld"     prefix="x" %>
<%@ taglib uri="/WEB-INF/fmt.tld"   prefix="fmt" %>

<% JSPConduit c = JSPConduit.getJSPConduit(request);
   c.stringTable("DevResources");
   c.stringTable("BaseResources");
   c.stringTable("FwResources");
%>

<iman:stringtable bundle="DevResources"/>
<iman:stringtable bundle="FwResources"/>

<HTML>
<HEAD>
   <meta http-equiv="Page-Enter" content="revealTrans(Transition=12,Duration=0.3)">
   <meta http-equiv="Page-exit"  content="revealTrans(Transition=12,Duration=0.3)">
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:eMFrameScripts/>
</HEAD>

<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>

<BODY>

   <% 
        c.set("TaskHeader.title",   ncsCommon.getProperty( ncs_thisTaskId ) );
        c.set("TaskHeader.iconUrl", "dir/Group.gif");
        c.set("TaskHeader.iconAlt", c.var ("TranslatedClass")); 
    %>
   <jsp:include page='<%= c.getPath("dev/TaskHeader_inc.jsp") %>' flush="true" />

   
   
   
<p>
     <TABLE <%-- class="mediumtext" --%> border='0'>
        <tr>
          <td colspan='3'><b><fmt:message key="import.ImportResults" /></B></td>
        </tr>
        <tr>
          <td></td>
          <td colspan='2'><c:out value="${result}" escapeXml="false"/></td>
        </tr>
        <tr>
          <td></td>
          <td colspan='2'>
            <ol>
              <c:forEach var="arResults" items="${arResults}">
                <li>  <c:out value="${arResults}" escapeXml="false"/>   </li>
              </c:forEach>
            </ol>
          </td>
        </tr>
     </table>

<p>

   <iman:bar/>
   <iman:cancelBtn/>
   <a href="<%= NcsUtil.makeDelegationUrl( ncsCommon.getTaskContext(), ncsCommon.getUser().getDn(), ncs_thisTask ) %>"><iman:button key="Back"/></a>

</body>
</HTML>
