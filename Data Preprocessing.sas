LIBNAME HOSCOST '/home/u64000221';

*Import the dataset;
%MACRO import_years(start=2017, end=2022);
	%DO yr = &start %to &end;
		PROC IMPORT
			DATAFILE="/home/u64000221/Hospital Cost Project/Data Sets/CostReport_&yr._Final.csv"
			DBMS=csv
			REPLACE
			OUT=data&yr
		;
		RUN;
		
		DATA hoscost.cost&yr;
        	SET work.data&yr;
        	YEAR = &yr;
    	RUN;
	%END;
%MEND import_years;

%import_years;

*/Variables table reports of each dataset./;
PROC CONTENTS data=hoscost.cost2017 varnum;
RUN;

PROC CONTENTS data=hoscost.cost2018 varnum;
RUN;

PROC CONTENTS data=hoscost.cost2019 varnum;
RUN;

PROC CONTENTS data=hoscost.cost2020 varnum;
RUN;

PROC CONTENTS data=hoscost.cost2021 varnum;
RUN;

PROC CONTENTS data=hoscost.cost2022 varnum;
RUN;

*/cost2017/;
*/Hospital Total Days Title V For/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = PUT("Hospital Total Days Title V For"n, best12.);
    DROP "Hospital Total Days Title V For"n;
    RENAME intermediate = "Hospital Total Days Title V For"n;
RUN;

*/Wage-Related Costs (Core)/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Wage-Related Costs (Core)"n, best12.);
    DROP "Wage-Related Costs (Core)"n;
    RENAME intermediate = "Wage-Related Costs (Core)"n;
RUN;

*/Total Salaries (adjusted)/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Total Salaries (adjusted)"n, best12.);
    DROP "Total Salaries (adjusted)"n;
    RENAME intermediate = "Total Salaries (adjusted)"n;
RUN;

*/Contract Labor: Direct Patient C/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Contract Labor: Direct Patient C"n, best12.);
    DROP "Contract Labor: Direct Patient C"n;
    RENAME intermediate = "Contract Labor: Direct Patient C"n;
RUN;

*/Temporary Investments/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Temporary Investments"n, best12.);
    DROP "Temporary Investments"n;
    RENAME intermediate = "Temporary Investments"n;
RUN;

*/Notes Receivable/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Notes Receivable"n, best12.);
    DROP "Notes Receivable"n;
    RENAME intermediate = "Notes Receivable"n;
RUN;

*/Unsecured Loans/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Unsecured Loans"n, best12.);
    DROP "Unsecured Loans"n;
    RENAME intermediate = "Unsecured Loans"n;
RUN;

*/DRG Amounts Before October 1/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("DRG Amounts Before October 1"n, best12.);
    DROP "DRG Amounts Before October 1"n;
    RENAME intermediate = "DRG Amounts Before October 1"n;
RUN;

*/DRG Amounts After October 1/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("DRG Amounts After October 1"n, best12.);
    DROP "DRG Amounts After October 1"n;
    RENAME intermediate = "DRG Amounts After October 1"n;
RUN;

*/Disproportionate Share Adjustmen/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Disproportionate Share Adjustmen"n, best12.);
    DROP "Disproportionate Share Adjustmen"n;
    RENAME intermediate = "Disproportionate Share Adjustmen"n;
RUN;

*/Allowable DSH Percentage/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Allowable DSH Percentage"n, best12.);
    DROP "Allowable DSH Percentage"n;
    RENAME intermediate = "Allowable DSH Percentage"n;
RUN;

*/Managed Care Simulated Payments/;
DATA hoscost.cost2017;
    SET hoscost.cost2017;
    intermediate = INPUT("Managed Care Simulated Payments"n, best12.);
    DROP "Managed Care Simulated Payments"n;
    RENAME intermediate = "Managed Care Simulated Payments"n;
RUN;

*/cost2018/;
*/Health Information Technology De/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("Health Information Technology De"n, best12.);
    DROP "Health Information Technology De"n;
    RENAME intermediate = "Health Information Technology De"n;
RUN;

*/DRG Amounts Before October 1/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("DRG Amounts Before October 1"n, best12.);
    DROP "DRG Amounts Before October 1"n;
    RENAME intermediate = "DRG Amounts Before October 1"n;
RUN;

