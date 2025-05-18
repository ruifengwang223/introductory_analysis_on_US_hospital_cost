# Import necessary library
library(dplyr)
library(ggplot2)
library(haven)
library(tidyr)
library(scales)
library(fixest)

# Import the processed dataset
data <- read_sas("D:\\Data Science\\Healthcare Data Analyst\\Hospital Provider Cost Report\\Coding and Data Files\\cost.sas7bdat")

## Geographical Analysis
state_table <- data %>%
  group_by(state_code) %>%
  summarise(state_total_cost = sum(total_cost, na.rm=TRUE)) %>%
  arrange(desc(state_total_cost))

state_table_year <- data %>%
  group_by(state_code, YEAR) %>%
  summarise(state_total_cost = sum(total_cost, na.rm=TRUE)) %>%
  pivot_wider(names_from = YEAR, values_from = state_total_cost)

# Visualization
# Define a reusable plotting function
plot_trend <- function(data, Var_category, Var_title, Var_x, Var_y) {
  
  table_long <- data %>%
    pivot_longer(cols = `2017`:`2022`, 
                 names_to = Var_x, 
                 values_to = Var_y)
  
  ggplot(table_long, aes(x = as.numeric(.data[[Var_x]]), 
                         y = .data[[Var_y]], 
                         color = .data[[Var_category]])) +
    geom_line() +
    geom_point(size = 2) +
    labs(title = paste(Var_title, "- Trend of Total Hospital Per Capita Cost (2017 - 2022)"),
         x = Var_x,
         y = Var_y,
         color = Var_category) +
    theme_minimal() +
    theme(legend.position = "right",
          axis.text.x = element_text(angle = 45, hjust = 1))
}

plot_trend(data = state_table_year, 
           Var_category = "state_code", 
           Var_title = "All States", 
           Var_x = "YEAR", 
           Var_y = "Total Cost")

# Too many states...I decided to group all states into six parts (five regions and overseas territories.)

state_list <- data %>% distinct(state_code)

install.packages('readxl')
library(readxl)

state_region <- read_excel("D:\\Data Science\\Healthcare Data Analyst\\Hospital Provider Cost Report\\Introduction to Variables and External Dataset\\Variables_list.xlsm", sheet="Region_States")

data <- data %>%
  left_join(state_region, by='state_code')

# Geographical Analysis based on regions and divisions
region_table_year <- data %>%
  group_by(region, YEAR) %>%
  summarise(region_total_cost = sum(total_cost, na.rm=TRUE)) %>%
  pivot_wider(names_from = YEAR, values_from = region_total_cost)

plot_trend(data = region_table_year, 
           Var_category = "region", 
           Var_title = "All Regions", 
           Var_x = "YEAR", 
           Var_y = "Total Cost")

division_table_year <- data %>%
  group_by(division, YEAR) %>%
  summarise(division_total_cost = sum(total_cost, na.rm=TRUE)) %>%
  pivot_wider(names_from = YEAR, values_from = division_total_cost)

plot_trend(data = division_table_year, 
           Var_category = "division", 
           Var_title = "All Divisions", 
           Var_x = "YEAR", 
           Var_y = "Total Cost")

# Okay, I also find that it is not rigorous, let me import census data.
pp_ref17_19 <- read_excel("D:\\Data Science\\Healthcare Data Analyst\\Hospital Provider Cost Report\\Introduction to Variables and External Dataset\\nst-est2019-01.xlsx", sheet="Population_Source")
pp_ref20_24 <- read_excel("D:\\Data Science\\Healthcare Data Analyst\\Hospital Provider Cost Report\\Introduction to Variables and External Dataset\\NST-EST2024-POP.xlsx", sheet="Population_Source")

pp_ref <- pp_ref17_19 %>%
  full_join(pp_ref20_24,by='state_name')

pp_ref <- state_region %>%
  left_join(pp_ref, by='state_name')

