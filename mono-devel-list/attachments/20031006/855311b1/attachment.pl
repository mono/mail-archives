Mono.Data.Tds/Mono.Data.Tds.Protocol/ChangeLog

2003-10-03  Diego Caravana  <diego@toth.it>

	* Tds70.cs: Now handles parameters of type ReturnValue and
	InputOutput.
	(BuildParameters): skips the ReturnValue params and builds the
	set string considering the assigned value for InputOutput ones.
	(BuildProcedureCall): like the preceding one plus adds the return
	value to the final select.

	
-----
System.Data/System.Data.SqlClient/ChangeLog

2003-10-03  Diego Caravana  <diego@toth.it>

	* SqlCommand.cs: no change.

	* SqlConnection.cs (Close): Added checks for null instance
	variables.

	* SqlParameter.cs (Direction): Now handles parameters of type
	ReturnValue and InputOutput.

	* SqlParameterCollection.cs (IndexOf(string)): Search for
	SqlParameter object in list is done by obtaining ParameterName
	attribute, not directly through list.IndexOf().
	
