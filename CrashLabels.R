library(tidyverse)
library(stringr)

Experiment <- "HPLOH-UV"
Scientist <- "JAC"
SampleTypes <- c("Larvae", "Microscopy", "GF8", "Durapore")
Days <- c(0, 1, 2, 3)
Treatments <- c("Ctrl", "UV")
StartDate <- as.Date("2021/07/12")
Dates <- StartDate + Days
Replicates <- c("A", "B", "C")

ProtoDf <- expand.grid(SampleType = SampleTypes, Day = Days, Treatment = Treatments, Replicate = Replicates) %>%
  arrange(SampleType, Day, Treatment, Replicate) %>% 
  filter(!(Day == 0 & Replicate != "A")) %>%
  left_join(tibble(Days, Dates), by = c("Day" = "Days"))

ProtoDf <- ProtoDf %>% 
  mutate(label = paste(Experiment, paste("Day", Day, sep = " "),Treatment, paste("Rep", Replicate, sep = " "), Scientist, sep = "\n"))

SheetRows <- 17
SheetCols <- 7

TubeTagVec <- rep("", SheetRows * SheetCols)

TubeTagVec[1:nrow(ProtoDf)] <- ProtoDf$label
  
TubeTagMtx <- matrix(TubeTagVec, nrow = 17, ncol = 7)

LabCols = 14
LabRows = 33
  
LabelSheetMtx <- matrix("", nrow = LabRows, ncol = LabCols)
  
iter = 1
for(j in 1:LabCols){
  if(j %% 2 == 1){
    for(i in 1:LabRows){
      if(i %% 2 == 1){
        LabelSheetMtx[i,j] <- TubeTagVec[iter]
        iter = iter + 1
      }
    }
  }
}

