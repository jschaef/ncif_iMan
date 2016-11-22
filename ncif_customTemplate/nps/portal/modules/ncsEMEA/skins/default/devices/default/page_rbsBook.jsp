<%@  page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="com.novell.ncsEMEA.util.*, com.novell.webaccess.common.JSPConduit,
                  java.util.ResourceBundle,
                  com.novell.emframe.dev.eMFrameUtils" %>

<%@ taglib uri="/WEB-INF/iman.tld" prefix="iman" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/x.tld" prefix="x" %>


<iman:stringtable bundle="DevResources"/>
<x:parse xml="${edas}" var="edasXml"/>



<HTML>
<HEAD>
   <TITLE><iman:string key="ProductName"/></TITLE>
   <LINK rel="stylesheet" href="<c:out value="${ContextPath}" />/portal/modules/dev/css/hf_style.css">
   <iman:include page="fw/UiHandlerTools.jsp" />
   <iman:include page="dev/PageScripts_inc.jsp" />


   <iman:include page="dev/eMFrameScripts_inc.jsp"/>
   <iman:include page="dev/MVStringEditorScripts_inc.jsp"/>
   <iman:include page="dev/ValidateIntegerScripts_inc.jsp"/>


   <script type='text/javascript'>
      function onInit()
      {
      }

      <%-- ---------------------------------------------------------------- --%>
      <%--    What should this method do?                                   --%>
      <%--    -data validation                                              --%>
      <%--    -general page cleanup before being submitted                  --%>
      <%--    -if this method returns false, the page will not be saved     --%>
      <%--    Called when user leaves this page or applys changes           --%>
      <%-- ---------------------------------------------------------------- --%>
      function isPageValid()
      {
         var form=document.forms[0];


         return notifyAllOfExit();
      }

   </script>
</HEAD>

<BODY onLoad="onInit();">
<FORM name="form" method=post action="webacc">
   <iman:include page="dev/Messagebar_inc.jsp"/>
   <iman:include page="dev/BookVars_inc.jsp"/>

   <!---- Shared Form Code ---->

   <!---- UI Created by UiHandlers ---->

   <TABLE class="mediumtext" border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">


      <%-- rbsPageMembership --%>
      <TR>
         <TD align=left>
            <c:out value="${rbsPageMembershipDisplayName}"/>:&nbsp;&nbsp;
         </TD>
         <c:if test="${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <c:if test="${edasRights.target.rbsPageMembership.writeable}">
               <INPUT type="hidden" name="eDir$target$rbsPageMembership" value="<c:out value="${eDir$target$rbsPageMembership}" escapeXml="false"/>">
               <script type='text/javascript'>addToNotificationList('rbsPageMembership', 'uih_mvStringEditor');</script>
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/rbsPageMembership" scope="request"/>
            <iman:mved readonly="${!edasRights.target.rbsPageMembership.writeable}" enforceUnique="true" name="_rbsPageMembership"            />
         </TD>
         <TD valign=top>
            <x:set var="mode" select="$edasXml/edas/rbsPageMembership[mode]"/>
            <iman:mooMode name="_rbsPageMembership_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      <%-- rbsTargetObjectType --%>
      <TR>
         <TD align=left>
            <c:out value="${rbsTargetObjectTypeDisplayName}"/>:&nbsp;&nbsp;
         </TD>
         <c:if test="${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <c:if test="${edasRights.target.rbsTargetObjectType.writeable}">
               <INPUT type="hidden" name="eDir$target$rbsTargetObjectType" value="<c:out value="${eDir$target$rbsTargetObjectType}" escapeXml="false"/>">
               <script type='text/javascript'>addToNotificationList('rbsTargetObjectType', 'uih_mvStringEditor');</script>
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/rbsTargetObjectType" scope="request"/>
            <iman:mved readonly="${!edasRights.target.rbsTargetObjectType.writeable}" enforceUnique="true" ignoreCase="true" name="_rbsTargetObjectType"            />
         </TD>
         <TD valign=top>
            <x:set var="mode" select="$edasXml/edas/rbsTargetObjectType[mode]"/>
            <iman:mooMode name="_rbsTargetObjectType_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      <%-- rbsParameters --%>
      <TR>
         <TD align=left>
            <c:out value="${rbsParametersDisplayName}"/>:&nbsp;&nbsp;
         </TD>
         <c:if test="${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <c:if test="${edasRights.target.rbsParameters.writeable}">
               <INPUT type="hidden" name="eDir$target$rbsParameters" value="<c:out value="${eDir$target$rbsParameters}" escapeXml="false"/>">
               <script type='text/javascript'>addToNotificationList('rbsParameters', 'uih_mvStringEditor');</script>
            </c:if>
            <x:set var="MVStringEditor_xmlNodeSet" select="$edasXml/edas/rbsParameters" scope="request"/>
            <iman:mved readonly="${!edasRights.target.rbsParameters.writeable}" enforceUnique="true" name="_rbsParameters"            />
         </TD>
         <TD valign=top>
            <x:set var="mode" select="$edasXml/edas/rbsParameters[mode]"/>
            <iman:mooMode name="_rbsParameters_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

      <%-- rbsEntryPoint --%>
      <TR>
         <TD align=left>
            <c:out value="${rbsEntryPointDisplayName}"/>:&nbsp;&nbsp;
         </TD>
         <c:if test="${DEVICE_TYPE=='pocket'}"></TR><TR></c:if>
         <TD>
            <c:if test="${edasRights.target.rbsEntryPoint.writeable}">
               <INPUT type="hidden" name="eDir$target$rbsEntryPoint" value="<c:out value="${eDir$target$rbsEntryPoint}" escapeXml="false"/>">
               <script type='text/javascript'>addToNotificationList('rbsEntryPoint', 'uih_textfield');</script>
            </c:if>
            <INPUT type="text" name="_rbsEntryPoint" value="<x:out select="$edasXml/edas/rbsEntryPoint/value"/>" size=<iman:string key="UI.textboxSize"/> style="width:<iman:string key="UI.textboxPixel"/>"   <c:if test="${!edasRights.target.rbsEntryPoint.writeable}">DISABLED</c:if> >
         </TD>
         <TD valign=top>
            <x:set var="mode" select="$edasXml/edas/rbsEntryPoint[mode]"/>
            <iman:mooMode name="_rbsEntryPoint_mode" value="${mode}" multi="true" />
         </TD>
      </TR>
      <TR><TD height="8"></TD></TR>

   </TABLE>

</FORM>
<iman:include page="dev/OSFooter_inc.jsp"/>
</BODY>
</HTML>
