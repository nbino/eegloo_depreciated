/****************************************************************
FILE: RegExpValidate.js

DESCRIPTION: This file contains a library of validation functions
  using javascript regular expressions.  Library also contains 
  functions that reformat fields for display or for storage.


  VALIDATION FUNCTIONS:

  validateEmail - checks format of email address
    validateUSPhone - checks format of US phone number
    validateNumeric - checks for valid numeric value
  validateInteger - checks for valid integer value
    validateNotEmpty - checks for blank form field
  validateUSZip - checks for valid US zip code
  validateUSDate - checks for valid date in US format
  validateValue - checks a string against supplied pattern

  FORMAT FUNCTIONS:

  rightTrim - removes trailing spaces from a string
  leftTrim - removes leading spaces from a string
  trimAll - removes leading and trailing spaces from a string
  removeCurrency - removes currency formatting characters (), $
  addCurrency - inserts currency formatting characters
  removeCommas - removes comma separators from a number
  addCommas - adds comma separators to a number
  removeCharacters - removes characters from a string that match 
  passed pattern


AUTHOR: Karen Gayda

DATE: 03/24/2000
*******************************************************************/

function validateEmail( strValue) {
/************************************************
DESCRIPTION: Validates that a string contains a
  valid email pattern.

 PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

REMARKS: Accounts for email with country appended
  does not validate that email contains valid URL
  type (.com, .gov, etc.) or valid country suffix.
*************************************************/
var objRegExp  =
 /(^[a-z]([a-z_\.]*)@([a-z_\.]*)([.][a-z]{3})$)|(^[a-z]([a-z_\.]*)@
  ([a-z_\.]*)(\.[a-z]{3})(\.[a-z]{2})*$)/i;

  //check for valid email
  return objRegExp.test(strValue);
}

function validateUSPhone( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains valid
  US phone pattern.
  Ex. (999) 999-9999 or (999)999-9999

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
*************************************************/
  var objRegExp  = /^\([1-9]\d{2}\)\s?\d{3}\-\d{4}$/;

  //check for valid us phone with or without space between
  //area code
  return objRegExp.test(strValue);
}

function  validateNumeric( strValue ) {
/*****************************************************************
DESCRIPTION: Validates that a string contains only valid numbers.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
******************************************************************/
  var objRegExp  =  /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;

  //check for numeric characters
  return objRegExp.test(strValue);
}

function validateInteger( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid integer number.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
**************************************************/
  var objRegExp  = /(^-?\d\d*$)/;

  //check for integer characters
  return objRegExp.test(strValue);
}

function validateNotEmpty( strValue ) {
/************************************************
DESCRIPTION: Validates that a string is not all
  blank (whitespace) characters.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
*************************************************/
   var strTemp = strValue;
   strTemp = trimAll(strTemp);
   if(strTemp.length > 0){
     return true;
   }
   return false;
}

function validateUSZip( strValue ) {
/************************************************
DESCRIPTION: Validates that a string a United
  States zip code in 5 digit format or zip+4
  format. 99999 or 99999-9999

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

*************************************************/
var objRegExp  = /(^\d{5}$)|(^\d{5}-\d{4}$)/;

  //check for valid US Zipcode
  return objRegExp.test(strValue);
}

function validateUSDate( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid dates with 2 digit month, 2 digit day,
    4 digit year. Date separator can be ., -, or /.
    Uses combination of regular expressions and
    string parsing to validate date.
    Ex. mm/dd/yyyy or mm-dd-yyyy or mm.dd.yyyy

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

REMARKS:
   Avoids some of the limitations of the Date.parse()
   method such as the date separator character.
*************************************************/
  var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
 
  //check to see if in correct format
  if(!objRegExp.test(strValue))
    return false; //doesn't match pattern, bad date
  else{
    var strSeparator = strValue.substring(2,3) 
    var arrayDate = strValue.split(strSeparator); 
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, 
                        '04' : 30,'05' : 31,
                        '06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,
                        '10' : 31,'11' : 30,'12' : 31}
    var intDay = parseInt(arrayDate[1],10); 

    //check if month value and day value agree
    if(arrayLookup[arrayDate[0]] != null) {
      if(intDay <= arrayLookup[arrayDate[0]] && intDay != 0)
        return true; //found in lookup table, good date
    }
    
    //check for February (bugfix 20050322)
    //bugfix  for parseInt kevin
    //bugfix  biss year  O.Jp Voutat
    var intMonth = parseInt(arrayDate[0],10);
    if (intMonth == 2) { 
       var intYear = parseInt(arrayDate[2]);
       if (intDay > 0 && intDay < 29) {
           return true;
       }
       else if (intDay == 29) {
         if ((intYear % 4 == 0) && (intYear % 100 != 0) || 
             (intYear % 400 == 0)) {
              // year div by 4 and ((not div by 100) or div by 400) ->ok
             return true;
         }   
       }
    }
  }  
  return false; //any other values, bad date
}

