<%-- Original Name: ws_test_scope_20030301_193510.jsp --%>

<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.ncsEMEA.util.*, com.novell.webaccess.common.JSPConduit,
                  java.util.ResourceBundle,
                  com.novell.emframe.dev.eMFrameUtils" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>


<fmt:setLocale value="${ClientLocale}"/>
<%--setLocale sets the charset back to ISO so we need to add this line to fix it--%>
<% response.setContentType("text/html;charset=utf-8"); %>
<fmt:setBundle basename="DevResources"/>
<x:parse xml="${edas}" var="edasXml"/>


<%@ include file="/portal/modules/ncsEMEA/include/helper.jsp" %>
<%--@ include file="/portal/modules/ncsEMEA/include/ncsIncEdir.jsp"  --%>

<HTML>
<HEAD>
   <TITLE><fmt:message key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:include page="fw/UiHandlerTools.jsp" />
   <iman:include page="dev/PageScripts_inc.jsp" />


   <iman:include page="dev/eMFrameScripts_inc.jsp"/>
   <iman:include page="dev/MVStringEditorScripts_inc.jsp"/>
   <iman:include page="dev/ValidateIntegerScripts_inc.jsp"/>


</HEAD>

<BODY>
<FORM name="form" method=post action="webacc">
   <iman:include page="dev/Messagebar_inc.jsp"/>
   <iman:include page="dev/BookVars_inc.jsp"/>

   <!---- Shared Form Code ---->

   <!---- UI Created by UiHandlers ---->


<hr>

<%=  ncsInc_all %>  


<hr>

</FORM>
<iman:include page="dev/OSFooter_inc.jsp"/>
</BODY>
</HTML>
