//= require moment 
//= require fullcalendar

require('jquery')

$(document).on('turbolinks:load', function(){
  console.log("fuck you");
  eventCalendar();  
});
$(document).on('turbolinks:before-cache', clearCalendar);

function eventCalendar() {
  return $('#calendar').fullCalendar({});
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete'); 
  $('#calendar').html('');
};



