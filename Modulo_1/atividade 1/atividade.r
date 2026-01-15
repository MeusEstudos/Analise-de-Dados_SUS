library(tidyverse)
library(jsonlite)

setwd("C:/Users/marin/OneDrive/Área de Trabalho/ESTUDOS GITHUB/Analise-de-Dados_SUS/Modulo_1")
faixa_etaria <- read_csv("sim_salvador_2023_processado.csv")

# Atividade 1: Exploração e Transformação de Dados

# 1.1 Crie uma nova variável chamada "faixa_etaria" que classifique as idades em quatro categorias:

# "Criança" para idades de 0 a 12 anos, "Adolescente" para 13 a 17 anos, "Adulto" para 18 a 59 anos e "Idoso" para 60 anos ou mais.

faixa_etaria <- faixa_etaria %>%
  mutate(
    categoria_idade = case_when(
      idade_anos <= 12 ~ "Criança",
      idade_anos >= 13 & idade_anos <= 17 ~ "Adolescente",
      idade_anos >= 18 & idade_anos <= 59 ~ "Adulto",
      idade_anos >= 60 ~ "Idoso",
      TRUE ~ NA_character_ 
    )
  )

# 1.2 Conte quantos óbitos há em cada faixa etária criada. Dica: você pode usar a função count() ou combinar group_by) com summarise().

faixa_etaria <- faixa_etaria %>%
  add_count(DTOBITO, name = "contagem_de_obitos")

glimpse(faixa_etaria)

View(faixa_etaria)