*/DRG Amounts After October 1/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("DRG Amounts After October 1"n, best12.);
    DROP "DRG Amounts After October 1"n;
    RENAME intermediate = "DRG Amounts After October 1"n;
RUN;

*/Disproportionate Share Adjustmen/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("Disproportionate Share Adjustmen"n, best12.);
    DROP "Disproportionate Share Adjustmen"n;
    RENAME intermediate = "Disproportionate Share Adjustmen"n;
RUN;

*/Allowable DSH Percentage/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("Allowable DSH Percentage"n, best12.);
    DROP "Allowable DSH Percentage"n;
    RENAME intermediate = "Allowable DSH Percentage"n;
RUN;

*/Managed Care Simulated Payments/;
DATA hoscost.cost2018;
    SET hoscost.cost2018;
    intermediate = INPUT("Managed Care Simulated Payments"n, best12.);
    DROP "Managed Care Simulated Payments"n;
    RENAME intermediate = "Managed Care Simulated Payments"n;
RUN;

*/cost2019/;
*/Unsecured Loans/;
DATA hoscost.cost2019;
    SET hoscost.cost2019;
    intermediate = INPUT("Unsecured Loans"n, best12.);
    DROP "Unsecured Loans"n;
    RENAME intermediate = "Unsecured Loans"n;
RUN;

*/DRG Amounts After October 1/;
DATA hoscost.cost2019;
    SET hoscost.cost2019;
    intermediate = INPUT("DRG Amounts After October 1"n, best12.);
    DROP "DRG Amounts After October 1"n;
    RENAME intermediate = "DRG Amounts After October 1"n;
RUN;

*/Managed Care Simulated Payments/;
DATA hoscost.cost2019;
    SET hoscost.cost2019;
    intermediate = INPUT("Managed Care Simulated Payments"n, best12.);
    DROP "Managed Care Simulated Payments"n;
    RENAME intermediate = "Managed Care Simulated Payments"n;
RUN;

*/Net Revenue from Stand-Alone CHI/;
DATA hoscost.cost2019;
    SET hoscost.cost2019;
    intermediate = INPUT("Net Revenue from Stand-Alone CHI"n, best12.);
    DROP "Net Revenue from Stand-Alone CHI"n;
    RENAME intermediate = "Net Revenue from Stand-Alone CHI"n;
RUN;

*/Stand-Alone CHIP Charges/;
DATA hoscost.cost2019;
    SET hoscost.cost2019;
    intermediate = INPUT("Stand-Alone CHIP Charges"n, best12.);
    DROP "Stand-Alone CHIP Charges"n;
    RENAME intermediate = "Stand-Alone CHIP Charges"n;
RUN;

*/cost2020/;
*/Notes Receivable/;
DATA hoscost.cost2020;
    SET hoscost.cost2020;
    intermediate = INPUT("Notes Receivable"n, best12.);
    DROP "Notes Receivable"n;
    RENAME intermediate = "Notes Receivable"n;
RUN;

*/Health Information Technology De/;
DATA hoscost.cost2020;
    SET hoscost.cost2020;
    intermediate = INPUT("Health Information Technology De"n, best12.);
    DROP "Health Information Technology De"n;
    RENAME intermediate = "Health Information Technology De"n;
RUN;

*/cost2021/;
*/Number of Interns and Residents/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Number of Interns and Residents"n, best12.);
    DROP "Number of Interns and Residents"n;
    RENAME intermediate = "Number of Interns and Residents"n;
RUN;

*/Total Days Title V/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Total Days Title V"n, best12.);
    DROP "Total Days Title V"n;
    RENAME intermediate = "Total Days Title V"n;
RUN;

*/Total Discharges Title V/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Total Discharges Title V"n, best12.);
    DROP "Total Discharges Title V"n;
    RENAME intermediate = "Total Discharges Title V"n;
RUN;



*/Hospital Total Days Title V For/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Hospital Total Days Title V For"n, best12.);
    DROP "Hospital Total Days Title V For"n;
    RENAME intermediate = "Hospital Total Days Title V For"n;
RUN;

*/Hospital Total Discharges Title/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Hospital Total Discharges Title"n, best12.);
    DROP "Hospital Total Discharges Title"n;
    RENAME intermediate = "Hospital Total Discharges Title"n;
RUN;