# Fill the NA in particular states
pp_ref <- pp_ref %>%
  mutate(
    est_population2017 = case_when(
      state_code == 'DC' ~ 697079,
      state_code == 'AS' ~ 49463,
      state_code == 'GU' ~ 168801,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2017
    ),
    est_population2018 = case_when(
      state_code == 'DC' ~ 704147,
      state_code == 'AS' ~ 48424,
      state_code == 'GU' ~ 168801,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2018
    ),
    est_population2019 = case_when(
      state_code == 'DC' ~ 708253,
      state_code == 'AS' ~ 47321,
      state_code == 'GU' ~ 168801,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2019
    ),
    est_population2020 = case_when(
      state_code == 'DC' ~ 670868,
      state_code == 'AS' ~ 46189,
      state_code == 'GU' ~ 169231,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2020
    ),
    est_population2021 = case_when(
      state_code == 'DC' ~ 668791,
      state_code == 'AS' ~ 45035,
      state_code == 'GU' ~ 170534,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2021
    ),
    est_population2022 = case_when(
      state_code == 'DC' ~ 671803,
      state_code == 'AS' ~ 44273,
      state_code == 'GU' ~ 171774,
      state_code == 'MP' ~ 47329,
      state_code == 'VI' ~ 87146,
      TRUE ~ est_population2022
    )
  )

