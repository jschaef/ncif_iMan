//
// do not use   "< %--..--% >"   but   "// < %--..--% >"      - this is JS, not JSP
// keine umlaute in external JS
//
//   function functionName () {  // dynamic parameter count:
//    for ( var a = 0; a < arguments.length; a++)
//      alert(arguments[a]);  
//    }
//
//   local vars indicated by "var" others set global
//
//
//   call potentially undefined function:
//     if ( self.myFunction != undefined )  myFunction( 'abc' ); 
//
//
//  \n   CRLF
//  \f   LF
//  \b   Backspace
//  \r   CR
//  \t   Tab
//  \"   quote
//

var ENABLED_COLOR									= "white";
var DISABLED_COLOR   							= "#EFEEE9";

var numChars         							= "0123456789";
var alphaCap         							= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var alphaSmall       							= "abcdefghijklmnopqrstuvwxyz";
var alphaAll         							= alphaCap + "_" + alphaSmall;
var alphaNum         							= alphaAll + numChars;

var VARTYPE_OBJECT                        = "object";
var VARTYPE_STRING                        = "string";
var VARTYPE_DATE                          = "date";
var VARTYPE_BOOLEAN                       = "boolean";
var VARTYPE_NUMBER                        = "number";
var VARTYPE_UNDEFINED                     = "undefined";

var REGEX_ValidIpAddress						= "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";
var REGEX_ValidHostname							= "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$";
  
function disableJavascriptErrors()
{
	window.onError = null;
}

  
// is the specified value in the list ...
//
function isValueInList( list, sValue )
{
	for ( var i=0; i<list.length; i++ ) 
	{
		if ( list[i].value == sValue ) return ( true );
	}
	return ( false );
}


// is the specified text in the list ...
//
function isTextInList( list, sValue )
{
	for ( var i=0; i<list.length; i++ ) 
	{
		if ( list[i].text == sValue ) return ( true );
	}
	return ( false );
}


      

// use name or ID to get field
function getFieldByNameOrId( sField )
{
	var field = document.getElementById( sField );
	if ( field == null ) field = document.getElementsByName( sField )[0];
	return ( field );
}



// remove items from a dropdown list, that do not match a given filter (case sensitive)
// sList is the ID of a listbox
// e.g. (     ( 'myList', '', 'secret' );
//
function filterListByValue( sList, sMustContain, sMustNotContain )
{
	var caseSensitive = false;  
	if ( !caseSensitive )
	{
		sMustContain    = sMustContain.toLowerCase();  
		sMustNotContain = sMustNotContain.toLowerCase();  
	}
	var list = getFieldByNameOrId( sList );
	if ( list == null )                return;
	if ( list.length == 0 )            return;
	for ( var i=list.length-1; i>=0; i-- ) 
	{
		var listValue = list[i].value;
		if ( !caseSensitive )
		{
			listValue    = listValue.toLowerCase();  
		}
		if ( (( sMustNotContain.length>0 )  && ( listValue.indexOf( sMustNotContain ) >= 0 ))  ||
			(( sMustContain.length>0 )     && ( listValue.indexOf( sMustContain ) < 0 ))     )
			{
			list[i] = null;
		}
	}
}

// <%-- clear all values in a listbox --%>
//
function clearListbox( sListName )
{
	list  = getFieldByNameOrId( sListName );
	if ( list == null )         return;
	if ( list.options == null ) return;
	if ( list.length  == null ) return;
	list.length = 0;
}


// parameters: sLbName (e.g. 'myList'), sortType (0: byValue; 1: byText)
function sortListbox( sLbName, sortType )
{
	if ( sortType == undefined ) sortType = 0;  // default: sort by value
	var SEPARATOR = "#%#";  // temp separator
	var lb        = getFieldByNameOrId( sLbName );
	// save currently selected value
	var lbValue   = lb.value;
	arrTexts = new Array(); 

	// combine key/value for sorting
	for(i=0; i<lb.length; i++) { 
		if ( sortType == 0 )
		{
			arrTexts[i] = lb.options[i].text + SEPARATOR + lb.options[i].value; 
		}
		else
		{
			arrTexts[i] = lb.options[i].value + SEPARATOR + lb.options[i].text; 
		}
	} 
	arrTexts.sort(); 
	// separate key/value and store back into list
	for(i=0; i<lb.length; i++) { 
		el = arrTexts[i].split( SEPARATOR ); 
		if ( sortType == 0 )
		{
			lb.options[i].text  = el[0]; 
			lb.options[i].value = el[1]; 
		}
		else
		{
			lb.options[i].text  = el[1]; 
			lb.options[i].value = el[0]; 
		}
		// restore old value
		lb.options[i].selected = ( lb.options[i].value == lbValue )
	} 
}




// <%-- check for changed listbox value --%>
//
function hasListboxChanged( sLbName, sLastValue ) 
{
	var sLbValue = getFieldValueByName( sLbName );
	return ( sLbValue != sLastValue );
}


function listboxAddItem( sList, sValue, sText, bSelected ) 
{
	var list = getFieldByNameOrId( sList );
	if ( list == null )                return;
	if ( list.length == null )         return;
	var listLength = list.length;
	list.length = listLength +1;
	if ( sText  != undefined )    list[listLength].text     = sText;
	if ( sValue != undefined )    list[listLength].value    = sValue;
	if ( bSelected != undefined ) list[listLength].selected = bSelected;
}



function listboxDisable( sList, bDisabled )
{
	elementDisable( sList, bDisabled ) ;
//		var list = getFieldByNameOrId( sList );
//      if ( list == null )                return;
//      if ( list.length == 0 )            return;
//      list.disabled = bDisabled;
}


function elementDisable( sName, bDisabled )
{
	var field = getFieldByNameOrId( sName );
	if ( field == null )                return;
	field.disabled = bDisabled;
}


// e.g.,    <INPUT type=text name="_Login_Time"> 
//          <script> disableControl( "_Login_Time" ) </script>
function disableControl(control)
{
	control.disabled = true;
	control.style.backgroundColor = DISABLED_COLOR;
}

function enableControl(control)
{
	control.disabled = false;
	control.style.backgroundColor = ENABLED_COLOR;
}






// cut off String before sSeparator - e.g. to cut off SN
// deleteStringBeforeSeparator( 'abc.def.ghi', '.' ) returns 'def.ghi'
//
function deleteStringBeforeSeparator ( sIn, sSeparator ) 
{
	var result = sIn;
	var p = sIn.indexOf( sSeparator );
	if ( p>=0 )
		result = result.substring( p + sSeparator.length, result.length );
	return ( result );
}


// cut off String after sSeparator - e.g. to cut off SN
// deleteStringAfterSeparator( 'abc.def.ghi', '.' ) returns 'abc'
//
function deleteStringAfterSeparator ( sIn, sSeparator ) 
{
	var result = sIn;
	var p = sIn.indexOf( sSeparator );
	if ( p>=0 )
		result = result.substring( 0, p );
	return ( result );
}

function extractCN ( sDN )
{
	return ( deleteStringAfterSeparator( sDN, '.' )); 
}


// extract highest element in DN
function getTopContainer( s )
{
	var result = s;
	var topIdx = result.lastIndexOf('.');
	if ( topIdx >= 0 ) result = result.substr( topIdx+1, 99 );
	return ( result );
}


//<%--

//      copy the contents of one field to another
//      exmp:  <input type=text name='abc' value=""
//                 onBlur="CopyField2Field('abc', 'def');"
//                 onKeyUp="CopyField2Field('abc', 'def');" >  
//      exmp:  <input type=text name='abc' value=""
//                 onChange="CopyField2Field('abc', 'def'); CopyField2Field('xxx', 'yyy');"
//                 >  
//      problem: does not detect entries through selector
//--%>
function CopyField2Field( nameSrc, nameDst )
{
	var src =  getFieldByNameOrId( nameSrc );
	var dst =  getFieldByNameOrId( nameDst );
	if ( (src != null) && (dst != null) ) {
		dst.value = getFieldValueByName( nameSrc ); // src.value; src.value not working for radio
	}
}




