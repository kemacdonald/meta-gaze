library(ggplot2)
library(dplyr)
library(langcog)
library(ggrepel)
library(stringr)

# read data
df_meta <- read.csv("../data/gaze_following_MA.csv", 
                    stringsAsFactors = F)

df_meta <- df_meta %>% mutate(cue_type_split = ifelse(str_detect(cue_type, "pointing"), "pointing", "looking"))

binomial_smooth <- function(...) {
    geom_smooth(method = "glm", method.args = list(family = "binomial"), ...)
}


ggplot(aes(x = mean_age_1, y = x_1), 
       data = filter(df_meta, str_detect(unique_ID, "gredeback") != T), num_AFC == "2AFC") + 
    geom_point(aes(size = n_1, color = cue_type_split)) +
    scale_color_solarized() +
    geom_smooth(aes(weight = 1/SD_1^2, col = cue_type_split),
                method = "glm", method.args = list(family = "binomial")) +
    geom_text_repel(aes(label = unique_ID), force = 20) +
    theme_bw()


ggplot(aes(x = mean_age_1, y = m_rt_seconds), data = df_meta) +
    geom_point(aes(size = n_1, color = cue_type)) +
    scale_color_solarized() +
    geom_text_repel(aes(label = unique_ID), force = 20) +
    geom_smooth(method = "loess") +
    theme_bw()
