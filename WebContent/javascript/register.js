var interval = 5000;
function doAjax() {
    $.ajax({
            type : "POST",
             url : "popup",
            data : {user : document.getElementById("popUser").value},
            success: function (data) {
            	var $response=$(data);
                var popVal = $response.filter('#pop').text();
                if(popVal!=''){
                	alert("Attention! "+popVal+" need your attention");
                }
            },
            complete: function (data) {
                   setTimeout(doAjax, interval);
            }
    });
}
setTimeout(doAjax, interval);

window.onload=function(){
	var text1=document.getElementById('start');
	var start = parseInt((text1.innerText || text1.textContent));
	var text2=document.getElementById('end');
	var end = parseInt((text2.innerText || text2.textContent));
	var text3=document.getElementById('count');
	var count = parseInt((text3.innerText || text3.textContent));
	if(end==count){
		document.getElementById("nextPage").disabled=true;
	}
	else{
		document.getElementById("nextPage").disabled=false;
	}
	if(start<=1){
		document.getElementById("prevPage").disabled=true;
	}
	else{
		document.getElementById("prevPage").disabled=false;
	}
	
	if(document.getElementById("role").value=='patient')
		{
		document.getElementById("newIcon").style.visibility = 'hidden';
		document.getElementById("deleteIcon").style.visibility = 'hidden';
		document.getElementById("refreshIcon").style.visibility = 'hidden';
		}
	
	var ele = document.getElementsByName("regData");
	for (var i = 0; i < ele.length; i++)
		ele[i].checked = false;
	
}
function next(){
	document.getElementById('nextPage').disabled=true;
	submitForm();
}

function submitForm(){
	document.getElementById('pagination').submit();
}

function prev(){
	document.getElementById('prevPage').disabled=true;
	document.getElementById('prepost').value="prev";
	submitForm();
}

function validate() {
	if (document.getElementById("userid").value.length != 8) {
		alert("User ID must be an 8-digit number");
		return false;
	} else if (document.getElementById("phone").value.length != 10) {
		alert("Phone number must be an 10-digit number");
		return false;
	} else if (document.getElementById("nurse").value.length >0 && document.getElementById("nurse").value.length != 8) {
		alert("Nurse ID must be an 8-digit number");
		return false;
	} else {
		document.getElementById('cancelPerson').style.visibility = 'hidden';
		document.getElementById('savePerson').style.visibility = 'hidden';
		document.getElementById('updatePerson').style.visibility = 'hidden';
		return true;
	}
}
// Function To Display
function div_show() {
	document.getElementById('newuser').reset();
	document.getElementById('updatePerson').style.visibility = 'hidden';
	document.getElementById('savePerson').style.visibility = 'visible';
	document.getElementById('cancelPerson').style.visibility = 'visible';
	document.getElementById('abc').style.display = "block";
}
// Function to Hide
function div_hide() {
	document.getElementById('newuser').reset();
	document.getElementById('abc').style.display = "none";
	var ele = document.getElementsByName("regData");
	for (var i = 0; i < ele.length; i++)
		ele[i].checked = false;

}

//Function To Edit registration details
function div_edit() {
	document.getElementById('updatePerson').style.visibility = 'visible';
	document.getElementById('cancelPerson').style.visibility = 'visible';
	document.getElementById('savePerson').style.visibility = 'hidden';
	var radios = document.getElementsByName("regData");
	var formValid = false;

	var i = 0;
	while (!formValid && i < radios.length) {
		if (radios[i].checked) {
			formValid = true;
			document.getElementById("userid").value = document
					.getElementById("id" + i).innerText;
			document.getElementById("userid").readOnly = true;
			document.getElementById("first").value = document
					.getElementById("fn" + i).innerText;
			document.getElementById("last").value = document
					.getElementById("ln" + i).innerText;
			document.getElementById("mail").value = document
					.getElementById("em" + i).innerText;
			document.getElementById("phone").value = document
					.getElementById("ph" + i).innerText;
			if (document.getElementById("g" + i).innerText == 'F') {
				document.getElementById("female").checked = true;
			} else {
				document.getElementById("male").checked = true;
			}

			document.getElementById("nurse").value = document
					.getElementById("nu" + i).innerText;
			if(document.getElementById("role").value=='patient'){
				document.getElementById("nurse").disabled=true;
			}
			document.getElementById('abc').style.display = "block";

		}
		i++;
	}
	if (!formValid)
		alert("Please select a record to edit.");
}

//delete data
function div_delete() {
	var radios = document.getElementsByName("regData");
	var formValid = false;

	var i = 0;
	while (!formValid && i < radios.length) {
		if (radios[i].checked) {
			formValid = true;
			var record=document.getElementById("id" + i).innerText;
			if (confirm('Are you sure you want to delete?'+ record)) {
				document.getElementById("deleteId").value = record;
				document.getElementById("deleteUser").submit();
			}
			else{
				var ele = document.getElementsByName("regData");
				for (var i = 0; i < ele.length; i++)
					ele[i].checked = false;
			}
		}
		
		i++;
	}
	if (!formValid) {
		alert("Please select a record to delete.");
		return false;
	}
}

//refresh data
function div_refresh() {
	document.getElementById('refreshForm').submit();
}