//<%--
//      * convert date into String format
//      * return US date string
//--%>
function ncsDate2String ( sDate )
{
	if ( isFinite( sDate ) ) // is number?
	{
		var date  = new Date( sDate );
		date.setTime( sDate );
		sDate     = date.toString();
		sDate = date.toString(); // date.toLocaleString();  
	}
	return ( sDate );
}


//<%--
//      * convert String into date format
//        check if conversion is requ'ed and handle German date format
//      * return date in ms since 1970
//--%>
function ncsString2Date ( sDate )
{
	var d_us = "SunMonTueWedThuFriSat";
	var d_de = "SonMonDieMitDonFreSam";

	var m_us = "JanFebMarAprMayJunJulAugSepOctNovDec";
	var m_de = "JanFebMarAprMaiJunJulAugSepOktNovDez";

	if ( sDate=="" )		    return ( sDate );   // not set
	if (isFinite(sDate))		    return ( sDate );  // if number, return as is (assume valid date)
	if (isFinite(Date.parse( sDate )))  return ( Date.parse( sDate ) );  // if valid date, return converted

	// convert German date format ...
	var date  = new Date();                   // get current date
	var dsc = date.toString().split( " " );   // use to get UTC part
	var dsa = sDate.split( " " );           // split date string
	var day = dsa[1].split( "." );          // cut off dot after day
	dsa[0]  = d_us.substr( d_de.indexOf(dsa[0].substr(0,3)), 3 );  // xlate day
	dsa[2]  = m_us.substr( m_de.indexOf(dsa[2].substr(0,3)), 3 );  // xlate month
	var dsx = dsa[0] + " " + dsa[2] + " " + day[0] + " " + dsa[4] + " " + dsc[4] + " " + dsa[3];

	var dt = Date.parse( dsx );
	return ( dt );
}



function ncsDecodeDate ( sAttr )
{
	var fld = getFieldByNameOrId( "_" + sAttr );
	if ( (fld==null) )
		return ( "NaN" ); // ( false );   // not mandatory
	return ( ncsString2Date ( fld.value ) );
}




//<%--
//      * the current version of the dateSelector widget (2003-08) does not handle locale dates correctly
//        use this function as workaround for Germany - it will reformat the dateSelector input 
//        from german format into UTC format
//      * must be called in onExit() before notifyAllOfExit()
//      * sAttr: the attribute name
//      * example:      fixDate( spValidFrom );
//      * obsolete after iMgr 2.0
//--%>    
function fixDate( sAttr )
{
	return; 
}





/** add years, months, days to a given date (or to current date)
    *
    */
function dateAdd( dateIn, diffY, diffM, diffD )
{
	var result = dateIn;
	if ( result == undefined ) result = new Date();   // default to current date
	result.setFullYear( result.getFullYear()  + diffY );     // add years
	result.setMonth(    result.getMonth()     + diffM );     // add months
	result.setDate(     result.getDate()      + diffD );     // add days
	result.setHours( 23, 59, 59, 59 );
	return( result );
}

/** calc difference between 2 dates - get exact difference in ms with result.getTime()
    */
function dateDelta( dateLo, dateHi, dimension )
{
	var result = undefined;
	try
	{
		var msLo    = Date.parse( dateLo );
		var msHi    = Date.parse( dateHi );
		var dtDiff  = new Date( msHi - msLo );
		result      = dtDiff.getTime();
		switch ( dimension )
		{
			case undefined:
			case "ms":
				break;
			case "day":
				result /= 24;     // no break;  continue
			case "hour":
				result /= 60;     // no break;  continue
			case "min":
				result /= 60;     // no break;  continue
			case "sec":
				result /= 1000;   // no break;  continue
				break;
			case "mon":
				result = 12 * (dtDiff.getUTCFullYear()-1970) + dtDiff.getUTCMonth();
				break;
			case "year":
				result      = (dtDiff.getUTCFullYear()-1970);
				break;
		}
	}
	catch (e)
	{
		alert( e );
	}
	return( result );
}


/** extract value from date field as Date() object
    *
    */
function dateGet( sAttr )
{
	var result = undefined;
	var fld_ms = getFieldByNameOrId( "_" + sAttr + "_ms" );
	if ( (fld_ms != null) && (fld_ms.value != null) )
	{
		result = new Date()
		result.setTime( fld_ms.value )
	}
	return( result );
}

/** extract value from date field as Date() object
    *
    */
function dateSet( sAttr, date )
{
	var fld    = getFieldByNameOrId( "_" + sAttr );
	var fld_ms = getFieldByNameOrId( "_" + sAttr + "_ms" );
	if (( fld_ms != undefined ) && ( fld != undefined ) && ( date != undefined ) && ( date.toString() != "NaN" ))
	{
		fld_ms.value  = Date.parse( date );
		fld.value     = date.toString();
	}
}


//<%--
//      * set the field to the current date plus/minus year/month/day (consider iMgr 2.0 / 2.01)
//      * sAttr:    the attribute name
//      * example:      setDateDiff( "spValidThrough", 0, 0, 7 );
//--%>    
function setDateDiff( sAttr, diffY, diffM, diffD )
{
	var date = dateAdd( undefined, diffY, diffM, diffD );
	dateSet( sAttr, date );
}

//<%--
//      * set the field to the current date (consider iMgr 2.0 / 2.01)
//      * set date field to date as string and (on 2.0.1) date_ms to date as ms 
//      * sAttr: the attribute name
//      * example:      currentDate( spValidFrom );
//--%>    
function currentDate( sAttr )
{
	setDateDiff( sAttr, 0, 0, 0 );
} 




//<%--
//      * display a date attribute that internally is coded as number and show as date string
//        (read input field and reformat)
//      * must be called in display routine of attribute (read input field and reformat)
//      * sAttr:      the attribute name
//      * example:    showAsDate( spValidFrom );
//--%>    
function showAsDate ( sAttr )
{
	var fld   = getFieldByNameOrId( "_" + sAttr );
	var sDate = fld.value; // sNumber;    // if invalid date, return as is (may be date string already)
	sDate = ncsDate2String ( sDate );
	fld.value = sDate;
}


//<%--
//      * used to make attributes input mandatory (for attributes where the business logic, but not 
//      *   the schema enforces a value)
//      * must be called in onExit() or isPageValid() after notifyAllOfExit()
//      * fm: the attribute input field;  fx: the attribute eDir field
//      * use with sMandatory( xxx ) which marks fields as mandatory
//      * example 
//               notifyAllOfExit();
//
//               success = !( missingMandatoryNamed( form.mandatory_company,   form.eDir$target$company, '<c:out value="${companyDisplayName}"/>' )
//                        ||  missingMandatoryNamed( form.mandatory_manager,   form.eDir$target$manager, '<c:out value="${managerDisplayName}"/>'  ) )
//               if(!success) 
//               {
//                  return false;
//               }
//      * negative equivalent of mandatoryPresent()
//      * deprecated - use missingMandatoryByName()
//--%>    
function missingMandatoryNamed( fm, fx, fName )
{ // check if a mandatory field is empty
	// fm: mandatory flag; fx: actual value; fName: display name
	// e.g.   missingMandatory( form.mandatory_manager, form.eDir$target$manager, "Manager Name" )
	if (fm==null)       return ( false );   // not mandatory
	if (fm.value == '') return ( false );   // dynamically set to "not mandatory"

	if (fx==null)
	{
		alert ( "Problem with field: " + fm.value );
		return ( true );    // value undefined (should not happen)
	}

	// is list ??
	var fxLen = fx.length;
	var fxVal = '';
	if (fxLen == null)
		fxVal = fx.value;
	else
		fxVal = fx[fx.selectedIndex].value;

	if ( fxVal.indexOf('<value>') < 0 )
	{
		if ( fName == '' )
			alertMissing( '', fm.value );
		else
			alertMissing( '', fName );
		return ( true );    // value not set (is "<attribute></attribute>")
	}

	return (false );      // mandatory value is present
}

