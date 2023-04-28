# Scripts-for-User-Management-Bash-Scripts
👥This is the documentation for two Bash scripts created to manage users, groups, and directories.

### altatreb.sh

The `altatreb.sh` script is used to create users, groups, and directories based on the information in a file passed as a parameter. The script checks if the required root directories exist and creates them if they don't. The script also checks if the user is root and terminates if they aren't. Finally, the script checks if the user already exists and creates the user if they don't.

#### Usage

`altatreb.sh <file.txt>` 

#### Options

The `altatreb.sh` script has no options.

#### Parameters

-   `<file.txt>` - the file containing the information for the users, groups, and directories.

#### Conditions

-   The script must be executed as root.

#### Example

`sudo ./altatreb.sh users.txt` 

### trebproj.sh

The `trebproj.sh` script receives a project as a parameter and puts the user in the project's working directory, changes their active group, tells us how long they've been working on the project when they execute an `exit` command, and then returns them to their previous active group.

#### Usage

`trebproj.sh <project>` 

#### Options

The `trebproj.sh` script has no options.

#### Parameters

-   `<project>` - the project that the user is working on.

#### Conditions

-   Any user can execute the script.

#### Example

`./trebproj.sh project1`
