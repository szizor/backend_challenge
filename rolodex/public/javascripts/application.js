//Sorting, and search
$(function() {
    $("#contacts th a, #contacts .pagination a").live("click", function() {
        $.getScript(this.href);
        return false;
    });
    $(function () {
        $('#clear').click(function () {
            $("#search").val("");
            $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
            return false;
        })
    });
    $(function () {
         $('#cancel_edit').live("click", function () {
            $("#layouts").html("");
            return false;
        })
    });

    $(function () {
        $('#new_c, #contacts td a,#edit_c, #delete_c,#new_l, #list td a,#insert a,#edit_l, #delete_l').live("click", function () {
            $('#layouts').html('Page is loading...');
            $.getScript(this.href, null, null, 'script');
            return false;
        });
    });
    $("#contacts_search input").keyup(function() {
        $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
        return false;
    });
});
// Checkbox functions
function selectAll(){
    $("input[type='checkbox']:not([disabled='disabled'])").each(function() {
        if ($(this).checked==true) {
            $(this).attr('checked', false);
        } else {
            $(this).attr('checked', true);
        }
    });
    /*$("input[type='checkbox']:not([disabled='disabled'])").attr('checked', true);*/
    num=$(":checkbox").filter(':checked').length;
    $("#check_count").text(num);
}
function uncheckAll(){
    $("input[type='checkbox']:not([disabled='disabled'])").each(function() {
        if ($(this).checked==true) {
            $(this).attr('checked', true);
        } else {
            $(this).attr('checked', false);
        }
    });
    /*$("input[type='checkbox']:not([disabled='disabled'])").attr('checked', true);*/
    num=$(":checkbox").filter(':checked').length;
    $("#check_count").text(num);
}
function validachecks(tipo){
    var okToSubmit = false;
    eliminar=confirm("Are you sure?");
    if (eliminar){
        if ($("input:checkbox:checked").length) okToSubmit = true;
        if( okToSubmit ) {
            $('#destroy').val(tipo);
            $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");
        } else {
            alert( "Please select at least one listing" );
        }
    }
}
//Add & remove field of addresses
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}
//Drag and Drop Contacts