//<%--
//      * used to make attributes input mandatory (for attributes where the business logic, but not 
//      *   the schema enforces a value)
//      * must be called in onExit() after notifyAllOfExit()
//      * fm: the attribute input field;  fx: the attribute eDir field
//      * use with sMandatory( xxx ) which marks fields as mandatory
//      * example 
//               notifyAllOfExit();
//
//               success = !( missingMandatoryByName( 'company', '<c:out value="${companyDisplayName}"/>' )
//                        ||  missingMandatoryByName( 'manager', '<c:out value="${managerDisplayName}"/>'  ) )
//               if(!success) 
//               {
//                  return false;
//               }
//--%>    
function missingMandatoryByName( sAttrName, sAttrDisplay ) 
{
	var fldMandatoryFlag = getFieldByNameOrId( 'mandatory_'    + sAttrName );
	if ( fldMandatoryFlag == null ) return ( false );
	var fldMandatoryEdir = getFieldByNameOrId( 'eDir$target$'  + sAttrName );
	if ( fldMandatoryEdir == null ) return ( false );
	return ( missingMandatoryNamed( fldMandatoryFlag, fldMandatoryEdir, sAttrDisplay ));
}



function missingMandatory( fm, fx )
{ // check if a mandatory field is empty
	// the 1st par is the mandatory flag, the 2nd par is the actual value, the 3rd is the display name
	// e.g.   missingMandatory( form.mandatory_manager, form.eDir$target$manager, "Big Boss" )
	return ( missingMandatoryNamed( fm, fx, '' ));
}


//<%--
//      * used to check presence of "mandatory" attributes (for attributes where the business logic, but not 
//      *   the schema enforces a value)
//      * must be called in onExit() after notifyAllOfExit()
//      * fm: the attribute input field;  fx: the attribute eDir field
//      * use with sMandatory( xxx ) which marks fields as mandatory
//      * example 
//               notifyAllOfExit();
//
//               success = ( mandatoryPresent( form.mandatory_company,                 form.eDir$target$company )
//                        && mandatoryPresent( form.mandatory_manager,                 form.eDir$target$manager ) )
//               if(!success)
//               {
//                  return false;
//               }
//      * negative equivalent of missingMandatory()
//--%>    
function mandatoryPresent( fm, fx )
{ 
	return ( !missingMandatory( fm, fx ) );
}

//      used with mved strings ( handles reload )
//         e.g.: success = ( mandatoryPresent(   form.mandatory_company,  form.eDir$target$company )
//                        && mandatoryPresentMv( form.mandatory_manager,  "_manager", "Manager" ) )
function mandatoryPresentMv( fm, fmv, fName )
{
	if (fm==null) return ( true );   // not mandatory
	var result = ( mvGetValueCount( fmv ) > 0 );
	if ( fName == '' ) fName = fm.value;
	if ( fName == '' ) fName = fmv;
	if ( !result ) alertMissing( '', fName );
	return ( result );
}

      


function alertMissing( sText, sField )
{
	if ( sText=='' ) sText = "Missing Mandatory field";
	alert ( sText + ": " + sField );
}


//<%--
//      * used to make attributes input mandatory (for attributes where the business logic, but not 
//      *   the schema enforces a value)
//      * must be called in onExit() before or after notifyAllOfExit()
//      * fm: the attribute input field;  fx: the attribute FORM field
//      * use with sMandatory( xxx ) which marks fields as mandatory
//      * unlike missingMandatoryNamed, this function checks the input field (before or after notifyAllOfExit(); )
//      * example 
//               success = !( missingMandatoryField( form.mandatory_company,   form._company, '<c:out value="${companyDisplayName}"/>' )
//                        ||  missingMandatoryField( form.mandatory_manager,   form._manager, '<c:out value="${managerDisplayName}"/>'  ) )
//               if(!success)
//               {
//                  return false;
//               }
//      * negative equivalent of mandatoryPresent()
//--%>    
// check if a mandatory field is empty
// fm: mandatory flag; fx: actual value; fName: display name
// e.g.   missingMandatoryField( form.mandatory_manager, form._manager, "Manager Name" )
//  
function missingMandatoryField( fm, f, fName )
{
	if (fm==null) return ( false );   // not mandatory
	var fValue = getFieldValueByObject( f );
	if (fValue == '')
	{
		if ( fName == '' ) fName = fm.value;
		alertMissing( '', fName );
		return ( true );
	}
	return (false );      // mandatory value is present
}



//<%--
//      * extract attribute from option list that was created with NcsUtil functions like
//        arrayListToHtmlList, getObjectsAsOptionList, etc
//        'list' can be name or list form field
//        example:
//
//         <SELECT name="myList" onchange='doSomething();' >
//            <%= NcsUtil.getObjectsAsOptionList( ncs_ns, "myOu.Ou", "User", "", "myAttribute1;myAttribute2", "", true ) %>
//         </SELECT>
//
//     <script>
//          function doSomething()
//          {
//            var myData   = extractAttachedAttribute ( "myList",     "myAttribute1", "n/a" );
//            if ( myData != "" )          alert( myData );
//            var myData2   = extractAttachedAttribute ( form.myList, "myAttribute2", "n/a" );
//            if ( myData2 != "" )          alert( myData2 );
//          }
//     </script>
//--%>    
function extractAttachedAttribute ( list, sAttrName, sDefault )
{
	if ( sDefault == null ) sDefault = "";
	var result	    = sDefault; // "";
	if ( list.selectedIndex == null ) list = getFieldByNameOrId( list );
	if ( list == null )	return (result);
	var idx         = list.selectedIndex;
	if (idx<0)		return (result);
	result          = extractAttachedAttributeFromItem ( list.options[idx], sAttrName, sDefault );
	//        var sInf    = option.id;    // packed string with attr info  // e.g, 0.736532//spBuilding=abc//roomNumber=123
	//        var saAttr  = sInf.split( "//" );
	//        for ( var i=0; i<saAttr.length; i++ )
	//        {
	//          var saInfo = saAttr[i].split( "=" );
	//          if ( saInfo[0]==sAttrName )
	//          {
	//           // if ( saInfo[0] != '' ) result = saInfo[1];  // does not work for multiple '=' in data
	//           if ( saInfo[0] != '' )    result = saAttr[i].split( sAttrName+'=' )[1];
	//           return (result);
	//          }
	//        }
	return (result);
}

function extractAttachedAttributeFromItem ( listItem, sAttrName, sDefault )
{
	var result	    = sDefault; // "";
	var listItem_id = listItem.id;    // packed string with attr info  // e.g, 0.736532//spBuilding=abc//roomNumber=123
	var saAttr      = listItem_id.split( "//" );
	for ( var i=0; i<saAttr.length; i++ )
	{
		var saInfo = saAttr[i].split( "=" );
		if ( saInfo[0]==sAttrName )
		{
			if ( saInfo[0] != '' )    result = saAttr[i].split( sAttrName+'=' )[1];
			return (result);
		}
	}
	return (result);
}


