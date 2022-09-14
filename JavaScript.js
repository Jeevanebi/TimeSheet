// JavaScript source code





function mailcodesuccess() {
    $("#reset_div").hide(500);
    $("#reset_visible_div").show(500);
    console.log("block");
}


//Emtpy Gridview Template

$(function () {
    $("#emp_doj").datepicker({
        prevText: '<',
        nextText:'>'
    });

    $("#emp_dob").datepicker({
        prevText: '<',
        nextText: '>'
    });

    $("#project_startdate").datepicker({
        prevText: '<',
        nextText: '>',
    });

    $("#team_project_startdate").datepicker({
        prevText: '<',
        nextText: '>'
    });

    $('input[id*=txt_project_sdate]').datepicker({
        prevText: '<',
        nextText: '>',
        container: "#edit_project_popup",
        dateFormat: 'dd/mm/yy'
    });


    $("#txt_task_sdate").datepicker({
        prevText: '<',
        nextText: '>'
    });

    $("#txt_team_project_sdate").datepicker({
        prevText: '<',
        nextText: '>'
    });

    $("#txt_team_task_sdate").datepicker({
        prevText: '<',
        nextText: '>'
    });

});


function projectempty() {
    $find("edit_project_popup").hide(500);
    $find("create_project_icon").show(500);
    return false;
}

function taskempty() {
    $find("edit_task_popup").hide(500);
    $find("task_popup").show(500);
    return false;
}

function Tprojectempty() {
    $find("edit_team_project_popup").hide(500);

    return false;
}

function Ttaskempty() {
    $find("edit_team_task_popup").hide(500);
    $find("team_task_popup").show(500);
    return false;
}

function Editpopup(ptype) {

    if (ptype.getAttribute('name') == 'Individual') {

        $find("edit_project_popup").show();
        $find("edit_team_project_popup").hide();
    }
    else {
        $find("edit_project_popup").hide();
        $find("edit_team_project_popup").show();
    }
}

function Edittaskpopup(Ttype) {
    if (Ttype.getAttribute('name') == 'Individual') {
        $find("edit_task_popup").show();
    }
    else {
        $find("edit_team_task_popup").show();
    }
}

function collapse(img) {
    icon = $(img).find("i");
    if (img.getAttribute("name") == "plus") {
        $(img).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(img).next().html() + "</td></tr>");
        $(img).attr("name", "minus");
        icon.hasClass("fa-plus-square")
        {
            icon.addClass("fa-minus-square").removeClass("fa-plus-square");
        }
        return false;
    }
    if (img.getAttribute("name") == "minus") {
        $(img).attr("name", "plus");
        $(img).closest("tr").next().remove();
        icon.hasClass("fa-minus-square")
        {
            icon.addClass("fa-plus-square").removeClass("fa-minus-square");
        }
        return false;
    }
}

//Checkbox Buttons 

var Pcount = 0;
var Tcount = 0;
var TPcount = 0;
var TTcount = 0;

//project
function checkUncheck(checkbox_project) {
    var curdbtns = document.getElementById("curd_btns_project");
    if (checkbox_project.checked) {
        Pcount++;
    }
    else {
        Pcount--;
    }

    if (Pcount > 0) {
        curdbtns.style.display = "block";
    }
    else {
        curdbtns.style.display = "none";
    }
}


//task
function checkboxtask(checkbox_task) {
    var curdbtnstask = document.getElementById("curd_btns_task");
    if (checkbox_task.checked) {
        Tcount++;
    }
    else {
        Tcount--;
    }

    if (Tcount > 0) {
        curdbtnstask.style.display = "block";
    }
    else {
        curdbtnstask.style.display = "none";
    }
}

//team Project
function checkboxteam(checkbox_team) {
    var curdbtnsteam = document.getElementById("curd_btns_team");
    if (checkbox_team.checked) {
        TPcount++;
    }
    else {
        TPcount--;
    }

    if (TPcount > 0) {

        curdbtnsteam.style.display = "block";
    }
    else {
        curdbtnsteam.style.display = "none";
    }
}

//team task
function checkboxteamtask(checkbox_team_task) {
    var curdbtnstask = document.getElementById("curd_btns_team_task");
    if (checkbox_team_task.checked) {
        TTcount++;
    }
    else {
        TTcount--;
    }

    if (TTcount > 0) {
        curdbtnstask.style.display = "block";
    }
    else {
        curdbtnstask.style.display = "none";
    }
}
