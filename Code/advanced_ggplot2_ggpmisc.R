# https://cran.r-project.org/web/packages/ggpmisc/vignettes/user-guide.html

# Packages

library(ggpmisc)
library(tibble)
library(dplyr)
library(quantreg)

eval_nlme <-  requireNamespace("nlme", quietly = TRUE)
if (eval_nlme) library(nlme)
eval_broom <-  requireNamespace("broom", quietly = TRUE)
if (eval_broom) library(broom)
eval_broom_mixed <-  requireNamespace("broom.mixed", quietly = TRUE)
if (eval_broom_mixed) library(broom.mixed)
eval_gginnards <-  requireNamespace("gginnards", quietly = TRUE)
if (eval_gginnards) library(gginnards)

# Creating the dataset

set.seed(4321)
x <- (1:100) / 10
# linear
y.sd1 <- x + rnorm(length(x), mean = 0, sd = 1)
y.sd3 <- x + rnorm(length(x), sd = 3)
y.sdinc <- x + rnorm(length(x), mean = 0, 
                     sd = seq(from = 1, to = 3, length.out = length(x)))
outliers <- sample(seq_along(x), size = 5)
# 3rd degree polynomial
y.poly <- (x + x^2 + x^3) + rnorm(length(x), mean = 0, sd = mean(x^3) / 4)
y.poly <- y.poly / max(y.poly)

my.data <- data.frame(x = x,
                      y = y.sd1,
                      y.sd3 = y.sd3,
                      y.sdinc = y.sdinc,
                      y.desc = - y.sd1,
                      y.grp = y.sd1 + c(0, 1),
                      y.otlr = ifelse(seq_along(x) %in% outliers,
                                      y.sd3,
                                      y.sd1),
                      wght.otlr = 
                        ifelse(seq_along(x) %in% outliers, 1/3, 1),
                      y.poly = y.poly,
                      y.poly.grp = y.poly * c(1, 1.5) + c(0, 0.2),
                      wght.sqrt = sqrt(x),
                      group = c("A", "B"),
                      group.abcd = c("a", "b", "c", "d"), 
                      block = c("a", "a", "b", "b"))

head(my.data)

# ggplot

ggplot(my.data, aes(x, y)) +
  geom_point() +
  stat_correlation()

# The defaults support grouping by mapping of a factor to an aesthetic, in this example, colour.

ggplot(my.data, aes(x, y.grp, colour = group)) +
  geom_point() +
  stat_correlation()

# Spearman’s (𝜌, rho) and Kendall’s (𝜏, tau)

# strings
# 'stat_correlation' labels (1 rows): P, n, grp, r, r.confint, method, cor, R2, t.

# new graph

ggplot(my.data, aes(x, y.grp, color = group)) +
  geom_point() +
  stat_correlation(mapping = use_label("r", "t", "P", "n"))

# additional stats

# 'stat_correlation' variables (1 rows): t.value, df, p.value, cor, test, n, method, r.conf.level, r.confint.low, r.confint.high, npcx, npcy.

# grouping

ggplot(my.data, aes(x, y.grp)) +
  geom_point() +
  stat_correlation(mapping = 
                     aes(label = after_stat(cor.label),
                         color = 
                           after_stat(ifelse(cor > 0.955, 
                                             "red", "black")))) +
  scale_color_identity() +
  facet_wrap(~group)

# Curve fitting

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, aes(x, y.poly)) +
  geom_point() +
  stat_poly_line(formula = formula) +
  stat_poly_eq(formula = formula)

# Curve fitting with info

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, aes(x, y.poly)) +
  geom_point() +
  stat_poly_line(formula = formula) +
  stat_poly_eq(mapping = use_label("eq", "R2", "n"), formula = formula)

# Curve fitting by groups

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, aes(x, y.poly.grp)) +
  geom_point() +
  stat_poly_line(formula = formula) +
  stat_poly_eq(aes(label = after_stat(eq.label)), size = 2.5,
               formula = formula) +
  facet_wrap(~group)

# Curve fitting by group in the same graph

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, 
       aes(x, y.poly.grp, colour = group)) +
  geom_point() +
  stat_poly_line(formula = formula) +
  stat_poly_eq(aes(label = after_stat(eq.label)), 
               formula = formula)

# black and white with different sybols

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, 
       aes(x, y.poly.grp, 
           linetype = group,
           grp.label = group)) +
  geom_point() +
  stat_poly_line(formula = formula, colour = "black") +
  stat_poly_eq(aes(label = 
                     after_stat(paste("bold(", grp.label, "*\":\")~~", 
                                      eq.label, sep = ""))),
               formula = formula)

# Several groups altogether

formula <- y ~ poly(x, 3, raw = TRUE)
ggplot(my.data, 
       aes(x, y.poly.grp, colour = group.abcd)) +
  geom_point(shape = 21, size = 3) +
  stat_poly_line(formula = formula) +
  stat_poly_eq(aes(label = after_stat(rr.label)), 
               size = 3, 
               formula = formula) +
  facet_wrap(~group, scales = "free_y")

# Volcano-plot examples

# data

head(volcano_example.df) 

ggplot(volcano_example.df, 
       aes(logFC, PValue, colour = outcome2factor(outcome))) +
  geom_point() +
  scale_x_logFC(name = "Transcript abundance%unit") +
  scale_y_Pvalue() +
  scale_colour_outcome() +
  stat_quadrant_counts(data = function(x) {subset(x, outcome != 0)})

ggplot(volcano_example.df, 
       aes(logFC, PValue, colour = outcome2factor(outcome, n.levels = 2))) +
  geom_point() +
  scale_x_logFC(name = "Transcript abundance%unit", log.base.labels = 2) +
  scale_y_Pvalue() +
  scale_colour_outcome(values = "outcome:de") +
  stat_quadrant_counts(data = function(x) {subset(x, outcome != 0)})