//<%--
//      * set a field value (by field name)
//      * example:  setFieldValue( "myEditBox", "abc" )
//--%>    
function setFieldValue( sFieldName, sFieldValue ) 
{
	var field    = getFieldByNameOrId( sFieldName );
	if ( field != null )
	{
		switch ( field.type )
		{
			case 'text':
			case 'hidden':
				field.value    = sFieldValue;
				break;
			case 'radio':
				setRadioValue( sFieldName, sFieldValue );
				break;
			case 'checkbox':
				field.checked  = sFieldValue;
				break;
			case 'select-one':
				selectListItemByValue_IgnoreCase( field, sFieldValue );
				break;
			default:
				alert ( sFieldName + ": " + field.type );
		}
	/*
*                                    if ( field.type == 'text' )      field.value    = sFieldValue;
		else  if ( field.type == 'hidden' )    field.value    = sFieldValue;
		else  if ( field.type == 'radio' )     setRadioValue( sFieldName, sFieldValue );
		else  if ( field.type == 'checkbox' )  field.checked  = sFieldValue;
		else  if ( field.type == 'select-one') selectListItemByValue_IgnoreCase( field, sFieldValue );
		else  alert ( sFieldName + ": " + field.type );
		}
*/
	}
}


//<%--
//      * set a field value (by field name)
//      * example:  setField( "myEditBox", "abc" )
//      * deprecated - use setFieldValue()
//--%>    
function setField( sFieldName, sFieldValue )
{
	setFieldValue( sFieldName, sFieldValue );
}


// fieldRadio is form element (e.g. form.myRadio )
function setRadioValue( sFieldName, sValue )
{
	var fieldRadio = document.getElementsByName( sFieldName );
	if ( fieldRadio        == null ) return;
	if ( fieldRadio.length == null ) return;
	for ( var i = 0; i<fieldRadio.length; i++ )
	{
		fieldRadio[i].checked = ( fieldRadio[i].value == sValue );
	}
}



//<%--
//      * select an item from a SELECT list (by value) - not case-sensitive
//      * example:  selectListItemByValueCase( "myList", "abc" )
//--%>    
function selectListItemByValueCase( sListName, sSelect, bCaseSensitive )
{
	var list  = getFieldByNameOrId( sListName );
	if ( list == null )	return;
	for ( var i=0; i < list.length; i++ )
	{
		var sVal = list.options[i].value; // .replace( /\W/, "");  // remove all non-alphanum chars
		var bMatch = false;
		if ( bCaseSensitive )
			bMatch = ( sVal == sSelect );
		else
			bMatch = ( sVal.toUpperCase() == sSelect.toUpperCase() );
		if ( bMatch )
		{
			list.selectedIndex = i;
			return;
		}
	}
}

//<%--
//      * select an item from a SELECT list (by value) - not case-sensitive
//      * example:  selectListItemByValue_IgnoreCase( "myList", "abc" )
//--%>    
function selectListItemByValue_IgnoreCase( sListName, sSelect )
{
	selectListItemByValueCase( sListName, sSelect, false );
}


//<%--
//      * select an item from a SELECT list (by value) - case-sensitive
//      * example:  selectListItemByValue( "myList", "abc" )
//      * note: rename to listboxSelectItem* 
//--%>    
function selectListItemByValue( sListName, sSelect )
{
	selectListItemByValueCase( sListName, sSelect, true );
}


//<%--
//      * select an item from a SELECT list (by display name)
//      * example:  selectListItem( "myList", "abc" )
//--%>    
function selectListItemByDisplay( sListName, sSelect )
{
	var list  = getFieldByNameOrId( sListName );
	if ( list == null )	return;
	for ( var i=0; i < list.length; i++)
	{
		if ( list.options[i].text==sSelect )
		{
			list.selectedIndex = i;
			return;
		}
	}
}
 
//<%-- deprecated - use selectListItemByDisplay --%>    
function selectListItem( sListName, sSelect )
{
	selectListItemByDisplay( sListName, sSelect )
}
 


//<%--  enable/disable OK/Apply/Cancel buttons on a book page  --%>
// in a book, "what" can be "parent.bookHeader", "parent.bookBody", "parent.bookFooter"
function pageImageShow( what, elementTitle, enable )
{
	if ( what.document.images != null )
	{
		for ( var i=0; i<what.document.images.length; i++ )
		{ // changed to reflect iMgr 2.5
			var img = what.document.images[i];
			var btn = "btn"+elementTitle.toLowerCase();
			var bFound = (( img.title == elementTitle ) || ( img.src.indexOf( btn ) >= 0 ));
			// alert ( i + ": " + img.title  + "/" + bFound + "/" + img.src.indexOf( btn ) + "/" + img.src );            
			if ( bFound )
			{
				if ( enable )
					img.width = 86;
				else
					img.width = 0;
			}
		}
	}
}

//      <%--  enable OK button on the footer of a book page --%>
function pageButtonEnable_OK()
{ 
	pageImageShow( parent.bookFooter, "OK", true ); 
}


//      <%--  enable Cancel button on the footer of a book page --%>
function pageButtonEnable_Cancel()
{
	pageImageShow( parent.bookFooter, "Cancel", true );
	pageImageShow( parent.bookFooter, "Abbrechen", true );
}

//      <%--  enable Apply button on the footer of a book page --%>
function pageButtonEnable_Apply()
{
	pageImageShow( parent.bookFooter, "Apply", true );
	pageImageShow( parent.bookFooter, "Anwenden", true );
}

//      <%--  disable OK button on the footer of a book page --%>
//      make sure to enable when leaving the page @ isPageValid
function pageButtonDisable_OK()
{ 
	pageImageShow( parent.bookFooter, "OK", false ); 
}

//      <%--  disable Cancel button on the footer of a book page --%>
//      make sure to enable when leaving the page @ isPageValid
function pageButtonDisable_Cancel()
{
	pageImageShow( parent.bookFooter, "Cancel", false );
	pageImageShow( parent.bookFooter, "Abbrechen", false );
// <IMG src="nps/portal/modules/dev/images/de/btncancel_de.gif" ...
}

//      <%--  disable Apply button on the footer of a book page --%>
//      make sure to enable when leaving the page @ isPageValid
function pageButtonDisable_Apply()
{
	pageImageShow( parent.bookFooter, "Apply", false );
	pageImageShow( parent.bookFooter, "Anwenden", false );
// <IMG src="nps/portal/modules/dev/images/de/btnapply_de.gif" ...
}

//    <%--  en/disable button on the footer of a book page (-1:disable; 0:unchanged; 1:enable) --%>
//    e.g. activatePageButtons( -1, 0, -1 )
function activatePageButtons( iCancel, iOK, iApply )
{
	if ( iCancel  == -1 ) pageButtonDisable_Cancel();
	if ( iOK      == -1 ) pageButtonDisable_OK();
	if ( iApply   == -1 ) pageButtonDisable_Apply();
	if ( iCancel  ==  1 ) pageButtonEnable_Cancel();
	if ( iOK      ==  1 ) pageButtonEnable_OK();
	if ( iApply   ==  1 ) pageButtonEnable_Apply();
}
      

      
//      <%--  make a tag or group visible or hide it --%>
function makeVisible( sField, bShow )
{ // initial stype must include "style='visibility:visible;display:inline' or 'visibility:visible;display:none' "
	var field = getFieldByNameOrId( sField );
	if ( field == null ) return;
	field.style.visibility	= (( bShow ) ? 'visible' : 'hidden' );
	field.style.display		= (( bShow ) ? 'inline'  : 'none'   );
}



// dynamically set attributes to (not)mandatory 
//   use with     < % ncs_Hint = sMandatory( "myAttribute" ); % >
//         if ( xxx ) setMandatory( "myAttribute", false ); 
function setMandatory( sAttrName, bMandatory )
{
	var fMandatory = getFieldByNameOrId( 'mandatory_' + sAttrName );
	if ( bMandatory ) 
		fMandatory.value = sAttrName;
	else 
		fMandatory.value = '';
	makeVisible( 'mandatoryFlag_' + sAttrName, bMandatory )
}
       


