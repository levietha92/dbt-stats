# dbt-stats
Packages to investigate a dbt project

## dbt_stats.sh
*Mandatory citation*
"""
Tange, O. (2024, June 22). GNU Parallel 20240622 ('34 counts').
Zenodo. https://doi.org/10.5281/zenodo.12518196
"""
### Introduction
This is a bash script that will loop through the models in your dbt project
and give you insights on following:
- model names
- upstream objects counts of each model
- downstream object counts of each model
- test count of each model

### Guide
- Make sure to install GNU parallel to run the bash script
- Run `bash dbt_stats.sh` will print result to `output.csv`
- Instead of `bash` use `dash` for your terminal is believed to make it faster if you have too many dbt models in your project to parse through. I haven't tested. I tried running 200+ models, take 20 minutes, need more optimized script.
