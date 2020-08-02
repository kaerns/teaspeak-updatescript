# Teaspeak Update Script

This easy to use script will update your teaspeak installation without any hassle!
This script will pull the latest version from the teaspeak site, unpack it and backup your configs and database as well.


## To run this script

* Ensure the script is in the same directory as your TeaSpeak installation
* Be sure to chmod it with execute perms (`chmod u+x update.sh`)
* Run the script without arguments to get the latest stable version


## Optional Arguments

Usage: `update.sh [-h, -b]`

| Option        | description                                                        |
| ------------- | ------------------------------------------------------------------ |
| -h, --help    | display help message and exit                                      |
| -b, --beta    | use the optimized beta build                                       |
| -f, --force   | enforce the update even if the newest version is already installed |

## Dependencies

* curl


## License

TeaSpeak Update Script (https://github.com/essemX/teaspeak-updatescript)
Copyright (C) 2020 essemX (https://github.com/essemX)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