//      <%-- convert string into hex string, e.g. for stream attributes --%>
function str2hex( s )
{
	var result = "";
	for ( var i=0; i<s.length; i++)
	{
		result += s.charCodeAt(i).toString(16);
	}
	return (result);
}


// check if array contains element
function arrayContainsValue( ar, val )
{
	for ( var iArrayIndex=0; iArrayIndex<ar.length; iArrayIndex++ )
	{
		if ( ar[iArrayIndex] == val ) return ( true );
	}
	return ( false );
}

// add value to array (opt: check for existence, first )
function arrayAppendValue3( ar, val, bUnique )
{
	bExists = arrayContainsValue( ar, val );
	// alert( 'bExists (' + val + '): ' + bExists ); 
	if ( !bUnique || !bExists )
	{
		ar.push( val );  
	// ar.length     = ar.length + 1;
	// ar[ar.length-1] = val;
	}
}

// add value to array (without check for existence )
function arrayAppendValue( ar, val )
{
	arrayAppendValue3( ar, val, false );
}


//      <%-- add value to mved field --%>
//      <%-- e.g.: mvAddValue( "_Given_Name", "blabla" )  --%>
function mvAddVal( mved, newVal )
{
	var packedData  = mvGetValuesAsPack( mved );
	var list        = new Array();
	list            = unpack( packedData );
	if ( !arrayContainsValue( list, newVal ))
	{ // add only, if not yet present
		// alert( 'mvAddValue: ' + newVal );
		arrayAppendValue( list, newVal, true );
		packedData = pack( list );
		mvLoadFromPack( mved, packedData );
	}
}


//      <%-- delete value from mved field --%>
//      <%-- e.g.: mvDelValue( "_Given_Name", "blabla" )  --%>
function mvDelValue( mved, delVal )
{
	var packedData  = mvGetValuesAsPack( mved );
	var arData      = new Array();
	var arOut       = new Array();
	arData          = unpack( packedData );
	arOut.length  = 0;
	for ( var i=0; i<arData.length; i++ )
	{
		if ( arData[i] != delVal )
		{
			arOut[arOut.length] = arData[i];
		}
	}
	packedData = pack( arOut );
	mvLoadFromPack( mved, packedData );
}


//      <%-- set value in mved field --%>
//      <%-- e.g.: mvSetValue( "_Given_Name", "blabla" )  --%>
function mvSetValue( mved, newVal )
{
	var arData        = new Array();
	arData.length     = 1;
	arData[0]         = newVal;
	var packedData = pack( arData );
	mvLoadFromPack( mved, packedData );
}


// sort current values of an mved control
// e.g. sortMved( "_Member" );
// 
function sortMved( mved )
{
	var packedData  = mvGetValuesAsPack ( mved );
	var arData      = unpack( packedData );
	if ( arData == null ) return;
	if ( arData.length>1 ) 
	{
		arData.sort();
		packedData      = pack( arData );
		mvLoadFromPack ( mved, packedData );
	}
}
    

// replace all dots by escaped dots (for eDir names)
function unescapeDots( s ) 
{
	return ( s.replace( /\\\./g, "\." ));  // revert existing escaped dots
}

// replace all dots by escaped dots (for eDir names)
function escapeDots( s ) 
{
	s = unescapeDots( s );                // revert existing escaped dots
	// s = s.replace( /\\\./g, "\." );       // revert existing escaped dots
	return ( s.replace( /\./g, "\\." ));  // escape dots
}

function encode_utf8( s )
{
	return unescape( encodeURIComponent( s ) );
}

function decode_utf8( s )
{
	return decodeURIComponent( escape( s ) );
}


//      <%--  (un)check checkbox --%>
function setCheckbox ( sFieldname, bCheck )
{
	field = getFieldByNameOrId( sFieldname );
	if ( field == null ) return;
	field.checked = bCheck;
}



//      <%-- check/unckeck all checkboxes in current form --%>
function checkAll( val )
{
	for ( var i=0; i<document.forms[0].elements.length; i++ )
	{
		var elem = document.forms[0].elements[i];
		if (elem.type == "checkbox")
		{
			elem.checked = val;
		}
	}
}


//<%--  see:    com.novell.nps.utils.Utils.toDisplay( s ) 
//
//      function unEscape( s )
//      {
//        var result = '';
//        var c;
//        for ( var i=0; i<s.length; i++ )
//        {
//          c = s.charat(i);
//          if ( c == '\' ) c = '\\';
//          if ( c == 'a' ) c = 'A';
//          if ( c == '<' ) c = '&lt;';
//          if ( c == '>' ) c = '&gt;';
//          result = result + c;
//        }
//        return ( result );
//      }
//--%>

// drop down list or text field: return selected value (from object)
// e.g. getSelectedOption( document.forms[0].myList );
//  deprecated - use getFieldValueByObject()
//
function getSelectedOption( f )
{
	return ( getFieldValueByObject( f ) );
}


// radio is form element (e.g. form.myRadio )
function getRadioValue( radio )
{
	// alert ( "XgetRadioValue: radio=" + radio + " - radio.size=" + radio.size + " - radio.length=" + radio.length + " - radio.checked=" + radio.checked  + " - radio.value=" + radio.value );
	if ( radio        == null ) return( '' );

	if ( radio.checked != null )
	{ // if there's only one box, we do not have an array ... (2006-11-20)
		if ( radio.checked ) return ( radio.value );
	}
	for ( var i = 0; i<radio.length; i++ )
	{
		if ( radio[i].checked )  return ( radio[i].value );
	}
	return( '' );
}

// radio is form element name (e.g. "myRadio" )
function getRadioboxValue( radioName )
{
	radio  = getFieldByNameOrId( radioName );
	return ( getRadioValue( radio ) );
}


// drop down list: return selected display value (from object)
// e.g. getListboxTextByObject( document.forms[0].myList );
//
function getListboxTextByObject( f )
{
	if ( f==null )                  return ( '' );
	if ( f.selectedIndex < 0 )      return ( '' );
	if ( f.selectedIndex == null )  return ( '' );
	return ( f.options[f.selectedIndex].text );
}


// drop down list: return selected display value (from object name)
// e.g. getListboxTextByName( "myField" );
//
function getListboxTextByName( lbName )
{
	f =  getFieldByNameOrId( lbName );
	return ( getListboxTextByObject( f ));
}


// drop down list or text field: return selected value (from object)
// e.g. getFieldValueByObject( document.forms[0].myList );
//
function getFieldValueByObject( f )
{
	if ( f==null )                                  return ( '' );                                  // invalid field
	if ( f.value != null )                          return ( f.value );                             // text box
	if ( f.selectedIndex != null )                  return ( f.options[f.selectedIndex].value );    // list
	if (( f.length >0 ) && ( f[0].checked != null)) return ( getRadioValue( f ));                  // radio
	return ( '' );
}




// drop down list or text field: return current value (from object name)
// e.g. getFieldValueByName( "myField" );
//
function getFieldValueByName( fldName )
{
	f =  getFieldByNameOrId( fldName );
	if (f == null) return (f);
	if ( f.type == 'radio' ) f = document.getElementsByName( fldName );
	return ( getFieldValueByObject( f ) );
}


// check if passed string is a number
// see also isFinite()
//
function isNum( str )
{
	if ( str=="" ) return false;
	for ( var i=0; i<str.length; i++ )
	{
		if ( str.charAt( i ) < "0") return false;
		if ( str.charAt( i ) > "9") return false;
	}
	return true;
}
      
// <%-- e.g. onlyValidCharacters( "this", "abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" ) --%>
function onlyValidCharacters( str, sValid )
{
	if ( str=="" ) return false;
	for ( var i=0; i<str.length; i++ )
	{
		if ( sValid.indexOf( str.charAt(i) ) <0 ) return ( false );
	}
	return ( true );
}