## Source of population data:
# 1.https://www.census.gov/
# 2.https://usafacts.org/data/topics/people-society/population-and-demographics/our-changing-population/state/
# 3.https://globalstatcompare.com/country/ASM
# 4.https://www.macrotrends.net/global-metrics/countries/GUM/guam/population
# 5.https://en.wikipedia.org/wiki/Demographics_of_the_United_States_Virgin_Islands
#----------------------
# Calculate the total cost per capita by year on each state
state_tcpc <- state_table_year %>%
  left_join(pp_ref, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
         ) %>%
  select(state_code, state_name, region, division, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

region_ppref <- pp_ref %>%
  group_by(region) %>%
  summarise(
    est_population2017 = sum(est_population2017),
    est_population2018 = sum(est_population2018),
    est_population2019 = sum(est_population2019),
    est_population2020 = sum(est_population2020),
    est_population2021 = sum(est_population2021),
    est_population2022 = sum(est_population2022),
    )

region_tcpc <- region_table_year %>%
  left_join(region_ppref, by='region') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(region, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)
  
# Calculate the total cost per capita by year on each division
division_ppref <- pp_ref %>%
  group_by(division) %>%
  summarise(
    est_population2017 = sum(est_population2017),
    est_population2018 = sum(est_population2018),
    est_population2019 = sum(est_population2019),
    est_population2020 = sum(est_population2020),
    est_population2021 = sum(est_population2021),
    est_population2022 = sum(est_population2022),
  )

division_tcpc <- division_table_year %>%
  left_join(division_ppref, by='division') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(division, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

# Then let me update the visualization to output the hospital cost per capita.
plot_trend(data = region_tcpc, 
           Var_category = "region", 
           Var_title = "All Regions", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

plot_trend(data = division_tcpc, 
           Var_category = "division", 
           Var_title = "All Divisions", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

### Visualize state data by each region and divisions.
## Region
w_ppref <- pp_ref %>%
  filter(region=='West')
  
mw_ppref <- pp_ref %>%
  filter(region=='Midwest')

ne_ppref <- pp_ref %>%
  filter(region=='Northeast')

s_ppref <- pp_ref %>%
  filter(region=='South')

nc_ppref <- pp_ref %>%
  filter(region=='Non-contiguous')

# Make new table and visualization
# West
w_tcpc <- w_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = w_tcpc, 
           Var_category = "state_name", 
           Var_title = "West", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Midwest
mw_tcpc <- mw_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = mw_tcpc, 
           Var_category = "state_name", 
           Var_title = "Midwest", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Northeast
ne_tcpc <- ne_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = ne_tcpc, 
           Var_category = "state_name", 
           Var_title = "Northeastern", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# South
s_tcpc <- s_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = s_tcpc, 
           Var_category = "state_name", 
           Var_title = "South", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Non-contiguous
nc_tcpc <- nc_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = nc_tcpc, 
           Var_category = "state_name", 
           Var_title = "Non-contiguous", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

## Division
# East North Central
nec_ppref <- pp_ref %>%
  filter(division=='East North Central')

sec_ppref <- pp_ref %>%
  filter(division=='East South Central')

ma_ppref <- pp_ref %>%
  filter(division=='Mid-Atlantic')

mt_ppref <- pp_ref %>%
  filter(division=='Mountain')

neg_ppref <- pp_ref %>%
  filter(division=='New England')

p_ppref <- pp_ref %>%
  filter(division=='Pacific')

sa_ppref <- pp_ref %>%
  filter(division=='South Atlantic')

wnc_ppref <- pp_ref %>%
  filter(division=='West North Central')

wsc_ppref <- pp_ref %>%
  filter(division=='West South Central')

# Make table and visualization
# East North Central
nec_tcpc <- nec_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = nec_tcpc, 
           Var_category = "state_name", 
           Var_title = "East North Central", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# East South Central
sec_tcpc <- sec_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = sec_tcpc,
           Var_category = "state_name", 
           Var_title = "East South Central", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Mid-Atlantic
ma_tcpc <- ma_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = ma_tcpc,
           Var_category = "state_name", 
           Var_title = "Mid-Atlantic", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Mountain
mt_tcpc <- mt_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = mt_tcpc,
           Var_category = "state_name", 
           Var_title = "Mountain", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# New England
neg_tcpc <- neg_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = neg_tcpc,
           Var_category = "state_name", 
           Var_title = "New England", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# Pacific
p_tcpc <- p_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = p_tcpc,
           Var_category = "state_name", 
           Var_title = "Pacific", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# South Atlantic
sa_tcpc <- sa_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = sa_tcpc,
           Var_category = "state_name", 
           Var_title = "South Atlantic", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# West North Central
wnc_tcpc <- wnc_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = wnc_tcpc,
           Var_category = "state_name", 
           Var_title = "West North Central", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

# West South Central
wsc_tcpc <- wsc_ppref %>%
  left_join(state_table_year, by='state_code') %>%
  mutate(
    `2017` = `2017`/est_population2017,
    `2018` = `2018`/est_population2018,
    `2019` = `2019`/est_population2019,
    `2020` = `2020`/est_population2020,
    `2021` = `2021`/est_population2021,
    `2022` = `2022`/est_population2022
  ) %>%
  select(state_code, state_name, `2017`, `2018`,
         `2019`, `2020`, `2021`, `2022`)

plot_trend(data = wsc_tcpc,
           Var_category = "state_name", 
           Var_title = "West South Central", 
           Var_x = "YEAR", 
           Var_y = "Per Capita Cost")

### Check the Provider Type and Type of Control with states
data %>%
  group_by(provider_type) %>%
  summarise(count = n())

data %>%
  group_by(type_of_control) %>%
  summarise(count = n())

# Since imbalanced distribution in Provider Type, I will try to use Type of Control for analysis.
toc_data <- data %>%
  group_by(state_code,state_name,region,division,type_of_control) %>%
  summarise(count = n(), total_cost = sum(total_cost, na.rm=TRUE))
  
type_of_control <- data.frame(
  type_of_control = 1:13,
  toc_name = c(
    'Voluntary Non‐Profit Church',
    'Voluntary Non‐Profit‐Other',
    'Proprietary Individual',
    'Proprietary‐Corporation',
    'Proprietary Partnership',
    'Proprietary‐Other',
    'Governmental Federal',
    'Governmental‐City‐County',
    'Governmental County',
    'Governmental‐State',
    'Governmental Hospital District',
    'Governmental‐City',
    'Governmental Other')
)

toc_data <- toc_data %>%
  full_join(type_of_control, by='type_of_control')

toc_stper <- toc_data %>%
  left_join(state_table, by='state_code') %>%
  group_by(state_code) %>%
  mutate(percentage = round(total_cost/state_total_cost*100,4)) %>%
  select(state_code,state_name,region,division,toc_name,percentage)

## Visualization on percentage (state x category percentages)
ggplot(toc_stper, aes(x = state_name, y = percentage, fill = toc_name)) +
  geom_col(position = "fill", width = 0.7) +
  scale_y_continuous(labels = percent_format(scale=100)) +
  labs(
    title = "Cost Composition by Type of Control - All States",
    x     = NULL,
    y     = "% of Total Cost",
    fill  = "Control Type"
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position    = "bottom",
    axis.text.y        = element_text(size = 6)
  )

# too crowd... let me use region-only
state_table <- state_table %>%
  left_join(state_region,by='state_code') %>%
  relocate(state_total_cost, .after=last_col())
  
toc_rgper <- toc_data %>%
  left_join(state_table, by=c('state_code','state_name','region','division')) %>%
  group_by(region) %>%
  mutate(percentage = round(total_cost/state_total_cost*100,4)) %>%
  select(region,division,toc_name,percentage)

ggplot(toc_rgper, aes(x = region, y = percentage, fill = toc_name)) +
  geom_col(position = "fill", width = 0.7) +
  scale_y_continuous(labels = percent_format(scale=100)) +
  labs(
    title = "Cost Composition by Type of Control - All States",
    x     = NULL,
    y     = "% of Total Cost",
    fill  = "Control Type"
  ) + 
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position    = "bottom",
    axis.text.y        = element_text(size = 6)
  )

# Group types of control into three groups
data <- data %>%
  mutate(toc_group = case_when(
    type_of_control %in% 1:2 ~ "1 - Voluntary",
    type_of_control %in% 3:6 ~ "2 - Proprietary",
    type_of_control %in% 7:13 ~ "3 - Governmental",
    TRUE ~ "Other"),
        toc_gn = case_when(
    type_of_control %in% 1:2 ~ 1,
    type_of_control %in% 3:6 ~ 2,
    type_of_control %in% 7:13 ~ 3,
    TRUE ~ 4)
)

data %>% count(toc_gn)

toc_data <- data %>%
  group_by(state_code, toc_group, toc_gn) %>%
  summarise(count = n(), total_cost = sum(total_cost, na.rm=TRUE))

toc_data <- toc_data %>%
  left_join(state_region, by='state_code') %>%
  select(state_code,state_name,region,division,everything())

toc_stper <- toc_data %>%
  left_join(state_table, by='state_code') %>%
  mutate(percentage = round(total_cost/state_total_cost*100,4))

toc_rgper <- toc_data %>%
  group_by(region,toc_group,toc_gn) %>%
  summarise(cost = sum(total_cost)) %>%
  mutate(region_total_cost = sum(cost))

# Improve the state_table_year
state_table_year <- data %>%
  group_by(state_code,YEAR) %>%
  summarise(total_cost = sum(total_cost, na.rm=TRUE), .groups="drop")

# As well as control
state_year_control <- data %>%
  group_by(state_code, YEAR, toc_group) %>%
  summarise(
    cost = sum(total_cost, na.rm=TRUE),
    .groups="drop"
  ) %>%
  left_join(state_region, by="state_code")

# Also with state and control only
state_control <- data %>%
  group_by(state_code, toc_group) %>%
  summarise(
    cost = sum(total_cost, na.rm=TRUE),
    .groups="drop"
  ) %>%
  left_join(state_region, by="state_code") %>%
  select(state_code,state_name,region,division,toc_group,cost)

# Analyze region
toc_rgper <- state_control %>%
  group_by(region,toc_group) %>%
  summarise(cost = sum(cost))

toc_rg <- state_control %>%
  group_by(region) %>%
  summarise(total_rg = sum(cost))

toc_rgper <- toc_rgper %>%
  left_join(toc_rg,by='region') %>%
  mutate(percentage = round(cost/total_rg*100,4))

bar_charted <- function(dataset, Var_x, Var_y, Var_fill, Var_title) {
  
  ggplot(dataset, aes(
      x = {{Var_x}}, 
      y = {{Var_y}}, 
      fill = {{Var_fill}}
      )) +
    geom_col(position = "fill", width = 1) +
    geom_text(aes(label=percent({{Var_y}}, accuracy = 0.1, scale = 1)),
        position=position_fill(vjust=0.5), size=5, color="Black") +
    scale_fill_brewer(palette="Blues",direction=1) +
    scale_y_continuous(labels = percent_format(scale=100)) +
    labs(
      title =  Var_title,
      x     = NULL,
      y     = "% of Total Cost",
      fill  = "Type of Control"
    ) + 
    coord_flip() +
    theme_minimal() +
    theme(
      legend.position    = "bottom",
      axis.text.y        = element_text(size = 10, face = "bold"),
      plot.title      = element_text(size = 14, face = "bold")
    )
}

bar_charted(dataset = toc_rgper,
            Var_x = region,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "All Regions - Cost Composition by Type of Control")

# Analyze division
toc_dvs <- state_control %>%
  group_by(division,toc_group) %>%
  summarise(cost = sum(cost))

toc_dv <- state_control %>%
  group_by(division) %>%
  summarise(total_dv = sum(cost))

toc_dvser <- toc_dvs %>%
  left_join(toc_dv, by='division') %>%
  mutate(percentage = round(cost/total_dv*100,4))

bar_charted(dataset = toc_dvser,
            Var_x = division,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "All Divisions - Cost Composition by Type of Control")

# Region
toc_all_states <- state_control %>%
  group_by(state_code,toc_group) %>%
  summarise(cost = sum(cost, na.rm=TRUE)) %>%
  left_join(state_table,by='state_code') %>%
  mutate(percentage=round(cost/state_total_cost*100,4)) %>%
  select(state_code,state_name,region,division,toc_group,cost,state_total_cost,percentage)

toc_west <- toc_all_states %>%
  filter(region=='West')

bar_charted(dataset = toc_west,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "West - Cost Composition by Type of Control")

toc_south <- toc_all_states %>%
  filter(region=='South')

bar_charted(dataset = toc_south,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "South - Cost Composition by Type of Control")

toc_midwest <- toc_all_states %>%
  filter(region=='Midwest')

bar_charted(dataset = toc_midwest,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Midwest - Cost Composition by Type of Control")

toc_northeast <- toc_all_states %>%
  filter(region=='Northeast')

bar_charted(dataset = toc_northeast,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Northeast - Cost Composition by Type of Control")

# Division
toc_nc <- toc_all_states %>%
  filter(division=='Non-contiguous')

bar_charted(dataset = toc_nc,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Non-contiguous - Cost Composition by Type of Control")

toc_esc <- toc_all_states %>%
  filter(division=='East South Central')

bar_charted(dataset = toc_esc,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "East South Central - Cost Composition by Type of Control")

toc_wsc <- toc_all_states %>%
  filter(division=='West South Central')

bar_charted(dataset = toc_wsc,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "West South Central - Cost Composition by Type of Control")

toc_mt <- toc_all_states %>%
  filter(division=='Mountain')

bar_charted(dataset = toc_mt,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Mountain - Cost Composition by Type of Control")

toc_ma <- toc_all_states %>%
  filter(division=='Mid-Atlantic')

bar_charted(dataset = toc_ma,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Mid Atlantic - Cost Composition by Type of Control")

toc_ng <- toc_all_states %>%
  filter(division=='New England')

bar_charted(dataset = toc_ng,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "New England - Cost Composition by Type of Control")

toc_wnc <- toc_all_states %>%
  filter(division=='West North Central')

bar_charted(dataset = toc_wnc,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "West North Central - Cost Composition by Type of Control")

toc_pc <- toc_all_states %>%
  filter(division=='Pacific')

bar_charted(dataset = toc_pc,
            Var_x = state_name,
            Var_y = percentage,
            Var_fill = toc_group,
            Var_title = "Pacific - Cost Composition by Type of Control")

# Since we have general insights on trend of total hospital per capita cost,
# and cost composition by type of control. I decided to focus on ND, SD, ME,
# also New England.

# Trend of Control-Type Shares in ND and SD, compared with other states in 
# West North Central:
state_year_ctrl <- data %>%
  group_by(state_code, state_name, YEAR, toc_group) %>%
  summarise(cost = sum(total_cost, na.rm=TRUE), .groups="drop") %>%
  group_by(state_code, state_name, YEAR) %>%
  mutate(share = cost/sum(cost)*100) %>%
  left_join(state_region, by=c('state_code','state_name')) %>%
  select(state_code,state_name,region,division,YEAR,toc_group,cost,share)

df_wnc <- state_year_ctrl %>%
  filter(division=='West North Central')

# Visualization
ggplot(df_wnc, aes(x = YEAR, y = share, color = toc_group)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = 2017:2022) +
  scale_y_continuous(labels = percent_format(accuracy=1,scale=1)) +
  scale_color_brewer(palette = "Set2") +
  facet_wrap(~ state_name) +
  labs(
    title = "Trend of Types of Control - Shares in West North Central (2017–2022)",
    x     = "Year", 
    y     = "% of Total Cost",
    color = "Control Group"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position="bottom")

# Calculate the per capita cost in three types of control
wnc_ppref_long <- wnc_ppref %>%
  select(state_code, starts_with("est_population")) %>%
  pivot_longer(
    cols = starts_with("est_population"),
    names_to = "year",
    names_prefix = "est_population",
    values_to = "population"
  ) %>%
  mutate(YEAR = as.integer(year)) %>%
  select(-year)

pc_ctc_wide <- df_wnc %>%
  left_join(wnc_ppref_long, by = c("state_code","YEAR")) %>%
  mutate(
    pc_cost = cost / population
  ) %>%
  select(state_code, state_name, region, division, toc_group, YEAR, pc_cost) %>%
  pivot_wider(
    names_from   = YEAR,
    values_from  = pc_cost
  )


## Input Cost-to-Charge-Ratio
ccr_gpdata <- data %>%
  group_by(state_code,state_name,region,division,YEAR,toc_group) %>%
  summarise(cost_chargeratio = round(mean(cost_chargeratio,na.rm=TRUE),3))

ccr_gp_toc <- ccr_gpdata %>%
  group_by(YEAR, toc_group) %>%
  summarise(cost_chargeratio = mean(cost_chargeratio,na.rm=TRUE))

ccr_gpdata_pp21 <- ccr_gpdata %>%
  filter(YEAR==2021)

# The value of Proprietary in TX, 2021 is 18973.61, which maybe outlier, let me 
# check carefully.

tx2021pro <- data %>%
  filter(state_code=='TX',YEAR==2021,toc_gn==2) %>%
  select(rpt_rec_num,state_code,state_name,type_of_control,toc_group,total_cost,
         total_income,cost_chargeratio) %>%
  mutate(cost_chargeratio = round(cost_chargeratio,3))

# I decided to remove this row and report to data provider, let me go ahead.
ccr_gpdata <- data %>%
  filter(!(rpt_rec_num==718918 & YEAR==2021)) %>%
  group_by(state_code,state_name,region,division,YEAR,toc_group) %>%
  summarise(cost_chargeratio = round(mean(cost_chargeratio,na.rm=TRUE),3))
  
ccr_gp_toc <- ccr_gpdata %>%
  group_by(YEAR, toc_group) %>%
  summarise(cost_chargeratio = mean(cost_chargeratio,na.rm=TRUE))

# Check the governmental hospital in 2017,2018,2019,2022 respectively
ccr_gpdata_pp17 <- ccr_gpdata %>%
  filter(YEAR==2017)

ccr_gpdata_pp18 <- ccr_gpdata %>%
  filter(YEAR==2018)

ccr_gpdata_pp19 <- ccr_gpdata %>%
  filter(YEAR==2019)

ccr_gpdata_pp22 <- ccr_gpdata %>%
  filter(YEAR==2022)

# Check North Mariana Island
data_mp <- data %>%
  filter(state_code=='MP')

data_ccr <- data %>%
  filter(!rpt_rec_num==718918)

data_ccr_nmp <- data_ccr %>%
  filter(!state_code=='MP') %>%
  arrange(desc(cost_chargeratio))


# Visualization by box plot
ggplot(data_ccr_nmp, aes(
  x = factor(YEAR), 
  y = cost_chargeratio
)) +
  geom_boxplot(
    outlier.colour = "red", 
    outlier.shape  = 16,
    outlier.size   = 2,
    notch          = TRUE,
    na.rm          = TRUE
  ) +
  geom_jitter(
    width = 0.2, 
    alpha = 0.3, 
    size  = 1, 
    na.rm = TRUE
  ) +
  labs(
    title = "Distribution of Cost-to-Charge-Ratio by Year",
    x     = "Year",
    y     = "Cost-to-Charge Ratio"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title   = element_text(face = "bold", size = 16),
    axis.title.x = element_text(margin = margin(t = 10)),
    axis.title.y = element_text(margin = margin(r = 10))
  )

boxplot(data_ccr_nmp$cost_chargeratio)

outlier <- data %>%
  filter(cost_chargeratio>=10000)

# Let me just check if Cost-to-Charge-Ratio is totally equal to total cost 
# divide the total charge
data_ccr_ad <- data_ccr %>%
  mutate(
    ccr_ad = total_cost/outpatient_inpatient,
    ccr_diff = round(cost_chargeratio - ccr_ad,2))

ccr_diff <- data_ccr_ad %>%
  filter(ccr_diff!=0) %>%
  arrange(desc(ccr_diff))

ggplot(data_ccr_ad, aes(
  x = factor(YEAR), 
  y = ccr_ad
)) +
  geom_boxplot(
    outlier.shape  = 16,
    outlier.size   = 2,
    notch          = TRUE,
    na.rm          = TRUE
  ) +
  geom_jitter(
    width = 0.2, 
    alpha = 0.3, 
    size  = 1, 
    na.rm = TRUE
  ) +
  labs(
    title = "Distribution of Cost-to-Charge-Ratio by Year",
    x     = "Year",
    y     = "Cost-to-Charge Ratio"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title   = element_text(face = "bold", size = 16),
    axis.title.x = element_text(margin = margin(t = 10)),
    axis.title.y = element_text(margin = margin(r = 10))
  )

hist(ccr_diff$ccr_diff)

ccr_st <- data_ccr_ad %>%
  filter(!state_code=='MP') %>%
  group_by(state_code,state_name,region,division,YEAR) %>%
  summarise(ccr = mean(ccr_ad,na.rm=TRUE))

ccr_rg <- data_ccr_ad %>%
  filter(!state_code=='MP') %>%
  group_by(region,YEAR) %>%
  summarise(ccr = mean(ccr_ad,na.rm=TRUE))

plot_trend2 <- function(data, Var_category, Var_title, Var_x, Var_y) {
  
  ggplot(data, aes(x = as.numeric(.data[[Var_x]]), 
                         y = .data[[Var_y]], 
                         color = .data[[Var_category]])) +
    geom_line() +
    geom_point(size = 2) +
    labs(title = paste(Var_title, "- Trend of Cost-to-Charge-Ratio (CCR), 2017 - 2022"),
         x = Var_x,
         y = Var_y,
         color = Var_category) +
    theme_minimal() +
    theme(legend.position = "right",
          axis.text.x = element_text(angle = 45, hjust = 1))
}

plot_trend2(data = ccr_rg,
           Var_category = "region", 
           Var_title = "All Regions no MP", 
           Var_x = "YEAR", 
           Var_y = "ccr")

ccr_dv <- data_ccr_ad %>%
  filter(!state_code=='MP') %>%
  group_by(region,division,YEAR) %>%
  summarise(ccr = mean(ccr_ad,na.rm=TRUE))

plot_trend2(data = ccr_dv,
            Var_category = "division", 
            Var_title = "All Divisions no MP", 
            Var_x = "YEAR", 
            Var_y = "ccr")

# For types of control
ccr_toc <- data_ccr_ad %>%
  filter(!state_code=='MP') %>%
  group_by(toc_group,YEAR) %>%
  summarise(ccr = mean(ccr_ad,na.rm=TRUE))

plot_trend2(data = ccr_toc,
            Var_category = "toc_group", 
            Var_title = "Three Types of Control", 
            Var_x = "YEAR", 
            Var_y = "ccr")

# Calculate the number of each type of control btw:
toc_count <- data %>%
  filter(YEAR==2022) %>%
  count(toc_group)

toc_smcount <- data %>%
  count(type_of_control)

# Okay let me go back for the specific types of control:
ccr_toc2 <- data_ccr_ad %>%
  filter(!state_code=='MP') %>%
  mutate(type_of_control == as.character(type_of_control)) %>%
  group_by(type_of_control,YEAR) %>%
  summarise(ccr = mean(ccr_ad,na.rm=TRUE))

plot_trend2(data = ccr_toc2,
            Var_category = "type_of_control",
            Var_title = "13 Types of Control",
            Var_x = "YEAR",
            Var_y = "ccr")

# Use simple linear regression to predict the CCR
fit_lm <- function(data, response, predictors) {
  rhs <- paste(predictors, collapse = " + ")
  fml <- as.formula(paste(response, "~", rhs))
  model <- lm(fml, data = data)
  print(summary(model))
  return(model)
}

mod1 <- fit_lm(
  data_ccr_ad,
  response = "ccr_ad",
  predictors = c("state_code","type_of_control")
)

data_ccr_nmp <- data_ccr_ad %>%
  filter(!state_code=='MP')

mod2 <- fit_lm(
  data_ccr_nmp,
  response = "ccr_ad",
  predictors = c("state_code","type_of_control")
)

mod3 <- fit_lm(
  data_ccr_nmp,
  response = "ccr_ad",
  predictors = c("state_code","type_of_control","YEAR")
)

data_ccr_nmp %>%
  count(ccn_facility_type)

# Decide to use Rural versus Urban, Provider Type, 
# Type of Control as predictors.
data_lr <- data_ccr_nmp %>%
  select(
    rural_urban,
    ccn_facility_type,
    provider_type,
    type_of_control,
    ccr_ad
    )

# Make dummy variables
# install.packages("fastDummies")
library(fastDummies)

cats <- c("rural_urban","ccn_facility_type","provider_type","type_of_control")

data_lr <- dummy_cols(
    data_lr,
    select_columns        = cats,
    remove_selected_columns = TRUE,    # drop the originals
    remove_first_dummy      = TRUE     # avoid collinearity
  )


mol4 <- fit_lm(
  data_lr,
  response="ccr_ad",
  predictors = setdiff(names(data_lr),"ccr_ad")
)

# Let me input state_code for more details
data_lr2 <- data_ccr_nmp %>%
  select(
    state_code,
    rural_urban,
    ccn_facility_type,
    provider_type,
    type_of_control,
    ccr_ad
  )

cats <- c("state_code","rural_urban","ccn_facility_type",
          "provider_type","type_of_control")

data_lr2 <- dummy_cols(
  data_lr2,
  select_columns        = cats,
  remove_selected_columns = TRUE,    # drop the originals
  remove_first_dummy      = TRUE     # avoid collinearity
)

mol5 <- fit_lm(
  data_lr2,
  response="ccr_ad",
  predictors = setdiff(names(data_lr2),"ccr_ad")
)

# Random Forest
library(randomForest)

cats <- c("type_of_control")

data_rf <- data_ccr_nmp %>%
  filter(!is.na(ccr_ad)) %>%
  select(
    rural_urban,
    ccn_facility_type,
    provider_type,
    type_of_control,
    ccr_ad
  ) %>%
  fastDummies::dummy_cols(
    select_columns         = cats,
    remove_selected_columns= TRUE,
    remove_first_dummy     = TRUE
  )

set.seed(36)

train_idx <- caret::createDataPartition(data_rf$ccr_ad, p=0.8, list=FALSE)
train_df  <- data_rf[ train_idx, ]
test_df   <- data_rf[-train_idx, ]

rf_model <- randomForest(
  ccr_ad ~ ., 
  data      = train_df, 
  ntree     = 500,         # number of trees
  mtry      = floor(sqrt(ncol(train_df)-1)),  # #vars tried at each split
  importance= TRUE,
  na.action = na.omit
)

print(rf_model)

preds <- predict(rf_model, test_df)
caret::postResample(pred = preds, obs = test_df$ccr_ad)

# Let me just predict total cost instead
data_tc <- data %>%
  select(
    rural_urban,
    ccn_facility_type,
    provider_type,
    type_of_control,
    total_cost
  )

cats <- c("rural_urban","ccn_facility_type",
          "provider_type","type_of_control")

data_tc <- data_tc %>%
  fastDummies::dummy_cols(
    select_columns         = cats,
    remove_selected_columns= TRUE,
    remove_first_dummy     = TRUE
  )

mol6 <- fit_lm(
  data_tc,
  response="total_cost",
  predictors = setdiff(names(data_tc),"total_cost")
)
