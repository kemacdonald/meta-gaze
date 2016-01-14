library(ggplot2)
library(langcog)
library(ggrepel)

df <- read.csv("~/Desktop/gaze_following_meta_analysis.csv", stringsAsFactors = F)

binomial_smooth <- function(...) {
    geom_smooth(method = "glm", method.args = list(family = "binomial"), ...)
}

ggplot(aes(x = mean_age_1, y = x_1), data = df) +
    geom_point(aes(size = n_1, color = cue_type)) +
    scale_color_solarized() +
    binomial_smooth() +
    theme_bw()


ggplot(aes(x = mean_age_1, y = m_rt_seconds), data = df) +
    geom_point(aes(size = n_1, color = cue_type)) +
    scale_color_solarized() +
    geom_text_repel(aes(label = unique_ID), force = 20) +
    geom_smooth(method = "loess") +
    theme_bw()