function isAlphaNum( str )
{
	return ( onlyValidCharacters( str, alphaNum )); // "abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" ));
}


function isAlpha( str )
{
	return ( onlyValidCharacters( str, alphaAll )); // "abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ" ));
}
      
      
//<%--
//
//function readFile (fileName) {
//  //var form = document.forms[0];
//  var result;
//  if (document.layers && navigator.javaEnabled()) 
//  {
//    netscape.security.PrivilegeManager.enablePrivilege('UniversalFileRead');
//    var bfr = new java.io.BufferedReader(new java.io.FileReader(fileName));
//    var line;
//    result = '';
//    while ((line = bfr.readLine()) != null)
//      result += line + java.lang.System.getProperty('line.separator');
//  }
//  else 
//  if (document.all) 
//  {
//    var fso = new ActiveXObject('Scripting.FileSystemObject');
//    var fs = fso.OpenTextFile(fileName);
//    result = fs.ReadAll();
//  }
//    return result;
//}   
//
//--%>

      
function verifyIp( ipValue ) 
{
	errorString = "";
	theName = "IP Address";
	errInvalid   = ipValue + ' is not a valid ' + theName;
	errForbidden = theName + ': ' + ipValue + ' cannot be used here';
	var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
	var ipArray = ipValue.match(ipPattern);

	if ( ipValue == null )      return ( true );
	if ( ipValue == '' )        return ( true );

	if ( ipValue == "0.0.0.0" )
		errorString = errorString + errForbidden;
	else if ( ipValue == "255.255.255.255" )
		errorString = errorString + errForbidden;
	else if ( ipValue == null )
		errorString = errorString + errInvalid;
	else if ( ipArray == null )
		errorString = errorString + errInvalid;
	else {
		for ( var i=1; i<=4; i++ ) {
			thisSegment = ipArray[i];
			if ( ( thisSegment == null ) || ( thisSegment > 255 )) {
				errorString = errorString + errInvalid;
				i = 4;
			}
			if ( ( i==0 ) && ( thisSegment == 255 )) {
				errorString = errorString + errForbidden;
				i = 4;
			}
		}
	}
	if ( errorString != "" ) alert ( errorString );
	return ( errorString == "" );
}


function verify_ip_field ( fldName ) 
{
	ip =  getFieldByNameOrId( fldName );
	if ( ip == null )           return;
	if ( ip.value == null )     return;
	if ( !verifyIp( ip.value )) ip.value = "";
}


// return false if the passed variable is an empty string or null
// 
function stringNotEmpty ( s )
{ 
	if ( s == null ) return false;
	return ( s.length > 0 );
}

// return true if the passed variable is an empty string or null
// 
function stringEmpty ( s )
{ 
	return ( !stringNotEmpty ( s ) );
}


// return true if the passed variable is a string array (vs. string)
// 
function isStringArray( s )
{
	if ( typeof( s ) != 'object' ) return false;
	var o = new Object( s[0] );
	return ( o.length > 0 );
}


// helper function to compare 2 DNs (returns -1/0/+1)
//
function compareDNs( a, b )
{
	var arA = a.split(".").reverse();
	var arB = b.split(".").reverse();
	for ( var i = 0; i < arA.length; i++ )
	{
		if ( arA[i] == arB[i] ) continue;
		if ( arA[i] == null )  return (-1);
		if ( arB[i] == null )  return (1);
		if ( arB[i] > arA[i] ) return (-1);
		if ( arB[i] < arA[i] ) return (1);
	}
	return (0);
}
  
// sort an array of DNs 
function sortArrayByDn( ar )
{
	ar.sort ( compareDNs );
}


function getLaunchUrl( action, sTarget, sTask, sPage, sParam )
{
	var result = "frameservice?NPService=fw.LaunchService";
	// result    += "&launcher=fw.HomePage";	// ws201201
	result    += "&launcher="  + (( ncs.thisTask != null )  ? ncs.thisTask : "fw.HomePage" );
	if ( action == "delegate" )
	{
		result    += "&NPAction=Delegate";
		result    += "&lifecycle=Recreate";
		if ( stringNotEmpty(sTask) )      result += "&delegate="      + sTask;
	}
	if ( action == "launch" )
	{
		result    += "&NPAction=Launch";
		result    += "&lifecycle=New";
		if ( stringNotEmpty(sTask) )        result += "&launch="        + sTask;
	}
	if ( stringNotEmpty(sTarget) )        result += "&targetNames="   + sTarget;
	if ( stringNotEmpty(sPage) )          result += "&initialPageId=" + sPage;
	if ( stringNotEmpty(sParam))          result += sParam;
	return( result );
}



// example:  < % -- iman:button key="OK" onClick="redirect( delegationUrlDirect('jdoe.customer', 'myModule.mybook_EditCustomerOU'));"/ -- % >
// sTarget is optional ( to omit use "" )
// sPage is optional for books ( omit or use "" )
// internal helper function for delegationUrl()
//     does nothing with sTarget
function delegationUrlDirect ( sTarget, sTask, sPage )
{
	var result     =  getLaunchUrl( "delegate", sTarget, sTask, sPage, "" );
	return ( result );
}

// launch a task in new window
// sTarget is optional DN or DN list ( to omit use "" ) - must be packed
// sPage is optional for books ( to omit use "" )
// sParam is optional to pass additional request strings ( e.g.  "&searchRecurse=true&searchBase=o=novell|o=admin" )
//     
//  example:  <launchUrlDirect( "MYTARGET", "shared_task_xxx", "", "Window", "location=no,dependent=yes,resizable=no,menubar=no", "" );
//
function launchUrlDirect ( sTarget, sTask, sPage, sTargetWindow, sWindowSpec, sParam )
{
	var url     =  getLaunchUrl( "launch", sTarget, sTask, sPage, sParam );
	if ( stringEmpty( sTargetWindow ))  sTargetWindow = '_blank';
	if ( stringEmpty( sWindowSpec ))    sWindowSpec   = 'location=no,dependent=yes,resizable=yes,menubar=no';
	var newWindow = window.open( url, sTargetWindow, sWindowSpec );
	if (newWindow.opener == null) newWindow.opener = self;
	newWindow.focus();
}

function launchSelector_searchUser( sSharedTask, sParam )
{
	launchUrlDirect( "", sSharedTask, "", "Window", "width=800,height=800,location=yes,dependent=yes,resizable=yes,menubar=no,scrollbars=yes", sParam );
}


// sTargetArray is optional array of target strings ( to omit use "" )
// sPage is optional for books ( omit or use "" )
// bPack t/f: pack sTarget?
//        function replaces delegationHref()
function delegationUrl_Array ( sTargetArray, bPack, sTask, sPage )
{
	var sTarget = "";
	if ( sTargetArray != null ) 
	{
		if ( bPack )
			sTarget = pack ( sTargetArray);
		else
			sTarget = sTargetArray;
	}
	return ( delegationUrlDirect ( sTarget, sTask, sPage ));
}
    
    
// sTargetString is optional array of target strings ( to omit use "" )
// sPage is optional for books ( omit or use "" )
// bPack t/f: pack sTarget?
//        function replaces delegationHref()
function delegationUrl_String ( sTargetString, sTask, sPage )
{
	if ( sTargetString.length > 0 ) sTargetString = "P:" + encodeURI( encodeURI( sTargetString )) + "P"; // dupl encoding req'd for Umlaut
	return ( delegationUrlDirect ( sTargetString, sTask, sPage ));
}
    
    
// example:  < % -- iman:button key="OK" onClick="redirect(delegationHref('TC3.customer', 'myModule.mybook_EditCustomerOU'));"/ -- % >
// sObject is optional ( to omit use "" )
// sPage is optional for books ( omit or use "" )
// 
//
function delegationHref ( sTarget, sTask, sPage )
{
	// return ( delegationUrl_String ( sTarget, sTask, sPage ));
	if ( isStringArray( sTarget ))
	{
		return ( delegationUrl_Array ( sTarget, true, sTask, sPage ));
	}
	else
	{
		return ( delegationUrl_String ( sTarget, sTask, sPage ));
	}
}