*/Wage-Related Costs (RHC/FQHC)/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Wage-Related Costs (RHC/FQHC)"n, best12.);
    DROP "Wage-Related Costs (RHC/FQHC)"n;
    RENAME intermediate = "Wage-Related Costs (RHC/FQHC)"n;
RUN;

*/Wage Related Costs for Part - A/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Wage Related Costs for Part - A"n, best12.);
    DROP "Wage Related Costs for Part - A"n;
    RENAME intermediate = "Wage Related Costs for Part - A"n;
RUN;

*/Wage Related Costs for Interns a/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Wage Related Costs for Interns a"n, best12.);
    DROP "Wage Related Costs for Interns a"n;
    RENAME intermediate = "Wage Related Costs for Interns a"n;
RUN;

*/Health Information Technology De/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = INPUT("Health Information Technology De"n, best12.);
    DROP "Health Information Technology De"n;
    RENAME intermediate = "Health Information Technology De"n;
RUN;

*/Unsecured Loans/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = INPUT("Unsecured Loans"n, best12.);
    DROP "Unsecured Loans"n;
    RENAME intermediate = "Unsecured Loans"n;
RUN;

*/Total IME Payment/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("Total IME Payment"n, best12.);
    DROP "Total IME Payment"n;
    RENAME intermediate = "Total IME Payment"n;
RUN;

*/V Hospital Total Discharges Titl/;
DATA hoscost.cost2021;
    SET hoscost.cost2021;
    intermediate = PUT("V Hospital Total Discharges Titl"n, best12.);
    DROP "V Hospital Total Discharges Titl"n;
    RENAME intermediate = "V Hospital Total Discharges Titl"n;
RUN;

*/cost2022/;
*/Number of Interns and Residents/;
DATA hoscost.cost2022;
    SET hoscost.cost2022;
    intermediate = PUT("Number of Interns and Residents"n, best12.);
    DROP "Number of Interns and Residents"n;
    RENAME intermediate = "Number of Interns and Residents"n;
RUN;

*/Total IME Payment/;
DATA hoscost.cost2022;
    SET hoscost.cost2022;
    intermediate = PUT("Total IME Payment"n, best12.);
    DROP "Total IME Payment"n;
    RENAME intermediate = "Total IME Payment"n;
RUN;

*/Try to combine datasets again./;
DATA hoscost.cost;
    SET 
        hoscost.cost2017
        hoscost.cost2018
        hoscost.cost2019
        hoscost.cost2020
        hoscost.cost2021
        hoscost.cost2022;
RUN;
**Combined successfully**

*/Transform all conflicted variables to numeric/;
*/Number of Interns and Residents/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Number of Interns and Residents"n, best12.);
    DROP "Number of Interns and Residents"n;
    RENAME intermediate = "Number of Interns and Residents"n;
RUN;

*/Total Days Title V/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Total Days Title V"n, best12.);
    DROP "Total Days Title V"n;
    RENAME intermediate = "Total Days Title V"n;
RUN;

*/Total Discharges Title V/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Total Discharges Title V"n, best12.);
    DROP "Total Discharges Title V"n;
    RENAME intermediate = "Total Discharges Title V"n;
RUN;

*/Hospital Total Days Title V For/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Hospital Total Days Title V For"n, best12.);
    DROP "Hospital Total Days Title V For"n;
    RENAME intermediate = "Hospital Total Days Title V For"n;
RUN;

*/Hospital Total Discharges Title/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Hospital Total Discharges Title"n, best12.);
    DROP "Hospital Total Discharges Title"n;
    RENAME intermediate = "Hospital Total Discharges Title"n;
RUN;

*/Wage-Related Costs (RHC/FQHC)/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Wage-Related Costs (RHC/FQHC)"n, best12.);
    DROP "Wage-Related Costs (RHC/FQHC)"n;
    RENAME intermediate = "Wage-Related Costs (RHC/FQHC)"n;
RUN;

*/Wage Related Costs for Part - A/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Wage Related Costs for Part - A"n, best12.);
    DROP "Wage Related Costs for Part - A"n;
    RENAME intermediate = "Wage Related Costs for Part - A"n;
RUN;

*/Wage Related Costs for Interns/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Wage Related Costs for Interns"n, best12.);
    DROP "Wage Related Costs for Interns"n;
    RENAME intermediate = "Wage Related Costs for Interns"n;
RUN;

