library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/DRA_ECHO_Haiti")
data <- read_excel("data.xlsx")


selectedKeyVars <- c('Commune', 'Sexe_du_chef_de_menage',
                     'Age_du_chef_de_menage',
                     'Statut_matrimonial',
                         'Nombre_de_femmes_enceintes_dans_le_menage',
                     'Nombre_de_femmes_allaitantes_dans_le_menage')



#Convert variables into factors
cols =  c('Localite', 'Sexe_du_chef_de_menage',
          'Age_du_chef_de_menage',
          'Statut_matrimonial',
          'La_personne_entretenue_est_le_chef_de_menage',
          'Si_le_chef_de_menage_nest_pas_present_a_lentretien',
          'Nombre_de_femmes_enceintes_dans_le_menage',
          'Nombre_de_femmes_allaitantes_dans_le_menage')
data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)

#Assess the disclosure risk
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars)

#Report + risk prior to SDC
print(objSDC, 'risk')
report(objSDC, filename = "index",internal = T) 

