library(tidyverse)
library(ggplot2)

# ============================================================
# 1. DATA IMPORT
# ============================================================

setwd("~/Downloads/")

dat <- read.csv("spectral_diversity_FAKE_strong_relationships.csv") %>%
  rename(shannon = SHANNON)


# ============================================================
# 2. RESHAPE DATA TO LONG FORMAT
# ============================================================

dat_long <- dat %>%
  pivot_longer(
    cols = matches("^(CV|RAO)_"),
    names_to = c("metric", "band"),
    names_pattern = "(CV|RAO)_(.*)",
    values_to = "spectral_diversity"
  ) %>%
  mutate(
    metric = recode(metric, "RAO" = "Rao"),
    band = factor(
      band,
      levels = c(
        "B2", "B3", "B4", "B5", "B6",
        "B7", "B8", "B8A", "B11", "B12"
      )
    )
  )


# ============================================================
# 3. CALCULATE R-SQUARED AND P-VALUE FOR EACH BAND
# ============================================================

reg_stats <- dat_long %>%
  filter(
    !is.na(spectral_diversity),
    !is.na(shannon)
  ) %>%
  group_by(metric, band) %>%
  group_modify(~ {

    # Fit a linear regression model
    mod <- lm(
      shannon ~ spectral_diversity,
      data = .x
    )

    # Extract model summary
    sm <- summary(mod)

    # Store R-squared and p-value of the slope
    tibble(
      r2 = sm$r.squared,
      p_value = coef(sm)[2, 4]
    )
  }) %>%
  ungroup() %>%
  mutate(

    # Create labels to display in each panel
    label = case_when(
      p_value < 0.001 ~ paste0(
        "R² = ", sprintf("%.2f", r2),
        "\np < 0.001"
      ),
      TRUE ~ paste0(
        "R² = ", sprintf("%.2f", r2),
        "\np = ", sprintf("%.3f", p_value)
      )
    )
  )


# ============================================================
# 4. FUNCTION TO CREATE THE PLOT
# ============================================================

super_plot <- function(data, stats, metrica) {

  # Select data for the chosen spectral diversity metric
  dati_plot <- data %>%
    filter(metric == metrica)

  # Select regression statistics for the chosen metric
  stats_plot <- stats %>%
    filter(metric == metrica)

  ggplot(
    dati_plot,
    aes(
      x = spectral_diversity,
      y = shannon
    )
  ) +

    # Add observed data points
    geom_point(
      size = 3,
      alpha = 0.70,
      shape = 21,
      fill = "#18A999",
      colour = "white",
      stroke = 0.5
    ) +

    # Add linear regression and 95% confidence interval
    geom_smooth(
      method = "lm",
      formula = y ~ x,
      se = TRUE,
      linewidth = 1.2,
      colour = "#E63946",
      fill = "#E63946",
      alpha = 0.15
    ) +

    # Add R-squared and p-value to each panel
    geom_text(
      data = stats_plot,
      aes(
        x = -Inf,
        y = Inf,
        label = label
      ),
      inherit.aes = FALSE,
      hjust = -0.12,
      vjust = 1.2,
      size = 3.6,
      fontface = "bold"
    ) +

    # Create one panel for each Sentinel-2 band
    facet_wrap(
      ~band,
      scales = "free_x",
      ncol = 5
    ) +

    # Axis labels, title, and subtitle
    labs(
      x = paste0(metrica, " spectral diversity"),
      y = "Shannon diversity",
      title = "Spectral diversity vs. Shannon diversity",
      subtitle = paste0(
        metrica,
        " across Sentinel-2 spectral bands"
      )
    ) +

    # Apply a clean graphical theme
    theme_minimal(base_size = 13) +

    theme(

      # Remove minor grid lines
      panel.grid.minor = element_blank(),

      # Customize major grid lines
      panel.grid.major = element_line(
        colour = "grey90",
        linewidth = 0.3
      ),

      # Customize facet headers
      strip.background = element_rect(
        fill = "grey15",
        colour = NA
      ),

      strip.text = element_text(
        colour = "white",
        face = "bold",
        size = 11
      ),

      # Customize plot title
      plot.title = element_text(
        face = "bold",
        size = 18
      ),

      # Customize plot subtitle
      plot.subtitle = element_text(
        colour = "grey35",
        size = 11
      ),

      # Customize axis titles
      axis.title = element_text(
        face = "bold"
      ),

      # Customize axis labels
      axis.text = element_text(
        colour = "grey20"
      ),

      # Increase spacing between panels
      panel.spacing = unit(1, "lines"),

      # Set plot margins
      plot.margin = margin(
        15, 15, 15, 15
      )
    )
}


# ============================================================
# 5. CREATE THE CV PLOT
# ============================================================

p_CV <- super_plot(
  dat_long,
  reg_stats,
  "CV"
)

p_CV


# ============================================================
# 6. CREATE THE RAO PLOT
# ============================================================

p_Rao <- super_plot(
  dat_long,
  reg_stats,
  "Rao"
)

p_Rao


# ============================================================
# 7. SAVE THE FIGURES
# ============================================================

# Save the CV figure as a high-resolution PNG
ggsave(
  "Shannon_CV_bands.png",
  p_CV,
  width = 14,
  height = 7,
  dpi = 600,
  bg = "white"
)

# Save the Rao figure as a high-resolution PNG
ggsave(
  "Shannon_Rao_bands.png",
  p_Rao,
  width = 14,
  height = 7,
  dpi = 600,
  bg = "white"
)
