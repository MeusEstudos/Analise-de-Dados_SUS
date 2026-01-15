library(tidyverse)
library(jsonlite)

setwd("C:/Users/marin/OneDrive/Área de Trabalho/ESTUDOS GITHUB/Analise-de-Dados_SUS/Modulo_1")
df_csv <- read_csv("sim_salvador_2023_processado.csv")

# Atividade 3: Análise Integrada
# 3.1 Identifique qual foi o mês com maior número de óbitos no ano de 2023.

df_total <- df_csv %>%
  mutate(mes_obito = month(DTOBITO_dt, label = TRUE)) %>% 

  group_by(mes_obito) %>% 

  summarise(total_obitos = n()) %>% 

  filter(total_obitos == max(total_obitos))


# 3.2 Calcule a diferença percentual entre o número de óbitos masculinos e femininos.

df_percentual <- df_csv %>%
  mutate(mes_obito = month(DTOBITO_dt, label = TRUE)) %>% 

  group_by(sexo_p, mes_obito) %>% 
  
  summarise(total_obitos = n(), .groups = "drop") %>% 


  group_by(sexo_p) %>% 
  summarise (
    maior_valor = max(total_obitos),
    menor_valor = min(total_obitos),
    .groups = "drop"
  ) %>% 


  mutate(
    dif_percentual = ((maior_valor - menor_valor) / menor_valor) * 100
  ) %>% 

  arrange(dif_percentual, sexo_p)



# 3.3 Determine qual faixa etária teve o maior número de óbitos ao longo do ano

df_faixa <- df_csv %>%
  mutate(
    faixa_etaria = case_when(
      idade_anos <= 14 ~ "0-14 anos",
      idade_anos <= 29 ~ "15-29 anos",
      idade_anos <= 59 ~ "30-59 anos",
      idade_anos >= 60 ~ "60 anos ou mais"
    )
  )%>%

  group_by(faixa_etaria) %>%

  summarise(total_obitos = n()) %>%

  arrange(desc(total_obitos)) %>%

  filter(total_obitos == max(total_obitos))

view(df_faixa)