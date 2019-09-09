# perm-aws-terraform

    ===========================================
       Perm AWS Terraform Example Setup (prnx)
    ===========================================


Documentation
-------------

Perm (https://gitlab.com/prunux/perm) is a web based permission management
system based on the gedafe toolkit (https://gedafe.github.com).

This Terraform Setup will create an AWS environment which runs perm.

System Setup:
* AWS Aurora PostgreSQL running serverless
* EC2 Instance for preloading SQL on AWS Aurora
* EC2 Instance running perm with an Apache 2.0 Webserver
* No private Networks needed

Homepage
--------

https://gitlab.com/prunux/perm-aws-terraform


Tested
------

Tested on 2019-09-09 using terraform 0.12.7

License
-------
    perm-aws-terraform is a set of System Description Language (HCL)
    and scripts to setup and run perm on AWS.
    Copyright (c) 2019, prunux.ch, Roman Plessl, All rights reserved.
    Copyright (c) 2019, Plessl + Burkhardt GmbH, All rights reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Copyright
---------

    Copyright (c) 2019, prunux.ch, Roman Plessl, All rights reserved.
    Copyright (c) 2019, Plessl + Burkhardt GmbH, All rights reserved.

    This database design and code was donated and paid by

        Stiftung 3FO, Belchenstrasse 7, CH-4600 Olten and
        Forem AG, Belchenstrasse 7, CH-4600 Olten

Authors
-------

* Roman Plessl

