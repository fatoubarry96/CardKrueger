## Card & Krueger (1994) Replication – Final Project

This repository contains my replication of Card & Krueger (1994), using the public fast-food dataset to reproduce their difference-in-differences results on New Jersey’s minimum wage increase.

### Contents
- `fastfood.dta`: Original dataset used in the replication
- `CardKrueger.do`: Main do-file reproducing key DiD results
- `ck_figures_final.do`: Do-file that generates all figures used in the paper
- `Figure1_Mean_Employment.png`: Mean employment by state and period
- `Figure2_Mean_Wage.png`: Mean wages by state and period
- `Figure3_Log_Wage_Distribution.png`: Distribution of log starting wages

### Replication Instructions
1. Set the working directory to the repository folder.
2. Run `CardKrueger.do` to reproduce the main results.
3. Run `ck_figures_final.do` to generate all figures.

All code is fully reproducible and requires changing only the working directory path.

