library(tidyverse)
library(jsonlite)

setwd("C:/Users/marin/OneDrive/Área de Trabalho/ESTUDOS GITHUB/Analise-de-Dados_SUS/Modulo_1")
df_csv <- read_csv("sim_salvador_2023_processado.csv")

# Atividade 2: Manipulação de Datas e Agrupamento
# 2.1 Crie uma variável chamada "trimestre" que identifique em qual trimestre do ano ocorreu o óbito. Os trimestres devem ser classificados como: "1º Trimestre" para janeiro, fevereiro e março; "2º Trimestre" para abril, maio e junho; "3º Trimestre" para julho, agosto e setembro; e "4º Trimestre" para outubro, novembro e dezembro. Dica: use a função month() para extrair o mês da data e case_when() para classificar em trimestres. # nolint

df_csv <- df_csv %>%
    mutate(
        mes_obito = month(DTOBITO_dt),

        trimestre = case_when(
        mes_obito %in% 1:3   ~ "1º Trimestre",
        mes_obito %in% 4:6   ~ "2º Trimestre",
        mes_obito %in% 7:9   ~ "3º Trimestre",
        mes_obito %in% 10:12  ~ "4º Trimestre"
        )
    )

# 2.2 Calcule o total de óbitos e a idade média por trimestre e por sexo. Dica: utilize group_by() com duas variáveis (trimestre e sexo_p) e depois summarise() para calcular as estatísticas. # nolint

df_csv <- df_csv %>%
    group_by(sexo_p, trimestre) %>%

    summarise(
        quantidade_de_obitos = n(),
        idade_media = mean(idade_anos, na.rm = TRUE),
        .groups = "drop"
    ) %>%

    arrange(trimestre, sexo_p)

view(df_csv)
