<%--
 // used to display key variables from ncsEMEA helper.jsp include with < %= ncsInc_all % >
  <%@ include file="/portal/modules/ncsEMEA/include/helperDebug.jsp" %>
--%>

   <%
     String       ncsTargets  = "";
     NcsObject[]  ncsObjects  =  ncsCommon.getTargets();
     if ( ncsObjects != null )
        for ( int iNcsDebug=0; iNcsDebug<ncsObjects.length; iNcsDebug++ ) {
             ncsTargets += ( iNcsDebug==0 ? "" : "|" ) + ncsObjects[iNcsDebug].getCn();
        }
   %>
      <table border='0' width='100%'>
          <tr valign="top">
             <td valign='top' align="left">
              <table border='1'  width='100%'>
               <tr><td colspan='2'><b>Debug Info:  Current User</b> </td></tr>
               <tr><td>  getDn()                      </td><td> <%= ncsCommon.getUser().getDn() %>                 </td></tr>
               <tr><td>  getCn()                      </td><td> <%= ncsCommon.getUser().getCn() %>          </td></tr>
               <tr><td>  getParentName()              </td><td> <%= ncsCommon.getUser().getParentName() %>         </td></tr>
               <tr><td>  getType()                    </td><td> <%= ncsCommon.getUser().getType() %>               </td></tr>
<%-- iManager 2.5 and higher
               <tr><td>  getCreationTime()            </td><td> <%= ncsCommon.getTree().getNs().getCreationTime(           ncsCommon.getUser().getOe() ).toString() %>                 </td></tr>
