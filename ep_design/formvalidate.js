/* 	Javascript to validate input on form 
	See ici : http://www.webcheatsheet.com/javascript/form_validation.php
*/


// yellow: required, white: optional, green: valid, red: invalid please correct

/* validate(field) should be fired upon onChange & submit, 
	if blank return to original state (required or optional)
	else if ok make field green and return true
	else make field red and return false
*/

function validate(f) {
	
	var valid;
	var error = "";
	
	if (f.value == "") {
		if (!/^optional$/.test(f.class)) error = "required";
	}
	
	// text and numbers
	else if (/^(?:username|password|streetaddress)$/.test(f.name)) {
		var illegalChars = /\W/; // allow letters, numbers, and underscores
		
		if ((f.value.length < 4)) {
			error = "need 4 or more characters";
		} else if (illegalChars.test(f.value)) {
			error = "contains illegal characters";
		} 
	}
	// email
	else if (/^(?:email)$/.test(f.name)) {

		var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
		
		if (!emailregexp.test(f.value)) {   
			
			          
		    error = "not a valid email address";
		    
		} else if (f.value.match(illegalChars)) {
		    error = "contains illegal characters";
		}
    }
    
    	// zip
	else if (/^(?:zip)$/.test(f.name)) {
		if (!/^\d{5}$/.test(f.value)) {
			error = "must be a 5 digit number";
		} 
	}
	
	// date in the mm/dd/yy or mm/yy
	else if (/^(?:leaseexpiry)$/.test(f.name)) {
		if ( !/^(\d{1,2})[./-](\d{1,2})[./-](\d{2})$/.test(f.value) &&
			 !/^(\d{1,2})[./-](\d{2})$/.test(f.value) ) 
		{
			error = "must be mm/dd/yy or mm/yy";
		} 
	}
	
	// dropdowns
	else if (/^(?:numberofbedrooms|numberofbathrooms|elevator|kitchenquality|bathroomquality|heatandac|laundry|cellphone)$/.test(f.name)) {
		if (f.value == "...") {
			errormsg = "make a selection";
		}
	}
	// just numbers
	else if (/^(?:rent)$/.test(f.name)) {
		if (!/^\d+$/.test(f.value)) {
			error = "must be a number";
		} 
	}
	
	// phone number
	else if (/^(?:landlordphone)$/.test(f.name)) {
	
		var stripped = f.value.replace(/[\(\)\.\-\ ]/g, '');    
		if (!/\d+/.test(stripped)) {
        	error = "must be a valid phone number";
    	} else if (!(stripped.length == 10)) {
        	error = "must be a ten digit number";
		}
		else {
			f.value = '('+stripped.substring(0,3)+')'+stripped.substring(3,6)+'-'+stripped.substring(6,10);
		}
	}
	
	valid = (error == "");
	
	if (!valid) {
		if (/^optional$/.test(f.class)) 
			{ f.setStyle('background','#FFF'); } 
		else
			{ f.setStyle('background','#FFEEEE'); }
	} else {
		f.setStyle('background','#CCFFCC');
	}
	
	if (error == "") {
		$(f.name+"_error").setHTML('<img class="twelveem" src=\'images/icons/12-em-check.png\'/>');
		$(f.name+"_error").className = 'ok';
	} else {
		$(f.name+"_error").setHTML('<img class="twelveem" src=\'images/icons/12-em-cross.png\'/>'+error);
		$(f.name+"_error").className = 'error';
	}
	
	validategroup(f);
	
	return valid;

}


function validategroup(f) {
	
	var group_required = ['username','password','email','streetaddress','zip','leaseexpiry','numberofbedrooms','numberofbathrooms','rent'];
	
	if (group_required.indexOf(f.name)>0) {
		var groupvalid = true;
		for (var i=0;i<group_required.length;i++) 
			groupvalid = (groupvalid && ($(group_required[i]+"_error").className == "ok")); 
		
		
		if (groupvalid) {
			$('required_header').setStyle('background','#CCFFCC');
			$('required_togglercheck').className = 'togglercheckok';
			
			/* make the submit button ok */
			$('submit_button').className = 'positive';
			$('submit_button').setHTML('<img class=\'twelveem\' src=\'images/icons/12-em-check.png\'/>submit');
			$("submit_error").setHTML('');
		
			
		} else {
			$('required_header').setStyle('background','');	
			$('required_togglercheck').className = 'togglercheck';
			
			$('submit_button').className = 'negative';
			$('submit_button').setHTML('<img class=\'twelveem\' src=\'images/icons/12-em-cross.png\'/>submit');
			$("submit_error").setHTML('please complete the required info');
		}
		
		
		
		
	}
	
	
}



var emailregexp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[(2([0-4]\d|5[0-5])|1?\d{1,2})(\.(2([0-4]\d|5[0-5])|1?\d{1,2})){3} \])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/