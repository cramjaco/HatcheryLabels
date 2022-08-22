library(tidyverse)
library(stringr)

  TubeTagString <- "HatchPLarv 2022 \n Cram # XXXX \n dna/rna shield"
  
  Numbers <- seq(from = 542, by = 1, length.out = 17*7) %>%
    str_pad(width = 4, side = "left", pad = "0")
  
  TubeTagVec <- str_replace(TubeTagString, "XXXX", Numbers)
  
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
  
  write.table(TubeTagMtx, "TubeTags.csv", sep = ",", row.names = FALSE, col.names = FALSE)
  write.table(LabelSheetMtx, "Labels.csv", sep = ",", row.names = FALSE, col.names = FALSE)
