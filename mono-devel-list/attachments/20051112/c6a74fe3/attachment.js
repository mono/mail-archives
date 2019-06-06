/*
	FWCDatePicker client script support
*/

var
	weekDayNames   = new Array("S", "M", "T", "W", "T", "F", "S"),
	totalMonthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
	monthNames     = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),
	actualDate     = new Date(),
	actualDay      = actualDate.getDate(),
	actualMonth    = actualDate.getMonth(),
	actualYear     = actualDate.getFullYear();

// Gets the absolute position of the supplied element
function getPosition(startTag, direction) {
   var pixelAmt = (direction == 'LEFT') ? startTag.offsetLeft : startTag.offsetTop;
   while ((startTag.tagName != 'BODY') && (startTag.tagName != 'HTML')) {
      startTag = startTag.offsetParent;
      pixelAmt += (direction == 'LEFT') ? startTag.offsetLeft : startTag.offsetTop;
   }
   return pixelAmt;
}

function padl(text, quantity, simbol)
{
	var result = "";
	if(text.toString().length < quantity)
	{
		for(i = 0; i < (quantity - text.toString().length); i++)
		{
			result += simbol;
		}
		result += text;
	}
	else
	{
		result = text;
	}
	return result;
}

function previousMonth(calendarName, fieldName)
{
	actualMonth --;
	if(actualMonth < 0)
	{
		actualDay   = 1;
		actualMonth = 11;
		actualYear--;
	}
	document.getElementById(calendarName).innerHTML = calendar(calendarName, new Date(actualYear, actualMonth, actualDay), fieldName);
}

function nextMonth(calendarName, fieldName)
{
	actualMonth ++;
	if(actualMonth > 11)
	{
		actualDay   = 1;
		actualMonth = 0;
		actualYear++;
	}
	document.getElementById(calendarName).innerHTML = calendar(calendarName, new Date(actualYear, actualMonth, actualDay), fieldName);
}

function calendar(calendarName, date, fieldName)
{
  var html = "";

	actualDate  = date;
	actualDay   = date.getDate();
	actualMonth = date.getMonth();
	actualYear  = date.getFullYear();

	html += "<table cellspacing='0' cellpadding='0' border='0'";
  html += "       style='border-top-color: gray; border-bottom-color: gray; border-left-color: gray; border-right-color: gray;'>\n";
	html += "	<tr>\n";
	html += "		<td id='prevMonth' onclick=\"previousMonth('" + calendarName + "', '" + fieldName + "');\" style='cursor: pointer' align='center'>&lt;</td>\n";
	html += "		<td id='actualMonth' colspan='5' align='center'>" + monthNames[actualMonth] + " " + actualYear + "</td>\n";
	html += "		<td id='nextMonth' onclick=\"nextMonth('" + calendarName + "', '" + fieldName + "');\" style='cursor: pointer' align='center'>&gt;</td>\n";
	html += "	</tr>\n";

	html += "	<tr>\n";
	for(var d = 0; d < weekDayNames.length; d++)
	{
		html += "	<td id='weekDay' align='center'>" + weekDayNames[d] + "</td>\n";
	}
	html += "	</tr>\n";

	html += "	<tr>\n";

	var initialDate  = new Date(actualYear, actualMonth, 1);
	var startOfMonth = initialDate.getDay();
	for(var i = 0; i < startOfMonth; i++)
	{
		html += "<td id='monthDay'>&nbsp;</td>";
	}

	var weekDayCount = startOfMonth;
	for(var day = 1; day <= totalMonthDays[actualMonth]; day++)
	{
    var dayName = (day == actualDay) ? "actualDay" : "monthDay";

		html += "<td id='" + dayName + "' align='center' style='cursor: pointer'";
		html += "onclick=\"document.getElementById('" + fieldName + "').value = '" + padl(day, 2, "0") + "/" + padl(actualMonth + 1, 2, "0") + "/" + actualYear + "';";
    html += "document.getElementById('" + calendarName + "').style.visibility = 'hidden';\">";
    html += day;
    html += "</td>";
		weekDayCount++;
		if(weekDayCount == 7)
		{
			html += "	</tr>\n";
			html += "	<tr>\n";
			weekDayCount = 0;
		}
	}
	html += "</table>\n";
	return html;
}

function displayCalendar(calendarName, buttonName, fieldName)
{
	var calendarObject  = document.getElementById(calendarName);
	var buttonObject    = document.getElementById(buttonName);
	var fieldObject     = document.getElementById(fieldName);

	calendarObject.style.top  = getPosition(buttonObject, 'TOP') + (buttonObject.offsetHeight - 1);
	calendarObject.style.left = getPosition(buttonObject, 'LEFT');

  if(fieldObject.value.length != 0)
  {
    var dateParts     = fieldObject.value.split("/");
    var suppliedDate  = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);
  	document.getElementById(calendarName).innerHTML = calendar(calendarName, suppliedDate, fieldName);
  }
  else
  {
  	document.getElementById(calendarName).innerHTML = calendar(calendarName, actualDate, fieldName);
  }

  calendarObject.style.visibility = 'visible';
}

function hideCalendar(calendarName)
{
	var calendarObject  = document.getElementById(calendarName);
  calendarObject.style.visibility = 'hidden';
}