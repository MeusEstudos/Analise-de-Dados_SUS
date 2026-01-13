library(tidyverse)
library(jsonlite)

# 1. Configurar diretório e carregar dados
setwd("C:/Users/marin/OneDrive/Área de Trabalho/ESTUDOS GITHUB/Analise-de-Dados_SUS/Modulo_1")
faixa_etaria <- read_csv("sim_salvador_2023_processado.csv")

# 2. Entrada do usuário
# Usamos o as.numeric ou as.integer para garantir que o R entenda como número
entrada <- readline(prompt = "Digite sua idade para conferir a categoria: ")
idade_usuario <- as.integer(entrada)

# 3. Lógica para dar a resposta imediata ao usuário
# Usamos case_when fora do mutate para avaliar apenas uma variável
categoria_resultado <- case_when(
  idade_usuario <= 12 ~ "Criança",
  idade_usuario >= 13 & idade_usuario <= 17 ~ "Adolescente",
  idade_usuario >= 18 & idade_usuario <= 59 ~ "Adulto",
  idade_usuario >= 60 ~ "Idoso",
  TRUE ~ "Idade inválida ou não informada"
)

# 4. Saída personalizada no console
cat("\n--- RESULTADO DA BUSCA ---\n")
cat("A idade", idade_usuario, "pertence à categoria:", categoria_resultado, "\n")
cat("--------------------------\n\n")

# 5. Aplicar a mesma lógica em todo o dataframe (coluna nova)
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

# Visualizar o resumo da tabela
# glimpse(faixa_etaria)