# Odoo Enterprise

This directory is used to store Odoo Enterprise source code in ORIGINAL downloaded ZIP format.  
Notice that this is optional, if you'd like to use Odoo Community, you can skip this step.

Download the Odoo enterprise source code into this directory. Leave it in the original zip, example:

```
.enterprise/enterprise-15.0.zip
.enterprise/enterprise-16.0.zip
```

You can leave as many versions are you like in here. The script will automatically detect them and use the correct one when building the container.

**Don't commit these zips!** _This directory is .gitignored so you don't need to worry about doing it accidentaly_
