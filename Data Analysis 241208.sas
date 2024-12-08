*/Check the variable distribution and missing values./;
*/For cost related variables/;
PROC MEANS DATA=hoscost.cost N NMISS;
	VAR total_cost charcare_cost bed_debt_expense Uncompcare_cost wrcost_atp;
RUN;

*/General frequency of non-numeric variables in dataset/;
PROC FREQ DATA=hoscost.cost;
	TABLE state_code provider_type type_of_control;
RUN;

*/Summary of cost variables./;
PROC UNIVARIATE DATA=hoscost.cost;
	VAR total_cost charcare_cost bed_debt_expense Uncompcare_cost 
		unreim_uncomp nonsalary_cost depreciation_cost inventory 
		prepaid_expenses wrcost_core cl_dpc drg_befoct1 drg_afteroct1
		wrcost_rhcfqhc wrcost_atp;
RUN;

PROC FREQ DATA=hoscost.cost;
	TABLE intern_resi_cost;
RUN;

*/Summary of income variables./;
PROC UNIVARIATE DATA=hoscost.cost;
	VAR total_income inpatient_charges outpatient_charges outpatient_inpatient
	    deferred_income inpatient_revenue outpatient_revenue total_patient_revenue
	    net_patient_revenue netincome_ser_pat to_income netincome netreve_medicaid
	    medicaid_charges netreve_sachi sachip_charges;
RUN;


*/Cross-tabulation of average total cost based on state and year./;

PROC SQL;
    CREATE TABLE state_year_avgcost AS
    SELECT
        state_code,
        MEAN(CASE WHEN year = 2017 THEN total_cost END) AS avg_cost_2017,
        MEAN(CASE WHEN year = 2018 THEN total_cost END) AS avg_cost_2018,
        MEAN(CASE WHEN year = 2019 THEN total_cost END) AS avg_cost_2019,
        MEAN(CASE WHEN year = 2020 THEN total_cost END) AS avg_cost_2020,
        MEAN(CASE WHEN year = 2021 THEN total_cost END) AS avg_cost_2021,
        MEAN(CASE WHEN year = 2022 THEN total_cost END) AS avg_cost_2022
    FROM hoscost.cost
    GROUP BY state_code
    ORDER BY state_code;
QUIT;

*/Check the number of records by each state./;
PROC FREQ DATA=HOSCOST.COST;
	TABLE state_code;
RUN;

*/Total cost in American Samoa./;
PROC PRINT DATA=HOSCOST.COST;
	VAR total_cost;
	WHERE state_code='AS';
RUN; *Only 2 records in American Samoa.;

*/Total cost in Urban and Rural./;
PROC PRINT DATA=HOSCOST.COST;
	VAR rural_urban;
RUN;

*/Check the data frequency of variable rural_urban./;
PROC FREQ DATA=HOSCOST.COST;
	TABLE rural_urban;
RUN;

PROC SQL;
    CREATE TABLE ru_year_avgcost AS
    SELECT
        rural_urban,
        MEAN(CASE WHEN year = 2017 THEN total_cost END) AS avg_cost_2017,
        MEAN(CASE WHEN year = 2018 THEN total_cost END) AS avg_cost_2018,
        MEAN(CASE WHEN year = 2019 THEN total_cost END) AS avg_cost_2019,
        MEAN(CASE WHEN year = 2020 THEN total_cost END) AS avg_cost_2020,
        MEAN(CASE WHEN year = 2021 THEN total_cost END) AS avg_cost_2021,
        MEAN(CASE WHEN year = 2022 THEN total_cost END) AS avg_cost_2022
    FROM hoscost.cost
    WHERE rural_urban='R' OR rural_urban='U'
    GROUP BY rural_urban
    ORDER BY rural_urban;
QUIT;

