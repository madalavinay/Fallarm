$(document).ready(function() {
	$("button").click(function() {
		if (validate()) {
			$.ajax({
				type : "POST",
				data : {
					user : document.getElementById("user").value,
					ax : document.getElementById("ax").value,
					ay : document.getElementById("ay").value,
					az : document.getElementById("az").value,
					gx : document.getElementById("gx").value,
					gy : document.getElementById("gy").value,
					gz : document.getElementById("gz").value,
					severity : document.getElementById("severity").value
				},
				url : "action",
				success : function(data) {
					var $response=$(data);
					alert($response.filter('#success').text());
				}
			});
		}
	});
});

function indexPage() {
	document.getElementById("indexForm").submit();
}

function validate() {
	if (isNaN(document.getElementById("ax").value)) {
		alert("Ax must be number");
		return false;
	} else if (isNaN(document.getElementById("ay").value)) {
		alert("Ay must be number");
		return false;
	} else if (isNaN(document.getElementById("az").value)) {
		alert("Az must be number");
		return false;
	} else if (isNaN(document.getElementById("gx").value)) {
		alert("Gx must be number");
		return false;
	} else if (isNaN(document.getElementById("gy").value)) {
		alert("Gy must be number");
		return false;
	} else if (isNaN(document.getElementById("gz").value)) {
		alert("Gz must be number");
		return false;
	} else if (isNaN(document.getElementById("severity").value)) {
		alert("Severity must be number");
		return false;
	} else {
		return true;
	}
}