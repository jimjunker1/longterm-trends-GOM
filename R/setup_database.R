ldwf_csv1 <-read_csv(
  "C:/Users/jj0895/Desktop/temp/LDWF Project 1 Biological Data_050319.csv"
  ) %>% rename_with(str_to_lower)

ldwf_csv2 <- read_csv(
  "C:/Users/jj0895/Desktop/temp/LDWF Project 1 Biological Data_050319.csv"
  ) %>% 
  rename_with(str_to_lower) %>% 
  select(names(ldwf_csv1)) 
  
ldwf_full = ldwf_csv1 %>% 
    bind_rows(ldwf_csv2) %>%
  write_parquet(sink = "C:/Users/jj0895/Desktop/temp/LDWFfull.parquet")
  
# read in parquet for test
ldwf_full = open_dataset(
  sources = "C:/Users/jj0895/Desktop/temp/LDWFfull.parquet",
  format = "parquet"
)

x = ldwf_full %>% 
  group_by(station, year, gear_obs) %>% 
  summarise(samples = n()) %>% 
  collect()

## set up GCS bucket


