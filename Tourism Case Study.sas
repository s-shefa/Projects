%let outpath='/home/u59264078/Intro to SAS/cr';
libname cr &outpath ;
/* clean tourism data */
data cr.cleaned_tourism;
	set cr.tourism;
	drop _1995-_2013;
	length Country_Name Tourism_Type $55;
	retain Country_Name Tourism_Type '';

	/* Part 1 */
	if A~='.' then
		Country_Name=Country;

	if Country='Inbound tourism' then
		Tourism_Type='Inbound tourism';
	else if Country='Outbound tourism' then
		Tourism_Type='Outbound tourism';

	if country=Country_Name then
		delete;

	/* Part 2 */
	if Series='..' then
		Series='';
	else
		Series=upcase(Series);
	dollar=scan(Country, -1, 5);

	if dollar='tourism' then
		dollar='';

	if _2014='..' then
		_2014='.';

	/* 	Part 3  */
	if dollar='Mn' then
		Y2014=_2014 * 1000000;
	else if dollar='Thousands' then
		Y2014=_2014 * 1000;

	if Y2014='.' then
		Y2014='';
	format Y2014 comma17.;

	if dollar='Mn' then
		Category=tranwrd(Country, 'Mn', '');
	else if dollar='Thousands' then
		Category=tranwrd(Country, ' - Thousands', '');
	output;
	keep Country_Name Tourism_Type Category Series Y2014;
run;

/* format for continent */
proc format;
	value continent 
	1 = 'North America' 
	2 = 'South America' 
	3 = 'Europe'  
	4 = 'Africa' 
	5 = 'Asia' 
	6 = 'Oceania'
	7 = ' Antarctica';	
run;

/* sort country_info */
proc sort data=cr.country_info 
		out=cr.country_sorted(rename=(Country=Country_Name));
	by Country;
run;

/* Final_Tourism and NoCountryFound tables */
data cr.Final_Tourism cr.NoCountryFound(keep=Country_Name);
	merge cr.cleaned_tourism(in=inTourism) cr.country_sorted(in=inCountry);
	by Country_Name;

	if inTourism=1 and inCountry=1 and Category~='' and Series~='' and Y2014~='.' 
		then
			output cr.Final_Tourism;
	else if inTourism=0 and inCountry=1 or inTourism=1 and inCountry=0 or 
		inTourism=0 and inCountry=0 then
			output cr.NoCountryFound;
	format Continent continent.;
run;