$(document).ready(function() {
	$(".comments").click(function() {
		$.ajax({
			type : "POST",
			data : {
				addComments : this.id,
				comments : document.getElementById("c" + this.id).value
			},
			url : "searching.jsp",
			success : function(res) {
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
		data : {
			user : document.getElementById("popUser").value
		},
		success : function(data) {
			var $response = $(data);
			var popVal = $response.filter('#pop').text();
			if (popVal != '') {
				alert("Attention! " + popVal + " need your attention");
			}
		},
		complete : function(data) {
			setTimeout(doAjax, interval);
		}
	});
}
setTimeout(doAjax, interval);

function doRefresh() {
	document.getElementById('refresh').value='R';
	if (document.getElementById('refreshCheck').checked) {
		$.ajax({
			data : document.getElementById('refreshForm').submit(),
			complete : function(data) {
				setTimeout(doRefresh, interval);
			}
		});
	}
}
setTimeout(doRefresh, interval);

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

function next() {
	document.getElementById('nextPage').disabled = true;
	submitForm();
}

function submitForm() {
	document.getElementById('pagination').submit();
}

function prev() {
	document.getElementById('prevPage').disabled = true;
	document.getElementById('prepost').value = "prev";
	submitForm();
}
