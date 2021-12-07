//ownerArea裏面的取消按鈕 ＝ 按了showOwnerArea按鈕
function showAreaButton() {
	document.getElementById("showOwnerArea").click();
}

//下一步及上一步轉換頁籤用
function nextStep() {
    document.getElementById("tab2").click();
}

function nextStep2() {
    document.getElementById("tab3").click();
}

function preStep2() {
    document.getElementById("tab1").click();
}

function nextStep3() {
    document.getElementById("tab4").click();
}

function preStep3() {
    document.getElementById("tab2").click();
}

function nextStep4() {
    document.getElementById("tab5").click();
}

function preStep4() {
    document.getElementById("tab3").click();
}

function nextStep5() {
    document.getElementById("tab6").click();
}

function preStep5() {
    document.getElementById("tab4").click();
}

function nextStep6() {
    document.getElementById("tab7").click();
}

function preStep6() {
    document.getElementById("tab5").click();
}

function nextStep7() {
    document.getElementById("tab8").click();
}

function preStep7() {
    document.getElementById("tab6").click();
}

function nextStep8() {
    document.getElementById("tab8").click();
}

function preStep8() {
    document.getElementById("tab7").click();
}

//提供設備上下toggle滑出滑入
$(document).ready(function(){
    $("#btn1").click(function(){
        $("#toggle1").slideToggle();              
    });
    $("#btn2").click(function(){
        $("#toggle2").slideToggle();              
    });
    $("#btn3").click(function(){
        $("#toggle3").slideToggle();              
    });
    $("#btn4").click(function(){
        $("#toggle4").slideToggle();              
    });
    $("#btn5").click(function(){
        $("#toggle5").slideToggle();              
    });
    $("#btn6").click(function(){
        $("#toggle6").slideToggle();              
    });
    $("#btn7").click(function(){
        $("#toggle7").slideToggle();              
    });
    $("#btn8").click(function(){
        $("#toggle8").slideToggle();              
    });
    $("#btn9").click(function(){
        $("#toggle9").slideToggle();              
    });
    $("#btn10").click(function(){
        $("#toggle10").slideToggle();              
    });
	
});
 

