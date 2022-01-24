$(document).ready(function() {
	//-------------------------新增頁面中owner的ajax控制-------------------------
	//ajax新增owner
	$("#ownerSave").click(function(event) {
		event.preventDefault();
		var formData = new FormData();
		var file = $('#file')[0].files[0];
		var data = $('#form2').serialize();
		formData.append("file", file);
		if($('#name').val()==''||$('#contactName').val()==''||$('#payeeBranchName').val()==''||$('#account').val()==''||$('#payeeName').val()==''){
			if($('#name').val()==''){
				$('#name').css("border","1px solid red");
				$('#ownerNameError').css("display","inline");
			}
			if($('#contactName').val()==''){
				$('#contactName').css("border","1px solid red");
				$('#ownerContactNameError').css("display","inline");
			}
			if($('#payeeBranchName').val()==''){
				$('#payeeBranchName').css("border","1px solid red");
				$('#ownerPayeeBranchNameError').css("display","inline");
			}
			if($('#account').val()==''){
				$('#account').css("border","1px solid red");
				$('#ownerAccountError').css("display","inline");
			}
			if($('#payeeName').val()==''){
				$('#payeeName').css("border","1px solid red");
				$('#ownerPayeeNameError').css("display","inline");
			}
			return false;
		}else{
			$.ajax({
				url: 'http://localhost:8081/uploadOwnerImg',
				type: 'POST',
				data: formData,
				enctype: 'multipart/form-data',
				contentType: false,
				cache: false,
				processData: false,
				sync: true,
				success: function() {
					$.ajax({
						type: "POST",
						url: "http://localhost:8081/saveOwner",
						data: data,
						sync: true,
						success: function(data) {
							alert("成功新增一名管理員");
							//showAreaButton();
							assignDataToOwnerSelect();
							$('#ownerDetail').empty();
							$('#ownerDetail').show();
							$('#facilitiesOwnerArea').toggleClass('open');
							$('#showOwnerArea').toggleClass('close');
	
							$('#name').val('');
							$('#description').val('');
							$('#contactName').val('');
							$('#contactPhone').val('');
							$('#contactMobilePhone').val('');
							$('#invoiceHeading').val('');
							$('#taxId').val('');
							$('#payeeBranchName').val('');
							$('#account').val('');
							$('#payeeName').val('');
						},
						error: function(err) {
							console.log(err);
							alert(err);
						}
					});
				},
				error: function() {
					alert("請至少上傳一張管理員照片");
				}
			});
		}
	});

	//ajax動態刷新select表單方法
	function assignDataToOwnerSelect() {
		$('#ownerSelect').empty();

		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listOwners",
			success: function(data) {
				var owners = JSON.parse(JSON.stringify(data));
				$('#ownerSelect').append('<option selected disabled>請選擇一名管理者</option>');
				for (var i in owners) {
					$('#ownerSelect').append('<option value="' + owners[i].id + '">' + owners[i].name + '</option>');
				}
			},
			error: function(data) {
				console.log(data);
			}
		});

	};
	
		//-------------------------更新頁面中圖片的ajax控制-------------------------
	//ajax動態刷新圖片div區塊方法
	function assignDataToImages() {
		$('#onLoadImageNew').empty();
		$('#onLoadImageNew').html("<p class='preImageTitle'>已上傳圖片</p>");
		$.ajax({
			type: "GET",
			url: "http://localhost:8081/listSpaceImages",
			success: function(data) {
				images = JSON.parse(JSON.stringify(data));
				for (var i in images) {
					$('#onLoadImageNew').append("<div class='spaceImageArea'><img class='spaceImage' src='uploaded/"+images[i].name+"'/><span><div class='deleteImgButton' onclick='deleteSpaceImages("+images[i].id+")'><i class='fas fa-minus-circle'></i></div></span></div>")
				}
			},
			error: function(data) {
				console.log(data);
			}
		});
	};

	let select = document.querySelector("#ownerSelect");
	select.addEventListener("change", selectChange);

	function selectChange() {
		const ownerId = select.options[select.selectedIndex].value;
		assignDataToOwnerTable(ownerId);
	}

	//ajax動態刷新管理員資訊表格方法
	function assignDataToOwnerTable(ownerId) {
		$("#ownerDetail").empty();
		$.ajax({
			type: "GET",
			contentType: "application/json",
			url: "http://localhost:8081/listOwners/" + ownerId,
			success: function(data) {
				var owner = JSON.parse(JSON.stringify(data));

				$("#ownerDetail").
					append("<p>管理者內容</p>" +
						"<div class='ownerImage' style='background-image: url(uploaded/" + owner.image + ");'>" + "</div>" +
						"<table>" +
						"<tr> \<td class='tableLeft'>" + "聯絡人" + "</td> \
                        <td class='tableRight'>" + owner.contactName + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "手機" + "</td> \
                        <td class='tableRight'>" + owner.contactMobilePhone + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "電話" + "</td> \
                        <td class='tableRight'>" + owner.contactPhone + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "發票統編" + "</td> \
                        <td class='tableRight'>" + owner.taxId + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "發票抬頭" + "</td> \
                        <td class='tableRight'>" + owner.invoiceHeading + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "收款銀行" + "</td> \
                        <td class='tableRight'>" + owner.payeeBankName + "</td> \
                        </tr>"+
						"<tr> \<td class='tableLeft'>" + "收款帳戶" + "</td> \
                        <td class='tableRight'>" + owner.account + "</td> \
                        </tr>"+
						"</table>" +
						"<button onclick='InitUpdateOwner();' id='updateOwner' type='button' class='updateOwner'>"
						+ "<i class='far fa-edit'></i>  編輯管理者</button>" +
						"<button onclick='deleteOwner();confirmSubmit()' id='deleteOwner' type='button' class='deleteOwner'>"
						+ "<i class='far fa-trash-alt'></i>  刪除</button>",
					);
			},
			error: function(data) {
				console.log(data);
			}
		});
	}
	
	

});

	//-------------------------載入新增或更新頁面時立即啟動的js控制-------------------------
//管理員照片的預覽圖
window.addEventListener("load", function() {
	//啟用頁面時自動載入owner select表單
	assignDataToOwnerSelect();
	
	var the_file_element = document.getElementById("file");

	the_file_element.addEventListener("change", function(e) {
		// 寫在這
		var previewImage = document.getElementById("previewImage");
		previewImage.innerHTML = ""; // 清空
		// 跑每個使用者選的檔案，留意 i 的部份
		for (let i = 0; i < this.files.length; i++) {

			let reader = new FileReader(); // 用來讀取檔案

			reader.readAsDataURL(this.files[i]); // 讀取檔案

			reader.addEventListener("load", function() {


				let li_html = `
          <img src="${reader.result}" id="previewImagePhoto">
        `;

				previewImage.insertAdjacentHTML("beforeend", li_html); // 加進節點
			});

		}

	});

});