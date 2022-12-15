# Daily Checks CLI

## Overview

The daily checks CLI allows users to upload daily checks/reports to Flight Center using the command line.

## Usage

### Installation

The following steps will install the daily checks CLI from git:

```bash
git clone https://github.com/alces-flight/daily_checks_cli.git
cd daily_checks_cli
bundle install
```

### Operation

#### File storage and format

Files should be stored as pdfs in the /report folder, in the following format:
```bash
dd_mm_yy <cluster> report.pdf
```

where the date is the current date, and <cluster> is the name of the cluster for which the report was created.
  
#### YAML file
  
A YAML file named components.yaml will need to be created and populated in order for the tool to grab the required details from a given shortcode. The YAML file should be written as follows:

```bash
<shortcode>:
    name: "<cluster>"
    auth: "<auth_token>"
```
  
with the fields filled in appropriately. Every cluster must be listed in this YAML file.
  
#### Running the tool

The following command will upload a report matching today's date and the cluster specified by the shortcode given from the /reports folder, assuming such a report is present:

```bash
ruby upload_reports.rb upload_report <shortcode>
```

# Contributing

Fork the project. Make your feature addition or bug fix. Send a pull
request. Bonus points for topic branches.

Read [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

# Copyright and License

Creative Commons Attribution-ShareAlike 4.0 License, see [LICENSE.txt](LICENSE.txt) for details.

Copyright (C) 2019-present Alces Flight Ltd.

You should have received a copy of the license along with this work.
If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

Daily checks CLI is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

Based on a work at [https://github.com/openflighthpc/daily_checks_cli](https://github.com/openflighthpc/daily_checks_cli).

This content and the accompanying materials are made available available
under the terms of the Creative Commons Attribution-ShareAlike 4.0
International License which is available at [https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/),
or alternative license terms made available by Alces Flight Ltd -
please direct inquiries about licensing to
[licensing@alces-flight.com](mailto:licensing@alces-flight.com).

Daily checks CLI is distributed in the hope that it will be useful, but
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS OF
TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR
PURPOSE. See the [Creative Commons Attribution-ShareAlike 4.0
International License](https://creativecommons.org/licenses/by-sa/4.0/) for more
details.