--%>
               <tr><td>  getLastModificationTime()    </td><td> <%= ncsCommon.getTree().getNs().getLastModificationTime(   ncsCommon.getUser().getOe() ).toString() %>                 </td></tr>
               <tr><td>  getNameComponents()          </td><td> <%= NcsUtil.stringArrayToString( ncsCommon.getTree().getNs().getNameComponents(        ncsCommon.getUser().getOe() ), "|" ) %>                 </td></tr>
               <tr><td>  getContext()                 </td><td> <%= ncsCommon.getTree().getNs().getContext(                ncsCommon.getUser().getOe() ).toString() %>                 </td></tr>
              </table>
            </td>
             <td valign='top' align="left">
              <table border='1' width='100%'>
               <tr><td colspan='2'><b>Debug Info:  Current Target</b> </td></tr>
               <tr><td>  getTree().getTreeName()      </td><td> <%= ncsCommon.getTree().getTreeName() %>           </td></tr>
               <tr><td>  getTarget().getType()        </td><td> <%= ncsCommon.getTarget().getType() %>             ( <%= ncsCommon.getTarget().getType().equals( ncsCommon.tbd ) ? "" : " " + NcsUtil.getClassImg( request, ncsCommon.getTarget().getType() ) %> )</td></tr>
               <tr><td>  getTarget().getDn()          </td><td> <%= ncsCommon.getTarget().getDn() %>               </td></tr>
               <tr><td>  getTarget().getCn()          </td><td> <%= ncsCommon.getTarget().getCn() %>        </td></tr>
               <tr><td>  getTarget().getParentName()  </td><td> <%= ncsCommon.getTarget().getParentName() %>       </td></tr>
               <tr><td>  getTarget().isMe()           </td><td> <%= String.valueOf(ncsCommon.getTarget().isMe()) %></td></tr>
               <tr><td>  getTargetCount()             </td><td> <%= String.valueOf(ncsCommon.getTargetCount()) %>  </td></tr>
               <tr><td>  ncsTargets                   </td><td> <%= ncsTargets %>                                  </td></tr>
               <tr><td>  isCreating()                 </td><td> <%= String.valueOf(ncsCommon.isCreating()) %>      </td></tr>
               <tr><td>  isEditing()                  </td><td> <%= String.valueOf(ncsCommon.isEditing()) %>       </td></tr>
             </table>
            </td>
       </tr>
       
       <tr>
             <td valign='top' align="left" colspan="2">
              <table border='1' width='100%'>
               <tr><td colspan='2' ><b>Tomcat/Request</b></td></tr>
               <tr><td>  bDebug                       </td><td> <%= String.valueOf( ncsCommon.bDebug ) %>         </td></tr>
               <tr><td>  ncs_Date                     </td><td> <%= ncs_Date        %>         </td></tr>
               <tr><td>  ncs_tomcatPath               </td><td> <%= ncs_tomcatPath  %>         </td></tr>
               <tr><td>  ncs.log                      </td><td> <%= getServletContext().getRealPath( "logs/ncs.log")  %> </td></tr>

               <tr><td>  ncs_tomcatVer                </td><td> <%= ncs_tomcatVer   %>         </td></tr>
               <tr><td>  ncs_tomcatCtx                </td><td> <%= ncs_tomcatCtx   %>         </td></tr>
               <tr><td>  ncs_thisModule               </td><td> <%= ncs_thisModule  %>         </td></tr>
               <tr><td>  ncs_thisJsp                  </td><td> <%= ncs_thisJsp     %>         </td></tr>
               <tr><td>  ncs_thisJspShort             </td><td> <%= ncs_thisJspShort%>         </td></tr>
               <tr><td>  ncs_thisJspId                </td><td> <%= ncs_thisJspId   %>         </td></tr>

               <tr><td>  ncs_thisTask                 </td><td> <%= ncs_thisTask        %>     </td></tr>
               <tr><td>  ncs_thisTaskShort            </td><td> <%= ncs_thisTaskShort   %>     </td></tr>
               <tr><td>  ncs_thisTaskId               </td><td> <%= ncs_thisTaskId      %>     </td></tr>
               <tr><td>  ncs_thisTaskDelegate         </td><td> <%= ncs_thisTaskDelegate%>     </td></tr>
               <tr><td>  ncs_thisTaskLaunch           </td><td> <%= ncs_thisTaskLaunch  %>     </td></tr>

               <tr><td>  getServerName                </td><td> <%= request.getServerName() %> </td></tr>
               <tr><td>  getContextPath               </td><td> <%= request.getContextPath() %></td></tr>
               <tr><td>  getModulesUrl                </td><td> <%= ncs_Conduit.getModulesUrl() %></td></tr>
               <tr><td>  getRequestURI                </td><td> <%= request.getRequestURI() %> </td></tr>
               <tr><td>  getAuthType                  </td><td> <%= request.getAuthType() %>   </td></tr>
               <tr><td>  getMethod                    </td><td> <%= request.getMethod() %>     </td></tr>
               <tr><td>  getPathInfo                  </td><td> <%= request.getPathInfo() %>   </td></tr>
               <tr><td>  getQueryString               </td><td> <%= request.getQueryString() %></td></tr>
               <tr><td>  getRemoteUser                </td><td> <%= request.getRemoteUser() %> </td></tr>
               <tr><td>  getServletPath               </td><td> <%= request.getServletPath() %></td></tr>
               <tr><td>  Authentication               </td><td> <%= ncsUtilLdap.getAuthenticationInfo() %> / User: <%= ncsUtilLdap.getUserName() %> / Pwd: <%= ncsUtilLdap.getUserPwd() %> / Addr: <%= ncsUtilLdap.getServerAddress() %> / SSL: <%= String.valueOf(ncsUtilLdap.getUseSSL()) %></td></tr>
               <tr><td>  BROWSER_HOST                 </td><td> <%= request.getSession().getAttribute("BROWSER_HOST").toString() %>    </td></tr>
               <tr><td>  PORTAL_HOST_NAME             </td><td> <%= request.getSession().getAttribute("PORTAL_HOST_NAME").toString() %></td></tr>
               <tr><td>  browser language             </td><td> <%= request.getLocale().getLanguage() %>                               </td></tr>
               <tr><td>  iManager language            </td><td> <%= ncs_Language %>            </td></tr>
               <tr><td>  iManager version             </td><td> <%= NcsUtilIManager.getImanagerVersion( request ) %></td></tr>
              </table>
            </td>
       </tr>
       
       <tr>
         <td colspan='2' valign='top' align="left">
          <table border='1' width='100%'>
            <tr><td colspan='2'><b>ncs_Conduit</b></td></tr>
            <tr><td colspan='2'> <%= ncs_ConduitDump  %>  </td></tr>
          </table>
         </td>
       </tr>
       
    </table>
