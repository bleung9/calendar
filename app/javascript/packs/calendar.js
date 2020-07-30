//= require moment
//= require fullcalendar

$(document).on('turbolinks:load', function(){
  console.log("hihihi");
  eventCalendar();  
});
$(document).on('turbolinks:before-cache', clearCalendar);

function eventCalendar() {
  debugger
  return $('#calendar').fullCalendar({});
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete'); 
  $('#calendar').html('');
};



