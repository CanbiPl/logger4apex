# logger4apex_internal

![](https://img.shields.io/badge/APEX-18.2-success.svg) ![](https://img.shields.io/badge/APEX-19.1-success.svg) ![](https://img.shields.io/badge/APEX-19.2-success.svg) ![](https://img.shields.io/badge/APEX-20.1-success.svg) ![](https://img.shields.io/badge/APEX-20.2-success.svg)
![](https://img.shields.io/badge/Oracle-11g-success.svg) ![](https://img.shields.io/badge/Oracle-12c-success.svg)  ![](https://img.shields.io/badge/Oracle-18c-success.svg)


## Overview

The package with dedicated tables can help to log application and/or page items as good as collections in APEX.
Needs grant for READ on APEX_VERSION_SCHEMA.wwv_flow_data for example: grant select on apex_180200.wwv_flow_data to my_db_user;


#### All features:

- Logging any item (from page, application) with additional info about app_id and page_id
- Logging collections with details
- Grouping variables (items, from pl/sql bloks) in table data types and logging at once
- Using information like $$PLSQL_UNIT and/or $$PLSQL_LINE when logging from packages/procedures/functions
- Adding distinction beetwen Errors and standard Information


#### Preview: 

![](https://raw.githubusercontent.com/CanbiPl/logger4apex_internal/preview.png)


## Reference

1. This plugin based on Logger: https://github.com/OraOpenSource/Logger 

## Demo

Demo Application installation: 

1. Import the demo app from: **`demos/demo_on_APEX_180200_or_higher_install.sql`**
   

**Online demo now available. Use link below with user:demo pass:demo :**

[LOGGER4APEX](https://CANBI.PL/ords/f?p=LOGGER4APEX)


## Pre-requisites

- **Oracle Database 11.2g** or later (not tested on earlier versions).

- **Oracle Application Express 18.2** or later (no extra grants needed).

Needs grant for READ on APEX_VERSION_SCHEMA.wwv_flow_data for example: grant select on apex_180200.wwv_flow_data to my_db_user;  


## Installation instructions

1. Download the latest release
2. Add grant for READ on APEX_VERSION_SCHEMA.wwv_flow_data
3. Install on your database schema


## Releases

| Release number | Release date | New features                                                 |
| -------------- | ------------ | ------------------------------------------------------------ |
| 1.00.00        | 2022-01-17   | Initial release                                              |


## Planned features in next releases

*Logging all APEX items at once.*
*Logging/more_detailed_logging specific packages/procedures/functions as a results of parameter.*


## Support

1. Solution is on MIT license. 

2. If you find any bugs or you have idea to extend functionality of plugin feel free to use [issues](https://github.com/CanbiPl/logger4apex_internal/issues) section or send private message.

3. I will be glad to hear about your feedback

   

   
