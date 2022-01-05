# Table 2: Table 2. Overview of report characteristics

#Hannah had laid out a table shell for this so had originally tried to make a
#table 2 but then converted to using the table shell she provided and doing things manually

# Author: Chris LeBoa
# Version: 2021-11-11

vars_interest <- data_presence_clean %>% select(-Author) %>% names()  #Select the variables I want to pull

data_presence_clean %>% ## Looks variables that are only related to trauma
  summarise_if(is.numeric, sum, na.rm = TRUE) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "Number Reporting") %>%
  filter(str_detect(Variable, "if trauma") == TRUE)



data_percent <-
  data_presence_clean %>%
  summarise_if(is.numeric, sum, na.rm = TRUE) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "Number Reporting") %>% #make column
  mutate(
    "Percent Reporting" =
      case_when(
        str_detect(Variable, "if trauma") == TRUE ~ round(`Number Reporting` / 29 * 100, 1),
        str_detect(Variable, "if trauma") == FALSE ~ round(`Number Reporting` / 50 * 100, 1),
        )
    )

data_percent %>%
  write_csv(t2_output_location)

# Study setting
data_all %>%
  count(`Study Setting`)

# Facility Type
data_all$`Facility Type`
data_all %>%
  mutate(
    facility_type = case_when(
    str_detect(`Facility Type`,  "multiple|/|," )~ "multiple",
    str_detect(`Facility Type`,  "Public|public") ~ "public",
    str_detect(`Facility Type`,  "NGO") ~ "NGO",
    str_detect(`Facility Type`,  "Military") ~ "military",
    TRUE ~  "Other"
  )) %>%
  count(facility_type)

#Type of surgical conditions

data_all %>%
  mutate(
    surg = `Type of surgical conditions included`,
    surgery = case_when(
      str_detect(surg, "all|All") ~ "All",
      str_detect(surg,"^trauma$") ~  "Trauma",
      str_detect(surg, "trauma and ") ~ "Trauma and non-trauma",
      str_detect(surg, "cardiac surgery only") ~ "cardiac",
      str_detect(surg, "colorectal surgery only") ~ "colorectal",
      TRUE ~  "Other"
    )) %>%
  count(surgery)

#Pediatric population
data_all %>%
  mutate(ped = if_else(str_detect(`Adult/Peds`, "ped") == TRUE, 1, 0)) %>%
  count(ped)

#Obstetrics included
data_all %>%
  count(`Includes OB`)

#Mortality any
data_presence_clean %>%
  mutate(mortality =
           if_else(
             !is.na(
               `Mortality (unspecifed)`|
                 `In-hospital mortality`|
                 `30-day mortality`|
                 `O:E mortality ratio`
             ), 1, 0 )) %>%
  count(mortality)



#30 Day mortality
data_presence_clean %>%
  mutate(mortality =
           if_else(
             !is.na(
               `30-day mortality`
             ), 1, 0 )) %>%
  count(mortality)

#in hospital mortality
data_presence_clean %>%
  mutate(mortality =
           if_else(
             !is.na(
               `In-hospital mortality`
               # `30-day mortality`|
               # `O:E mortality ratio`
             ), 1, 0 )) %>%
  count(mortality)

#Functional Status
data_presence_clean %>%
  mutate(fs =
           if_else(
             !is.na(
               `Functional Status`
             ), 1, 0 )) %>%
  count(fs)







