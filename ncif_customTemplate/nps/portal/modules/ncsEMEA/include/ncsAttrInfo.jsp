<%--
    // common java & jsp stuff used by Novell Consulting Services (NCS)
    // 
    // include into JSP with 
    // 	 <%@ include file="/portal/modules/ncsEMEA/include/ncsAttrInfo.jsp"  %>
    //
--%>

<%!

 // pass custom info to included attribute JSPs 
 // variables used to control the display of included attributes
  private String            ncs_Format            = "";    
  private boolean           ncs_Format_ro         = false;  // do not send data to eDir
  private boolean           ncs_Format_disabled   = false;  // do not allow user changes, but send to eDir
  private boolean           ncs_Hide              = false;  // hide attribute interface
  private String            ncs_Hint              = "";     // hint shown with attribute name
  private String            ncs_RO                = "";     // show as read-only
  private String            ncs_Custom            = "";     // pass custom info to included JSPs.
  private String            ncs_Value             = NcsCommon.tbd;     // pass new value to JSP (javascript)
//private String            ncs_Script            = "";     // pass new value to JSP (javascript)

  private String            View_READONLY         = "";     // deprecated - use strAttrReadOnly()

 public void    setAttrReadOnly( boolean isReadOnly, boolean isDisabled )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
   ncs_Format_ro        = isReadOnly;
   ncs_Format_disabled  = isDisabled;
 }

 public void    setAttrDisplay( String sDefault, boolean isReadOnly, boolean isDisabled, String sValue )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
   ncs_Format           = sDefault;
   ncs_Format_ro        = isReadOnly;
   ncs_Format_disabled  = isDisabled;
   ncs_Value            = sValue;
 }

 public void    setAttrDisplay( String sDefault, boolean isReadOnly, boolean isDisabled )
 {  
    setAttrDisplay( sDefault, isReadOnly, isDisabled, NcsCommon.tbd );
 }

 /** deprecated
  */
 public void    setAttrDisplay( String sDefault, boolean isReadOnly )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
   setAttrDisplay( sDefault, isReadOnly, isReadOnly );
 }

 public String  getAttrDisplay()
 { 
   return ( ncs_Format );
 }

 // set to specified display format
 public void    setAttrDefault( String sDefault, boolean isReadOnly, boolean isDisabled )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
  if ( NcsUtil.stringEmpty( ncs_Format )) setAttrDisplay( sDefault, isReadOnly, isDisabled ); 
 }

 /** deprecated
  */
 public void    setAttrDefault( String sDefault, boolean isReadOnly )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
   setAttrDefault( sDefault, isReadOnly, isReadOnly );
 }

 // reset display format
 public void    setAttrDefault()
 {
   setAttrDisplay( "", false, false );
   ncs_Value  = NcsCommon.tbd;
   //ncs_Script = "";
 }

 // set attribute fields - public method used in calling jsp
 public void    setAttrValue( String sValue )
 {  // "[hide|text|checkbox|radio|list] [ro|rw]"
   ncs_Value            = sValue;
 }

 // set attribute fields - internal method used in <attr>.jsp
 public String strSetValue( String sAttrName, String sValue ) {
   if ( sValue.equalsIgnoreCase( NcsCommon.tbd ))
     return (""); // no change
   else           // set form value by script
     return ( "<script type='text/javascript'>var form=document.forms[0]; setField( '_" + sAttrName + "', '" + sValue +"' );</script>" );
 }

 // set attribute fields - internal method used in <attr>.jsp
 private String strSetValue( String sAttrName ) {
   return ( strSetValue( sAttrName, ncs_Value ));
 }


 public String strAttrReadOnly()
 {
   // return ( ncs_Format_ro ? "READONLY DISABLED " : " " );
   return ( ( ncs_Format_disabled ? "DISABLED " : " " ) + ( ncs_Format_ro ? "READONLY " : " " ));
 }

 public String strAttrDisabled()
 {
   // return ( ncs_Format_ro ? "READONLY DISABLED " : " " );
   return ( ( ncs_Format_disabled ? "DISABLED " : " " ));
 }

 public boolean isAttrDisplay( String sType )
 {
   return ( ncs_Format.equalsIgnoreCase( sType ));
 }

 public boolean isAttrDisabled()
 {
   return ( ncs_Format_disabled );
 }

 public boolean isAttrReadOnly()
 {
   return ( ncs_Format_ro );
 }

 public boolean isAttrReadWrite()
 { 
   return ( !ncs_Format_ro );
 }

%>
<%--
    // debug with: 
   <h3> strAttrReadOnly()/getAttrDisplay() <%= strAttrReadOnly() %> / <%= getAttrDisplay() %> </h3>
--%>