// redirect current frame
// example:  redirectFrame("www.novell.com");
function redirectFrame ( url )
{
	location.href = url;
}


// redirect parent 
// example:  redirect("www.novell.com");
function redirect ( url )
{
	parent.location.href = url;
}


// set DHTML texts ...
//  	example: dhtmlMessage( 'progressMessage', 'done' );
//	    <DIV id='progressMessage' > Please wait ...<DIV> ( initially must contain something, e.g. "<DIV id='xx' >&nbsp;<DIV> )
//    can be any tag, DIV, FONT, ...
//
function dhtmlMessage( tagName, sMessage )
{
	var tag =  getFieldByNameOrId( tagName );
	if ( tag !== null )  
	{
		if ( tag.childNodes !== null )  
		{
			while ( tag.childNodes.length>0 )
			{ 
				// tag.removeChild( tag.firstChild ); 
				tag.removeChild( tag.childNodes[0] );
			}
		}
		if ( sMessage !== '' ) tag.appendChild( document.createTextNode( sMessage ));
	}
}


////    prepare to submit page in given mode (reload or submit)
////    e.g.:  setImanagerFormFields( sOption, '<.. ncs_thisJspId ..>', '<.. c.var("taskId") ..>', '<.. c:out value="${param.eDir$target}"/ ..>' )
////
//function setImanagerFormFields( sOption, sJspId, sTaskId, sTarget )
//{ // <%-- sOption can be   "SHOW"/"APPLY" (book page) / "PRECREATE"/"CREATE" (create) / "PREEDIT"/"WRITE" (modify task) --%> 
//	var form = document.forms[0];
//	if ( sOption == "SHOW" ) // LOAD BOOK PAGE
//	{
//		if ( form.nextState != null )   form.nextState.value    = "initialState";
//		if ( form.taskId != null )      form.taskId.value       = sTaskId;
//	}
//	if ( sOption == "APPLY" ) // SUBMIT BOOK PAGE
//	{
//		if ( form.nextState != null )   form.nextState.value    = "apply";
//		if ( form.taskId != null )      form.taskId.value       = sTaskId;
//	}
//	if ( sOption == "PRECREATE" ) // LOAD CREATE TASK
//	{
//		if ( form.eDirCommand != null ) form.eDirCommand.value  = "preCreate";
//		if ( form.merge != null )       form.merge.value        = sJspId;
//		if ( form.nextState != null )   form.nextState.value    = "initialState";
//		if ( form.taskId != null )      form.taskId.value       = sTaskId;
//	}
//	if ( sOption == "CREATE" ) // PERFORM CREATE TASK
//	{
//		if ( form.eDirCommand != null ) form.eDirCommand.value  = "create";
//		if ( form.merge != null )       form.merge.value        = "dev.GenConf";
//		if ( form.nextState != null )   form.nextState.value    = "eDasServiceAccess";
//	}
//	if ( sOption == "PREEDIT" ) // LOAD EDIT TASK
//	{
//		if ( form.eDirCommand != null )   form.eDirCommand.value  = "read";
//		if ( form.merge != null )         form.merge.value        = sJspId;
//		// if ( form.nextState != null )  form.nextState.value = "";
//		if ( form.eDir$target != null )   form.eDir$target.value  = sTarget;
//	}
//	if ( sOption == "WRITE" )// PERFORM EDIT TASK
//	{
//		if ( form.eDirCommand != null ) form.eDirCommand.value  = "Write";
//		if ( form.merge != null )       form.merge.value        = "dev.GenConf";
//		// if ( form.nextState != null )   form.nextState.value = "???";
//		if ( form.eDir$target != null ) form.eDir$target.value  = sTarget;
//	}
//}
//

//    prepare to submit page in given mode (reload or submit)
//    e.g.:  setImanagerFormFields( sOption, '<.. ncs_thisJspId ..>', '<.. c.var("taskId") ..>', '<.. c:out value="${param.eDir$target}"/ ..>' )
//
function setImanagerFormFields( sOption, sJspId, sTaskId, sTarget )
{ // <%-- sOption can be   "SHOW"/"APPLY" (book page) / "PRECREATE"/"CREATE" (create) / "PREEDIT"/"WRITE" (modify task) --%> 
	var form = document.forms[0];
	switch ( sOption )
	{
		case "SHOW": // LOAD BOOK PAGE
		{
			if ( form.nextState != null )   form.nextState.value    = "initialState";
			if ( form.taskId != null )      form.taskId.value       = sTaskId;
		}
		case "APPLY": // SUBMIT BOOK PAGE
		{
			if ( form.nextState != null )   form.nextState.value    = "apply";
			if ( form.taskId != null )      form.taskId.value       = sTaskId;
		}
		case "PRECREATE": // LOAD CREATE TASK
		{
			if ( form.eDirCommand != null ) form.eDirCommand.value  = "preCreate";
			if ( form.merge != null )       form.merge.value        = sJspId;
			if ( form.nextState != null )   form.nextState.value    = "initialState";
			if ( form.taskId != null )      form.taskId.value       = sTaskId;
		}
		case "CREATE": // PERFORM CREATE TASK
		{
			if ( form.eDirCommand != null ) form.eDirCommand.value  = "create";
			if ( form.merge != null )       form.merge.value        = "dev.GenConf";
			if ( form.nextState != null )   form.nextState.value    = "eDasServiceAccess";
		}
		case "PREEDIT": // LOAD EDIT TASK
		{
			if ( form.eDirCommand != null )   form.eDirCommand.value  = "read";
			if ( form.merge != null )         form.merge.value        = sJspId;
			// if ( form.nextState != null )  form.nextState.value = "";
			if ( form.eDir$target != null )   form.eDir$target.value  = sTarget;
		}
		case "WRITE": // PERFORM EDIT TASK
		{
			if ( form.eDirCommand != null ) form.eDirCommand.value  = "Write";
			if ( form.merge != null )       form.merge.value        = "dev.GenConf";
			// if ( form.nextState != null )   form.nextState.value = "???";
			if ( form.eDir$target != null ) form.eDir$target.value  = sTarget;
		}
		
	}
	
	
}




// return the nth element from a dn; negative: count from end
//
// extract_Element( 'aa.bb.cc.dd', 0 )  -> 'aa'
// extract_Element( 'aa.bb.cc.dd', 1 )  -> 'bb'
// extract_Element( 'aa.bb.cc.dd', -1 )  -> 'dd'
//
function extract_Element( dn, elementNr )
{
	var saElem = dn.split( '.' );
	var result = '';
	if (( elementNr>=0 ) && ( saElem.length>elementNr ))
		result = saElem[elementNr];
	if (( elementNr<0 ) && ( saElem.length>=Math.abs(elementNr) ))
		result = saElem[saElem.length+elementNr];
	return (result);
}


// return n elements from a dn; negative: count from end
//
// extract_Elements( 'aa.bb.cc.dd', 1 )  -> 'aa'
// extract_Elements( 'aa.bb.cc.dd', 2 )  -> 'aa.bb'
// extract_Elements( 'aa.bb.cc.dd', -2 )  -> 'cc.dd'
//
function extract_Elements( dn, elementNr )
{
	var saElem  = dn.split( '.' );
	var result  = '';
	var iLen    = Math.min ( saElem.length, Math.abs(elementNr) );
	var iStart  = 0;
	if ( elementNr<0 ) iStart = saElem.length - iLen;

	for ( var i=0; i<iLen; i++ )
	{ 
		if ( result.length>0 ) result += '.';
		result += saElem[i+iStart];
	}
	return (result);
}