*/Total IME Payment/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("Total IME Payment"n, best12.);
    DROP "Total IME Payment"n;
    RENAME intermediate = "Total IME Payment"n;
RUN;

*/V Hospital Total Discharges Titl/;
DATA hoscost.cost;
    SET hoscost.cost;
    intermediate = INPUT("V Hospital Total Discharges Titl"n, best12.);
    DROP "V Hospital Total Discharges Titl"n;
    RENAME intermediate = "V Hospital Total Discharges Titl"n;
RUN;

*/Delete Depulicated Variables/;
DATA hoscost.cost;
    SET hoscost.cost;
    DROP "Hospital Total Discharges Title"n;
RUN;

DATA hoscost.cost;
    SET hoscost.cost;
    DROP "Wage Related Costs for Interns"n;
RUN;

*/Check the cost datasets/;
PROC CONTENTS DATA=hoscost.cost VARNUM;
RUN;

*/Return the report as pdf for reference./;


*/Rename the variables to fit the SAS rules, but keep the original name as label/;
*/Provider CCN/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Provider CCN"n = provider_ccn;
	LABEL provider_ccn = 'Provider CCN';
RUN;

*/Hospital Name/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Name"n = hospital_name;
	LABEL hospital_name = 'Hospital Name';
RUN;

*/Street Address/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Street Address"n = st_address;
	LABEL st_address = 'st_address';
RUN;

*/City/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME City = cit;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME cit = city;
RUN;

*/State Code/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "State Code"n = state_code;
	LABEL state_code = 'State Code';
RUN;

*/Zip Code/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Zip Code"n = zip_code;
	LABEL zip_code = 'Zip Code';
RUN;

*/County/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME County = count;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME count = county;
	LABEL county = 'County';
RUN;

*/Medicare CBSA Number/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Medicare CBSA Number"n = medicare_csba_num;
	LABEL medicare_csba_num = 'Medicare CBSA Number';
RUN;

*/Rural Versus Urban/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Rural Versus Urban"n = rural_urban;
	LABEL rural_urban = 'Rural Versus Urban';
RUN;

*/CCN Family Type/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "CCN Facility Type"n = ccn_facility_type;
	LABEL ccn_facility_type = 'CCN Facility Type';
RUN;

*/Provider Type/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Provider Type"n = provider_type;
	LABEL provider_type = 'Provider Type';
RUN;

*/Type of Control/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Type of Control"n = type_of_control;
	LABEL type_of_control = 'Type of Control';
RUN;

*/Fiscal Year Begin Date/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Fiscal Year Begin Date"n = fyr_begin_date;
	LABEL fyr_begin_date = 'Fiscal Year Begin Date';
RUN;

*/Fiscal Year End Date/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Fiscal Year End Date"n = fyr_end_date;
	LABEL fyr_end_date = 'Fiscal Year End Date';
RUN;

*/FTE - Employees on Payroll/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "FTE - Employees on Payroll"n = fte_payroll;
	LABEL fte_payroll = 'FTE - Employees on Payroll';
RUN;

*/Total Days Title XVIII/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Days Title XVIII"n = days_xviii;
	LABEL days_xviii = 'Total Days Title XVIII';
RUN;

*/Total Days Title XIX/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Days Title XIX"n = days_xix;
	LABEL days_xix = 'Total Days Title XIX';
RUN;

