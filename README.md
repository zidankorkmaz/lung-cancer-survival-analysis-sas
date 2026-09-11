# Survival Analysis of Lung Cancer Patients: SAS PROC LIFETEST & PROC PHREG

## Overview
This analysis investigates how survival time among lung cancer patients varies according to sex, age and ECOG performance status. Understanding which patient characteristics are associated with survival can help identify important prognostic factors and provide clinicians with evidence about differences in patient outcomes. The analysis uses the NCCTG Lung Cancer dataset, containing 228 patient observations.

## Data
The analysis uses the NCCTG Lung Cancer dataset, consisting of **228 patients**. The dataset contains time-to-event information alongside censoring status and patient characteristics including age, sex and ECOG performance status (`ph.ecog`). There were **165 observed deaths and 63 censored observations**, meaning that 27.63% of observations were censored.

Sex was used to divide patients into two groups for the Kaplan–Meier analysis, while age, sex and ECOG performance status were included as explanatory variables in the Cox proportional hazards model.

## Methods

### Kaplan–Meier analysis and log-rank test
`PROC LIFETEST` was used to estimate Kaplan–Meier survival curves separately by sex. The Kaplan–Meier method accounts for censored observations when estimating the probability of surviving over time.

A log-rank test was then used to determine whether there was evidence of a difference between the survival distributions of the two sex groups. The null hypothesis was that the survival curves were equal between the groups.

### Cox proportional hazards regression
`PROC PHREG` was used to fit a Cox proportional hazards model including age, sex and ECOG performance status (`ph.ecog`).

The model estimates a hazard ratio (HR) for each variable. An HR greater than 1 indicates an increase in the hazard of death, while an HR below 1 indicates a decrease in the hazard, holding the other variables in the model constant.

## Results

Full SAS output (all tables + survival plot): [Project_results.html](Project_results.html)

### Kaplan–Meier analysis
The Kaplan–Meier survival curves showed evidence of a difference in survival between the two sex groups.

The log-rank test produced a chi-square statistic of 10.3267 with 1 degree of freedom and a p-value of 0.0013.

Therefore, there is statistically significant evidence of a difference in survival distributions between the two sex groups at the 5% significance level.

### Cox proportional hazards model

| Variable | Hazard Ratio | p-value |
|---|---|---|
| Age | 1.011 | 0.2334 |
| Sex | 0.576 | 0.0010 |
| ECOG performance status (`ph.ecog`) | 1.589 | <0.0001 |

The SAS output also gives Wald chi-square statistics of 1.42 for age, 10.82 for sex and 16.61 for `ph.ecog`. The overall Cox model was statistically significant, with likelihood-ratio chi-square = 30.4082, p < 0.0001.

## Interpretation
The results suggest that sex and ECOG performance status are important predictors of survival, whereas there is insufficient evidence that age is associated with survival after accounting for the other variables in the model.

The Kaplan–Meier analysis found a statistically significant difference in survival between the two sex groups. The log-rank p-value of 0.0013 is considerably below 0.05, providing strong evidence that the survival distributions are different.

In the Cox model, age had a hazard ratio of 1.011 with p = 0.2334. This suggests that each additional year of age was associated with an estimated 1.1% increase in the hazard of death, assuming the other variables remain constant. However, because the p-value is greater than 0.05, there is insufficient statistical evidence to conclude that age is associated with survival in this model.

Sex had a hazard ratio of 0.576 and p = 0.0010, indicating a statistically significant association with survival. Interpreting the HR requires knowing which sex category is represented by the comparison. If the standard coding of the dataset is being used, where sex = 1 represents males and sex = 2 represents females, the HR of 0.576 indicates that females had approximately 42.4% lower estimated hazard of death than males, after adjusting for age and ECOG performance status. The important point is that the hazard associated with the female group was substantially lower than that of the male group.

The strongest evidence of an association came from ECOG performance status. Its hazard ratio was 1.589 with p < 0.0001. This means that a one-point increase in ECOG score was associated with an estimated 58.9% increase in the hazard of death, holding age and sex constant. The relatively large Wald statistic of 16.61 also provides stronger statistical evidence than either age or sex in this model.

Therefore, ECOG performance status appears to be the most important prognostic factor among the variables considered, although sex also shows a strong association with survival. Clinically, this suggests that a patient's functional status may provide valuable information about their expected survival. Patients with poorer ECOG performance status tend to have a substantially higher estimated hazard of death.

It is important, however, that these results describe associations rather than causation. They should not be interpreted as showing that changing a patient's ECOG score or sex would cause their survival to change.

## What I'd do next
Several further analyses could strengthen the investigation.

First, I would assess the proportional hazards assumption for the Cox model. The interpretation of the hazard ratios relies on this assumption, so checking whether it is reasonable would be an important next step.

Second, I would examine whether there are interactions between the variables, particularly between sex and ECOG performance status. This would investigate whether the relationship between one prognostic factor and survival depends on another patient characteristic.

I would also investigate the confidence intervals for the hazard ratios, as these would provide information about the precision of the estimated effects rather than relying solely on p-values.

Finally, I would consider including additional clinically relevant variables available in the dataset and compare alternative models. This could determine whether the observed associations remain after accounting for other patient characteristics and potentially improve the model's ability to explain differences in survival.
