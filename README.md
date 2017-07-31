# npmLicenseChecker
Super-minimalistic License Check Tool for NPM jspm dependencies written in Powershell. Well sutiable for integrating with build flows.

The tool parses npm folder and goes through all packages.json in order to collect license information for all dependencies.
It doesn't run `npm` command to avoid local/global mixup. It only parses what you tell it to parse.

More cool features to come:
- Support `npm` naming of packages (not only jspm)
- Dev/Prod dependencies parsing
- Printing out dependency by license type
- Finidng "non-free" licenses
