// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: tLoad.sqf
//	@file Author: AgentRev

private ["_time", "_dayTime", "_date"];
_time = call compile preprocessFileLineNumbers ("persistence\server\world\" + call A3W_savingMethodDir + "\getTime.sqf");

if (["A3W_timeSaving"] call isConfigOn) then
{
	_dayTime = _time param [0, dayTime, [0]];
	_date = date;
	_date set [3, 0];
	_date set [4, _dayTime * 60];

	setDate _date;

	currentDate = date;
	publicVariable "currentDate";

	A3W_timeSavingInitDone = compileFinal 'true';
	publicVariable "A3W_timeSavingInitDone";
};