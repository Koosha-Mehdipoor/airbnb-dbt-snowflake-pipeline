# Airbnb Analytics (dbt + Preset)

This project is a small end-to-end analytics pipeline built on a public **Airbnb dataset**, transformed using **dbt** and visualized in **Preset (Apache Superset)**.

The project follows a standard analytics engineering workflow:

**raw sources → staging → snapshots → marts → semantic / BI layer**

It is designed as a **learning and portfolio project**, with an emphasis on clear model layering, lineage, and practical KPI creation.

---

## Project goals

- Transform raw Airbnb data into clean, analytics-ready tables
- Apply dbt best practices (layered modeling, testing, lineage)
- Experiment with snapshots and bridge tables
- Build an interactive dashboard in Preset / Superset
- Serve as a hands-on analytics engineering portfolio project

---

## Data sources

Raw tables are ingested as dbt sources: which is getting the data from Amazon S3 bucket.

- `airbnb.hosts`
- `airbnb.listings`
- `airbnb.reviews`

---

## Data modeling overview

### Staging layer (`T_*`)

The staging layer performs:
- Column renaming and standardization
- Type casting
- Basic data cleaning and normalization

Staging models:
- `T_HOSTS`
- `T_LISTING`
- `T_REVIEWS`

---

### Snapshots

Snapshots are used to track historical changes in selected entities:
- `T_HOSTS_SNAPSHOTS`
- `T_LISTINGS_SNAPSHOTS`

These snapshots enable time-based analysis of attribute changes and support future slowly changing dimension use cases.

---

### Marts layer

#### Dimensions

- `DIM_HOSTS`  
  Cleaned host-level attributes (e.g. host name, superhost status)

- `DIM_LISTINGS`  
  Listing-level attributes (e.g. room type, price, price category)

- `DIM_HOST_LISTING`  
  A host–listing bridge/enriched dimension combining host and listing attributes at the **listing grain**, designed for simplified downstream joins. please note that this is not the best practice and can create duplications in your data so you should use it with cautious.

#### Facts

- `F_REVIEWS`  
  Review-level fact table containing review text, sentiment, and review dates.

---

### Seeds

- `seed_full_moon_dates`  
  Calendar-style seed table containing full moon dates, used for exploratory time-based analysis.

---

### Analytical / semantic models

These models sit on top of the marts layer and are designed for BI consumption:

- `VIS_AIRBNB_KPIS`  
  This view is generated for the simplcity of the visualisations and dashboard creation on prest. please note that in the performance view it is not the best practice.

- `FULL_MOON_REVIEW`  
  Exploratory model analyzing review sentiment in relation to full moon dates, which enables you to see how the seeds works in dbt and doing an analysis to check if full moon has negative impacts on reviews of the users

- `consistent_created_at`  
  Helper model to normalize and align review timestamps across analyses

---

## Dashboard (Preset / Superset)

The Preset dashboard includes:
- Listings overview and high-level KPIs
- Price distribution and categorization
- Host and listing breakdowns
- Review sentiment analysis
- Time-based trends and exploratory analyses

Interactive filters include listing attributes such as room type, price category, and host characteristics.

Dashboard link:  
https://5fb50298.us2a.app.preset.io/superset/dashboard/8/?native_filters_key=wB82gNEBMay7G9R9p37pGbU-WFgJzc3ipCbmV9TwzSdRtn_jvhtEU_DnUEoMRBHF

please note that for the dashboard it is a draft for showcasing how the pipeline of the data works and it can be considered as a draft and many more kpis can be added also visually can be much approved which was out of scope for this project
---

## Testing

Basic dbt tests are applied where applicable:
- `not_null` constraints on primary keys
- `unique` constraints where model grain allows
- Sanity checks aligned with dataset limitations

Also used dbt expectations package in some models for data sanity checks.

---
## documentation

The dbt native documentation and linage is also available through commands 'dbt docs generate' and then 'dbt docs serve' which opens up the documentation page.

## Tech stack

- **dbt** — data transformations, testing, and lineage
- **Snowflake** — cloud data warehouse
- **Preset (Apache Superset)** — BI and dashboarding

---

## How to run the project

```bash
dbt debug: for debuging your dbt connection to your database.
dbt clean: in case of mis match between the dbt packages you are using, cleans all the existing packages.
dbt deps: for creating the neccessary packages for running the dbt project like utils.
dbt run: to run all the existing models
dbt test: to run the test to check out if there any failures or warnings on tests created.


