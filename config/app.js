// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
//this is right
function update_buttons() {
  $(".manage-button").each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage_id = $(bb).data('manage');
    if (manage_id == "") {
      $(bb).text("Manage");
    }
    else {
      $(bb).text("UnManage");
    }
  });
}

//this is right
function set_button(user_id, manage_id) {
  $(".manage-button").each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', manage_id);

    }
  });
  update_buttons();
}

function manage(user_id) {
  let text = JSON.stringify({
    manage: {
      manager_id: current_user_id,
      client_id: user_id,
    }
  });

  $.ajax(manage_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function unmanage(user_id, manage_id){
  //follow_path = "/api/v1/follows"
  $.ajax(manage_path + "/" + manage_id, {
    method: "DELETE",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "{}",
    success: (resp) => { set_button(user_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let user_id = btn.data('user-id');
  let manage_id = btn.data('manage');

  if (manage_id == "") {
    manage(user_id);
  }
  else {
    unmanage(user_id, manage_id);
  }
}

function init_manage(){
  if (!$(".manage-button")){
    return;
  }

  $(".manage-button").click(manage_click);

  update_buttons();
}

function set_time_button(task_id) {
  $('.time-button').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('start-time', "");
      $(bb).text('Start time');
    }
  })
}

function time_block_set(start_time, task_id, user_id) {
  let end_time = new Date().toJSON();
  console.log("here in time_block_set");
  let text = JSON.stringify({

    timeblock: {
      start_time: start_time,
      end_time: end_time,
      task_id: task_id,
      user_id: user_id
    }
  });

  $.ajax(timeblock_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_time_button(task_id); },
  });

}

function start_click(ev) {
  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let start_time = btn.data('start-time');
  let user_id = btn.data('user-id');

  if (start_time == '') {
    start_time_DB(start_time, task_id, user_id)
    let date = new Date();
    btn.data('start-time', date.toJSON());
    btn.text('end time');
  }
  else {
    time_block_set(start_time, task_id, user_id);
  }
}

function init_task(){
  if(!$(".time-button")){
    return;
  }

  $('.time-button').click(start_click);
}

$(init_manage);
$(init_task);