function validateValue( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Validates that a string a matches
  a valid regular expression value.

PARAMETERS:
   strValue - String to be tested for validity
   strMatchPattern - String containing a valid
      regular expression match pattern.

RETURNS:
   True if valid, otherwise false.
*************************************************/
var objRegExp = new RegExp( strMatchPattern);

 //check if string matches pattern
 return objRegExp.test(strValue);
}


function rightTrim( strValue ) {
/************************************************
DESCRIPTION: Trims trailing whitespace chars.

PARAMETERS:
   strValue - String to be trimmed.

RETURNS:
   Source string with right whitespaces removed.
*************************************************/
var objRegExp = /^([\w\W]*)(\b\s*)$/;

      if(objRegExp.test(strValue)) {
       //remove trailing a whitespace characters
       strValue = strValue.replace(objRegExp, '$1');
    }
  return strValue;
}

function leftTrim( strValue ) {
/************************************************
DESCRIPTION: Trims leading whitespace chars.

PARAMETERS:
   strValue - String to be trimmed

RETURNS:
   Source string with left whitespaces removed.
*************************************************/
var objRegExp = /^(\s*)(\b[\w\W]*)$/;

      if(objRegExp.test(strValue)) {
       //remove leading a whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function trimAll( strValue ) {
/************************************************
DESCRIPTION: Removes leading and trailing spaces.

PARAMETERS: Source string from which spaces will
  be removed;

RETURNS: Source string with whitespaces removed.
*************************************************/
 var objRegExp = /^(\s*)$/;

    //check for all spaces
    if(objRegExp.test(strValue)) {
       strValue = strValue.replace(objRegExp, '');
       if( strValue.length == 0)
          return strValue;
    }

   //check for leading & trailing spaces
   objRegExp = /^(\s*)([\W\w]*)(\b\s*$)/;
   if(objRegExp.test(strValue)) {
       //remove leading and trailing whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function removeCurrency( strValue ) {
/************************************************
DESCRIPTION: Removes currency formatting from
  source string.

PARAMETERS:
  strValue - Source string from which currency formatting
     will be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /\(/;
  var strMinus = '';

  //check if negative
  if(objRegExp.test(strValue)){
    strMinus = '-';
  }

  objRegExp = /\)|\(|[,]/g;
  strValue = strValue.replace(objRegExp,'');
  if(strValue.indexOf('$') >= 0){
    strValue = strValue.substring(1, strValue.length);
  }
  return strMinus + strValue;
}

function addCurrency( strValue ) {
/************************************************
DESCRIPTION: Formats a number as currency.

PARAMETERS:
  strValue - Source string to be formatted

REMARKS: Assumes number passed is a valid
  numeric value in the rounded to 2 decimal
  places.  If not, returns original value.
*************************************************/
  var objRegExp = /-?[0-9]+\.[0-9]{2}$/;

    if( objRegExp.test(strValue)) {
      objRegExp.compile('^-');
      strValue = addCommas(strValue);
      if (objRegExp.test(strValue)){
        strValue = '(' + strValue.replace(objRegExp,'') + ')';
      }
      return '$' + strValue;
    }
    else
      return strValue;
}

function removeCommas( strValue ) {
/************************************************
DESCRIPTION: Removes commas from source string.

PARAMETERS:
  strValue - Source string from which commas will
    be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /,/g; //search for commas globally

  //replace all matches with empty strings
  return strValue.replace(objRegExp,'');
}

function addCommas( strValue ) {
/************************************************
DESCRIPTION: Inserts commas into numeric string.

PARAMETERS:
  strValue - source string containing commas.

RETURNS: String modified with comma grouping if
  source was all numeric, otherwise source is
  returned.

REMARKS: Used with integers or numbers with
  2 or less decimal places.
*************************************************/
  var objRegExp  = new RegExp('(-?[0-9]+)([0-9]{3})');

    //check for match to search criteria
    while(objRegExp.test(strValue)) {
       //replace original string with first group match,
       //a comma, then second group match
       strValue = strValue.replace(objRegExp, '$1,$2');
    }
  return strValue;
}

function removeCharacters( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Removes characters from a source string
  based upon matches of the supplied pattern.

PARAMETERS:
  strValue - source string containing number.

RETURNS: String modified with characters
  matching search pattern removed

USAGE:  strNoSpaces = removeCharacters( ' sfdf  dfd',
                                '\s*')
*************************************************/
 var objRegExp =  new RegExp( strMatchPattern, 'gi' );

 //replace passed pattern matches with blanks
  return strValue.replace(objRegExp,'');
}