*/Total Days (V + XVIII + XIX + Unknown)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Days (V + XVIII + XIX + Un"n = days_all;
	LABEL days_all = 'Total Days All';
RUN;

*/Number of Beds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Number of Beds"n = beds_num;
	LABEL beds_num = 'Number of Beds';
RUN;

*/Total Bed Days Available/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Bed Days Available"n = total_beds_available;
	LABEL total_beds_available = 'Total Bed Days Available';
RUN;

*/Total Discharges Title XVIII/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Discharges Title XVIII"n = discharges_xviii;
	LABEL discharges_xviii = 'Total Discharges Title XVIII';
RUN;

*/Total Discharges Title XIX/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Discharges Title XIX"n = discharges_xix;
	LABEL discharges_xix = 'Total Discharges Title XIX';
RUN;

*/Total Discharges (V + XVIII + X + Unknown)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Discharges (V + XVIII + XI"n = discharges_all;
	LABEL discharges_all = 'Total Discharges All';
RUN;

*/Number of Beds + Total for all Subproviders/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Number of Beds + Total for all S"n = bedsnum_allsubp;
	LABEL bedsnum_allsubp = 'Number of Beds + Total for all Subproviders';
RUN;

*/Hospital Total Days Title XVIII For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Days Title XVIII"n = hosdays_xviii;
	LABEL hosdays_xviii = 'Hospital Total Days Title XVIII For Adults & Peds';
RUN;

*/Hospital Total Days Title XIX For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Days Title XIX Fo"n = hosdays_xix;
	LABEL hosdays_xix = 'Hospital Total Days Title XIX For Adults & Peds';
RUN;

*/Hospital Total Days (V + XVIII + XIX + Unknown) For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Days (V + XVIII +"n = hosdays_all;
	LABEL hosdays_all = 'Hospital Total Days (V + XVIII + XIX + Unknown) For Adults & Peds';
RUN;

*/Hospital Number of Beds For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Number of Beds For Adul"n = hos_bednums;
	LABEL hos_bednums = 'Hospital Number of Beds For Adults & Peds';
RUN;

*/Hospital Number of Beds Available For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Bed Days Availabl"n = hos_bednums_available;
	LABEL hos_bednums_available = 'Hospital Number of Beds For Adults & Peds';
RUN;

*/Hospital Total Discharges Title XVIII For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "XVIII Hospital Total Discharges"n = xviii_hos_discharge;
	LABEL xviii_hos_discharge = 'Hospital Number of Beds For Adults & Peds';
RUN;

*/Hospital Total Discharges Title XIX For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "XIX Hospital Total Discharges Ti"n = xix_hos_discharge;
	LABEL xix_hos_discharge = 'Hospital Total Discharges Title XIX For Adults & Peds';
RUN;

*/Hospital Total Discharges (V + XVIII + XIX + Unknown) For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Discharges (V + X"n = all_hos_discharge;
	LABEL all_hos_discharge = 'Hospital Total Discharges (V + XVIII + XIX + Unknown) For Adults & Peds';
RUN;

*/Cost of Charity Care/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Cost of Charity Care"n = charcare_cost;
	LABEL charcare_cost = 'Cost of Charity Care';
RUN;

*/Total Bad Debt Expense/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Bad Debt Expense"n = bed_debt_expense;
	LABEL bed_debt_expense = 'Total Bad Debt Expense';
RUN;

*/Cost of Uncompensated Care/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Cost of Uncompensated Care"n = Uncompcare_cost;
	LABEL Uncompcare_cost = 'Cost of Uncompensated Care';
RUN;

*/Total Unreimbursed and Uncompensated Care/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Unreimbursed and Uncompens"n = unreim_uncomp;
	LABEL unreim_uncomp = 'Total Unreimbursed and Uncompensated Care';
RUN;

*/Total Salaries From Worksheet A/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Salaries From Worksheet A"n = salaries_a;
	LABEL salaries_a = 'Total Salaries From Worksheet A';
RUN;

*/Overhead Non-Salary Costs/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Overhead Non-Salary Costs"n = nonsalary_cost;
	LABEL nonsalary_cost = 'Overhead Non-Salary Costs';
RUN;

*/Depreciation Cost/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Depreciation Cost"n = depreciation_cost;
	LABEL depreciation_cost = 'Depreciation Cost';
RUN;

*/Total Costs/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Costs"n = total_cost;
	LABEL total_cost = 'Total Costs';
RUN;

*/Inpatient Total Charges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Inpatient Total Charges"n = inpatient_charges;
	LABEL inpatient_charges = 'Inpatient Total Charges';
RUN;

*/Outpatient Total Charges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Outpatient Total Charges"n = outpatient_charges;
	LABEL outpatient_charges = 'Outpatient Total Charges';
RUN;

*/Combined Outpatient + Inpatient Total Charges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Combined Outpatient + Inpatient"n = outpatient_inpatient;
	LABEL outpatient_inpatient = 'Combined Outpatient + Inpatient';
RUN;

*/Wage Related Costs for Interns and Residents/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Wage Related Costs for Interns a"n = intern_resi_cost;
	LABEL intern_resi_cost = 'Wage Related Costs for Interns and Residents';
RUN;

*/Cash on Hand and in Banks/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Cash on Hand and in Banks"n = cash_handbank;
	LABEL cash_handbank = 'Cash on Hand and in Banks';
RUN;

*/Accounts Receivable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Accounts Receivable"n = accounts_receivable;
	LABEL accounts_receivable = 'Accounts Receivable';
RUN;

*/Less: Allowances for Uncollectible Notes and Accounts Receivable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Less: Allowances for Uncollectib"n = allowances;
	LABEL allowances = 'Allowances for Uncollectible Notes and Accounts Receivable';
RUN;

*/Inventory/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME Inventory = inven;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME inven = inventory;
	LABEL inventory = 'Inventory';
RUN;

*/Prepaid Expenses/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Prepaid Expenses"n = prepaid_expenses;
	LABEL prepaid_expenses = 'Prepaid Expenses';
RUN;

*/Other Current Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Other Current Assets"n = other_current_assets;
	LABEL other_current_assets = 'Other Current Assets';
RUN;

*/Total Current Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Current Assets"n = total_current_assets;
	LABEL total_current_assets = 'Total Current Assets';
RUN;

*/Land/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME Land = lan;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME lan = land;
	LABEL land = 'Land';
RUN;

*/Land Improvements/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Land Improvements"n = land_improvements;
	LABEL land_improvements = 'Land Improvements';
RUN;

*/Buildings/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME Buildings = build;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME build = buildings;
	LABEL buildings = 'Buildings';
RUN;

*/Leasehold Improvements/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Leasehold Improvements"n = leasehold_improvements;
	LABEL leasehold_improvements = 'Leasehold Improvements';
RUN;

*/Fixed Equipment/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Fixed Equipment"n = fixed_equipment;
	LABEL fixed_equipment = 'Fixed Equipment';
RUN;

*/Major Movable Equipment/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Major Movable Equipment"n = major_movable_equipment;
	LABEL major_movable_equipment = 'Major Movable Equipment';
RUN;

*/Minor Equipment Depreciable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Minor Equipment Depreciable"n = minor_equipment_depreciable;
	LABEL minor_equipment_depreciable = 'Minor Equipment Depreciable';
RUN;

*/Health Information Technology Designated Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Health Information Technology De"n = hit_designated_assets;
	LABEL hit_designated_assets = 'Health Information Technology Designated Assets';
RUN;

*/Total Fixed Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Fixed Assets"n = total_fixed_assets;
	LABEL total_fixed_assets = 'Total Fixed Assets';
RUN;

*/Investments/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME Investments = invest;
RUN;

DATA hoscost.cost;
	SET hoscost.cost;
	RENAME invest = investments;
	LABEL investments = 'Investments';
RUN;

*/Other Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Other Assets"n = other_assets;
	LABEL other_assets = 'Other Assets';
RUN;

*/Total Other Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Other Assets"n = total_other_assets;
	LABEL total_other_assets = 'Total Other Assets';
RUN;

*/Total Assets/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Assets"n = total_assets;
	LABEL total_assets = 'Total Assets';
RUN;

*/Accounts Payable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Accounts Payable"n = accounts_payable;
	LABEL accounts_payable = 'Accounts Payable';
RUN;

*/Salaries, Wages, and Fees Payable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Salaries, Wages, and Fees Payab"n = sw_feespayab;
	LABEL sw_feespayab = 'Salaries, Wages, and Fees Payable';
RUN;

*/Payroll Taxes Payable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Payroll Taxes Payable"n = payroll_taxespayable;
	LABEL payroll_taxespayable = 'Payroll Taxes Payable';
RUN;

*/Notes and Loans Payable (Short Term)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Notes and Loans Payable (Short T"n = notes_payableloans_st;
	LABEL notes_payableloans_st = 'Notes and Loans Payable (Short Term)';
RUN;

*/Deferred Income/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Deferred Income"n = deferred_income;
	LABEL deferred_income = 'Deferred Income';
RUN;

*/Other Current Liabilities/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Other Current Liabilities"n = oc_liabilities;
	LABEL oc_liabilities = 'Other Current Liabilities';
RUN;

*/Total Current Liabilities/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Current Liabilities"n = tc_liabilities;
	LABEL tc_liabilities = 'Total Current Liabilities';
RUN;

*/Mortgage Payable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Mortgage Payable"n = mortgage_payable;
	LABEL mortgage_payable = 'Mortgage Payable';
RUN;

*/Notes Payable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Notes Payable"n = notes_payable;
	LABEL notes_payable = 'Notes Payable';
RUN;

*/Other Long Term Liabilities/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Other Long Term Liabilities"n = olt_liabilities;
	LABEL olt_liabilities = 'Other Long Term Liabilities';
RUN;

*/Total Long Term Liabilities/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Long Term Liabilities"n = tlt_liabilities;
	LABEL tlt_liabilities = 'Total Long Term Liabilities';
RUN;

*/Total Liabilities/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Liabilities"n = t_liabilities;
	LABEL t_liabilities = 'Total Liabilities';
RUN;

*/General Fund Balance/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "General Fund Balance"n = gf_balance;
	LABEL gf_balance = 'General Fund Balance';
RUN;

*/Total Fund Balances/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Fund Balances"n = tf_balances;
	LABEL tf_balances = 'Total Fund Balances';
RUN;

*/Total Liabilities and Fund Balances/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Liabilities and Fund Balan"n = tliab_fundbalan;
	LABEL tliab_fundbalan = 'Total Liabilities and Fund Balances';
RUN;

*/DRG Amounts Other Than Outlier Payments/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "DRG Amounts Other Than Outlier P"n = drg_outpayments;
	LABEL drg_outpayments = 'DRG Amounts Other Than Outlier Payments';
RUN;

*/Outlier Payments For Discharges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Outlier Payments For Discharges"n = outpayments_disc;
	LABEL outpayments_disc = 'Outlier Payments For Discharges';
RUN;

*/Inpatient Revenue/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Inpatient Revenue"n = inpatient_revenue;
	LABEL inpatient_revenue = 'Inpatient Revenue';
RUN;

*/Outpatient Revenue/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Outpatient Revenue"n = outpatient_revenue;
	LABEL outpatient_revenue = 'Outpatient Revenue';
RUN;

*/Total Patient Revenue/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Patient Revenue"n = total_patient_revenue;
	LABEL total_patient_revenue = 'Total Patient Revenue';
RUN;

*/Less Contractual Allowance and Discounts on Patients' Accounts/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Less Contractual Allowance and D"n = con_allodisc_pata;
	LABEL con_allodisc_pata = 'Less Contractual Allowance and Discounts on Patients Accounts';
RUN;

*/Net Patient Revenue/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Net Patient Revenue"n = net_patient_revenue;
	LABEL net_patient_revenue = 'Net Patient Revenue';
RUN;

*/Less Total Operating Expense/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Net Income from Service to Patie"n = netincome_ser_pat;
	LABEL netincome_ser_pat = 'Net Income from Service to Patients';
RUN;

*/Total Other Income/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Other Income"n = to_income;
	LABEL to_income = 'Total Other Income';
RUN;

*/Total Income/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Income"n = total_income;
	LABEL total_income = 'Total Income';
RUN;

*/Total Other Expenses/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Other Expenses"n = to_expenses;
	LABEL to_expenses = 'Total Other Expenses';
RUN;

*/Net Income/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Net Income"n = netincome;
	LABEL netincome = 'Net Income';
RUN;

*/Cost To Charge Ratio/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Cost To Charge Ratio"n = cost_chargeratio;
	LABEL cost_chargeratio = 'Cost To Charge Ratio';
RUN;

*/Net Revenue from Medicaid/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Net Revenue from Medicaid"n = netreve_medicaid;
	LABEL netreve_medicaid = 'Net Revenue from Medicaid';
RUN;

*/Medicaid Charges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Medicaid Charges"n = medicaid_charges;
	LABEL medicaid_charges = 'Medicaid Charges';
RUN;

*/Net Revenue from Stand-Alone CHIP/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Net Revenue from Stand-Alone CHI"n = netreve_sachi;
	LABEL netreve_sachi = 'Net Revenue from Stand-Alone CHIP';
RUN;

*/Stand-Alone CHIP Charges/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Stand-Alone CHIP Charges"n = sachip_charges;
	LABEL sachip_charges = 'Stand-Alone CHIP Charges';
RUN;

*/Wage-Related Costs (Core)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Wage-Related Costs (Core)"n = wrcost_core;
	LABEL wrcost_core = 'Wage-Related Costs (Core)';
RUN;

*/Total Salaries (adjusted)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Salaries (adjusted)"n = total_salaries_adjusted;
	LABEL total_salaries_adjusted = 'Total Salaries (adjusted)';
RUN;

*/Contract Labor: Direct Patient Care/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Contract Labor: Direct Patient C"n = cl_dpc;
	LABEL cl_dpc = 'Contract Labor: Direct Patient Care';
RUN;

*/Temporary Investments/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Temporary Investments"n = temporary_investments;
	LABEL temporary_investments = 'Temporary Investments';
RUN;

*/Notes Receivable/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Notes Receivable"n = notes_receivable;
	LABEL notes_receivable = 'Notes Receivable';
RUN;

*/Unsecured Loans/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Unsecured Loans"n = unsecured_loans;
	LABEL unsecured_loans = 'Unsecured Loans';
RUN;

*/DRG Amounts Before October 1/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "DRG Amounts Before October 1"n = drg_befoct1;
	LABEL drg_befoct1 = 'DRG Amounts Before October 1';
RUN;

*/DRG Amounts After October 1/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "DRG Amounts After October 1"n = drg_afteroct1;
	LABEL drg_afteroct1 = 'DRG Amounts After October 1';
RUN;

*/Disproportionate Share Adjustment/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Disproportionate Share Adjustmen"n = disp_shareadjust;
	LABEL disp_shareadjust = 'Disproportionate Share Adjustment';
RUN;

*/Allowable DSH Percentage/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Allowable DSH Percentage"n = adsh_percent;
	LABEL adsh_percent = 'Allowable DSH Percentage';
RUN;

*/Managed Care Simulated Payments/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Managed Care Simulated Payments"n = mcsp;
	LABEL mcsp = 'Managed Care Simulated Payments';
RUN;

*/Number of Interns and Residents (FTE)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Number of Interns and Residents"n = fte_internresnum;
	LABEL fte_internresnum = 'Number of Interns and Residents (FTE)';
RUN;

*/Total Days Title V/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Days Title V"n = days_v;
	LABEL days_v = 'Total Days Title V';
RUN;

*/Total Discharges Title V/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total Discharges Title V"n = discharges_v;
	LABEL discharges_v = 'Total Discharges Title V';
RUN;

*/Hospital Total Days Title V For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Hospital Total Days Title V For"n = hosdays_v;
	LABEL hosdays_v = 'Hospital Total Days Title V For Adults & Peds';
RUN;

*/Wage-Related Cost (RHC/FQHC)/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Wage-Related Costs (RHC/FQHC)"n = wrcost_rhcfqhc;
	LABEL wrcost_rhcfqhc = 'Wage-Related Costs (RHC/FQHC)';
RUN;

*/Wage Related Costs for Part - A Teaching Physicians/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Wage Related Costs for Part - A"n = wrcost_atp;
	LABEL wrcost_atp = 'Wage Related Costs for Part - A Teaching Physicians';
RUN;

*/Total IME Payment/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "Total IME Payment"n = totalime_payment;
	LABEL totalime_payment = 'Total IME Payment';
RUN;

*/Hospital Total Discharges Title V For Adults & Peds/;
DATA hoscost.cost;
	SET hoscost.cost;
	RENAME "V Hospital Total Discharges Titl"n = v_hosdischarge;
	LABEL v_hosdischarge = 'Hospital Total Discharges Title V For Adults & Peds';
RUN;

*/Okay, I know that I got things more complicated than it should be, you know, each DATA statement can
have multiple RENAME and LABEL statements./;

*/Let me check if there are duplicated variables/;
PROC FREQ DATA=hoscost.cost;
    TABLES discharges_v v_hosdischarge;
RUN; */discharges_v and v_hosdischarge are duplicated, delete v_hosdischarge./;

PROC FREQ DATA=hoscost.cost;
    TABLES discharges_xix xix_hos_discharge;
RUN; */discharges_xix and xix_hosdischarge are duplicated, delete xix_hosdischarge./;

PROC FREQ DATA=hoscost.cost;
    TABLES discharges_xviii xviii_hos_discharge;
RUN; */discharges_xviii and xviii_hosdischarge are duplicated, delete xviii_hosdischarge./;

DATA hoscost.cost;
	SET hoscost.cost;
	DROP v_hosdischarge xix_hos_discharge xviii_hos_discharge;
RUN; */discharges_xix and xix_hosdischarge are duplicated, delete xviii_hosdischarge./;