/*
 * NcsUtil_ncif_custom.java

			custom classes and properties
 *
 * Created Nov 2003
 *
 *
 *
 *    localized messages:
 *        Test.Test:    <%= ncsUtil_ncif_custom.getProperty( "Test.Test" ) %> <br>
 */

package com.ncif.imanager;

//import java.util.*; // Hashtable;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
//import com.novell.admin.ns.nds.NDSNamespace;
//import com.novell.application.console.snapin.ObjectEntry;
//import com.novell.ncsEMEA.util.*;
//import com.novell.nps.utils.Utils;


/** helper class for ncif
 *
 * @author Novell Consulting
 */
public class NcsUtil_ncif_custom extends com.novell.ncsEMEA.util.NcsCommon
{
  
  /**
   * Log4J Logger
   *  import org.apache.log4j.Logger;
   */
//  protected static Logger logger = Logger.getLogger(NcsUtil_ncif_custom.class);
  
  public static final String sPropertyFile   = "/com/novell/ncif_custom/resources.properties";
 
  
  /** constructor with default properties - use if no request available
   *
   */
  public NcsUtil_ncif_custom()
  {
    super(NcsUtil_ncif_custom.sPropertyFile );
  }
  
  
  /** preferred constructor: request specified
   *
   * @param request
   */
  public NcsUtil_ncif_custom(HttpServletRequest request)
  {
    super(NcsUtil_ncif_custom.sPropertyFile, request );
  }
  
  
}