// helper for mvedFunctionChangeLink()
function mvedFunctionGenericOS( control, typeFilter, nameFilter, initialContext, advancedSelection, advSelCriteria, searchOnStartup, multiSelect, searchSubContainers ) {
	return ( doOS( '', control, 'mvselReturnFromOS', advancedSelection, advSelCriteria, '', initialContext, 'mvIsOSAllowed', '', multiSelect, nameFilter, '', searchSubContainers, searchOnStartup, '', typeFilter, '' )); 
}

// helper for mvedFunctionChangeLink()
function mvedFunctionFindLink( controlId ) {
	var elem = null;
	var elLocation = getFieldByNameOrId( controlId );
	if ( elLocation == null ) return ( null );
	for ( var i=0; i < elLocation.all.length; i++ ) {
		elem = elLocation.all[i]; 
		var jsFct  = elem.onclick;
		if ( jsFct != null ) break;
	}
	return ( elem );
}

// function used to override mved OS on the fly (useful to set initial context or create dynamic OS
// example call 
//
//    <%-- declare new OS function --%>
//    function mvedFunctionMod( ) {
//      return ( mvedFunctionGenericOS( 'DemoXXX', 'Group', 'g*', 'ACME', false, false, true, true ));
//    }
//
//     <font id='DemoXXX'>  < % -- must be used to locate the OS -- % >
//          < %-- iman:mved name="DemoXXX" objectTypeName="User" size="3" mode="mvsel" history="true" enforceUnique="true" / --% >
//      </font>
//
//    < % -- override the OS -- % >
//    <a href="#" onclick='mvedFunctionChangeLink( "DemoXXX", mvedFunctionMod );'> mvedFunctionChangeLink </a>
//
function mvedFunctionChangeLink( controlId, newOnclick ) {
	var mvedSelector = mvedFunctionFindLink( controlId );
	if ( mvedSelector == null ) return;
	//alert ( mvedSelector.onclick );
	mvedSelector.onclick = newOnclick;
//alert ( mvedSelector.onclick );            
}


// example:   ncsConcat( "|", "abc",  "",  "ghi" ) -> "abc|ghi"
function ncsConcat( separator ) 
{
	var result="" // initialize list
	for ( var i=1; i<arguments.length; i++) 
	{ // iterate through arguments
		if ( arguments[i] != '' )
			result += (( result !== '' ) ? separator : '' ) + arguments[i];
	}
	return result
} 


// <%-- regex input validation --%>
// e.g.  alert( isValidExpression( '20091231', /[12][90]\\d{2}[01]\\d{1}[0123]\\d{1}/ ))
function isValidExpression( sValue, regEx )
{
	var sMatch = sValue.match( regEx );
	return ( sMatch == sValue );
}


function isValid( sValue, regEx, sDisplay, sHint )
{
	var result = '';
	if ( !isValidExpression( sValue, regEx ) ) result += '\n\t* ' + sDisplay + ': ' + sHint;
	return ( result );
}


function isMissing( sValue, sDisplay )
{
	var result = '';
	if ( sValue.length < 1 ) result += '\n\t* ' + sDisplay + ': Missing value';
	return ( result );
}

function isTooLong( sValue, sDisplay, iMax )
{
	var result = '';
	if ( sValue.length >iMax ) result += '\n\t* ' + sDisplay + ': Too Long';
	return ( result );
}

/** simple shortcut: check value
 * 
 * @param {type} myVar
 * @returns {Boolean}
 */
function hasNoValue( myVar )
{
  var result = false;
//  if ( myVar == undefined   )   return( true );
  switch ( typeof( myVar ) )
  {
     case VARTYPE_UNDEFINED:
          return( true );
          break;
     case VARTYPE_OBJECT:
//          if ( myVar == undefined   )   return( true );
          if ( myVar === null        )   return( true );
          if ( myVar.length === 0    )   return( true );
          if ( myVar.length === 1    )   return( hasNoValue( myVar[0] ));  // array with one empty element
//          return ( false );
          break;
     case VARTYPE_STRING:
          if ( myVar === ""   )          return( true );
          // if ( myVar == "false"   )     return( true );                    // 2009-11-23: checkbox may return "false" if unchecked
//          return ( false );
          break;
//     default:
//          return ( false );
  }
  return( result );
}

/** simple shortcut: check value
 * 
 * @param {type} myVar
 * @returns {@exp;@call;hasNoValue} */
function hasValue( myVar )
{
  return ( !hasNoValue( myVar ) );
}


/** padding with leading chars
 * 
 * @param {type} s
 * @param {type} len
 * @param {type} paddingChar
 * @returns {stringPaddedWithPrefix.result}
 */
function stringPaddedWithPrefix( s, len, paddingChar )
{
	if ( hasNoValue( s )) s = "";
	if ( hasNoValue( paddingChar )) paddingChar = " ";
	var result = String( s );
	while ( result.length < len ) {
		result = paddingChar + result;
	}
	return ( result );
}

// e.g. < a href="javascript:ncsSetPassword( <%--= c.urlEncode(c.var("eDir$target")) --%> );" >< %= c.string("SetPassword") % >< /a >
function ncsSetPassword( sObjectName )
{
	var sUrl = "frameservice?NPService=fw.LaunchService&NPAction=Launch&launch=fw.SetPassword&launcher=fw.LaunchService&lifecycle=new&targetNames=" + sObjectName;
	window.open( sUrl, "", "toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes,width=550,height=400" );
}


//
// <img id="pic2" border="0" src="cr1.jpg" width="200" style="filter:blendTrans(Duration=2, Transition=8)">
//
// <script>
//   window.setInterval('choosePic( "pic2", new Array(  "cr1.jpg", "cr2.jpg", "cr3.jpg", "cr4.jpg" ))', 3000);
// </script>
//
//  change the picture to a random one from the list  (IE, only)
//
function choosePic( pic, pics )
{
	var r  	= Math.floor( pics.length * Math.random() );
	var nextPic	= pics[r];
	var picFld = getFieldByNameOrId( pic );
	picFld.filters.blendTrans.Apply();
	picFld.src = nextPic;
	picFld.filters.blendTrans.Play();
}



//       Check = confirm( "Are you sure");
//       if (Check == false) ...




/** set a browser cookie
 *
 *		credits to: Professional JavaScript for Web Developers by Nicholas C. Zakas
 *
 *
 *		sample call: cookieSet( document, "test", 123 )
 *						 cookieSet( document, "test", 123, dateAdd( null, 0, 3, 0 ))
 */
function cookieSet( document, sName, sValue, oExpires, sPath, sDomain, bSecure )
{
	sName = encodeURIComponent( sName );
	var sCookie = sName + "=" + encodeURIComponent( sValue );
	if (oExpires) 	sCookie += "; expires="		+ oExpires.toGMTString();
	if (sPath)		sCookie += "; path="			+ sPath;
	if (sDomain)	sCookie += "; domain="		+ sDomain;
	if (bSecure) 	sCookie += "; secure";
	document.cookie = sCookie;
	
	
}


/** get a browser cookie
 *
 */
function cookieGet( sName )
{
	var result = undefined;
	sName = encodeURIComponent( sName );
	var sRE = "(?:; )?" + sName + "=([^;]*);?";
	var oRE = new RegExp(sRE);
	if ( oRE.test( document.cookie ))
	{
		if ( RegExp["$1"] != "undefined" )
		{
			result = decodeURIComponent( RegExp["$1"] );
		}
	}
	return( result );
}

/** remove a browser cookie
 *
 */
function cookieDelete( sName, sPath, sDomain )
{
	sName = encodeURIComponent( sName );
	cookieSet( sName, "", new Date(0), sPath, sDomain );
}


