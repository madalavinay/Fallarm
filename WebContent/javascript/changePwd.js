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


function check_empty() {
	if (document.getElementById('newPwd').value != document
			.getElementById('newPwd1').value) {
		alert("Passwords must match");
		return false;
	} else {
		return true;
	}
}
// Function To Display Popup
function div_show() {
	document.getElementById('abc').style.display = "block";
}
// Function to Hide Popup
function div_hide() {
	document.getElementById('abc').style.display = "none";
}