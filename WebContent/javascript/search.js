$(document).ready(function() {
	$("#startdatepicker").datepicker({
		changeMonth : true,//this option for allowing user to select month
		changeYear : true, //this option for allowing user to select from year range
		maxDate : 0
	});
});
$(document).ready(function() {
	$("#enddatepicker").datepicker({
		changeMonth : true,//this option for allowing user to select month
		changeYear : true, //this option for allowing user to select from year range
		maxDate : 0
	});
});
$(document).ready(function(){
    $(".comments").click(function(){
    	$.ajax({
            type: "POST",
            data: { addComments: this.id,
            comments : document.getElementById("c"+this.id).value	
            },
            url: "searching.jsp",
            success: function(res) {
              alert("comment saved");
            }
          });
    });
});

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

window.onload = function() {
	var text1 = document.getElementById('start');
	var start = parseInt((text1.innerText || text1.textContent));
	var text2 = document.getElementById('end');
	var end = parseInt((text2.innerText || text2.textContent));
	var text3 = document.getElementById('count');
	var count = parseInt((text3.innerText || text3.textContent));
	if (end == count) {
		document.getElementById("nextPage").disabled = true;
	} else {
		document.getElementById("nextPage").disabled = false;
	}
	if (start <= 1) {
		document.getElementById("prevPage").disabled = true;
	} else {
		document.getElementById("prevPage").disabled = false;
	}
}

function isValidDate() {
	var startDate = document.getElementById("startdatepicker").value;
	var endDate = document.getElementById("enddatepicker").value;
	var sdate = new Date(startDate), edate = new Date(endDate);
	if (sdate.getTime() > edate.getTime()) {
		alert("Start date must be before End date");
		return false;
	}
	else{
		document.getElementById("startPage").value="0";
		return true;	
	}
}

function next() {
	document.getElementById('nextPage').disabled = true;
	document.getElementById('startPage').value = parseInt(document.getElementById('startPage').value) + 10;
	submitForm();
}

function submitForm() {
	document.getElementById('searchbox').submit();
}

function prev() {
	document.getElementById('prevPage').disabled = true;
	document.getElementById('startPage').value = parseInt(document.getElementById('startPage').value) - 10;
	submitForm();
}

function disable() {
	document.getElementById('prevPage').disabled = true;
	document.getElementById('nextPage').disabled = true;
}