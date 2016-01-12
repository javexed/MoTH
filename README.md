# The IVR MoTH: Phone System Monitoring, Testing, Hammering

## Installation

### Prerequisites
* Ensure you have docker: https://docs.docker.com/
* Install docker-compose: https://docs.docker.com/compose/install/
* Also requires local ruby until I can figure out how to put that into a docker container as well.

### Install, Download, and Run
* Clone the repository
* cd into the repository
* run: `rebuild.sh`

## Configuration
* Set the environment files as you wish
** mariadb.env
** docker-adhearsion/adhearsion.env
 
### Scripts
Copy all the files you wish to "fingerprint" (be able to validate) into the "docker-dejavu/scripts/" directory. 
The first time that the DejaVu docker image is built, it will fingerprint everything in that directory.

### Voip
Ensure that you configure your iax.conf or sip.conf (examples provided).
`cp docker-asterisk/sip.conf.example docker-asterisk/sip.conf`

### Test Plan
Edit the config.yml and put in the numbers you want to test and set the max concurrent calls.

## Run
Run the following command
`ruby client.rb`

## Known issues
* It doesn't do any sort of validation that the call tried to go out. So, if your SIP provider isn't registering, the call will come back as failed.
* No type of reports, it doesn't correlate the phone number to the "match".

## Troubleshooting
To validate that calls are going out:
* run `docker-compose stop adhearsion`
* run `docker-compose run adhearsion bin/bash`
* from the command line, you can make outbound calls as per documenation here: http://adhearsion.com/docs/console
* all recordings are put into the directory ./recordings

## Credits
This project is really just an amalgamation a few other fantastic opensource projects
* Adheasion
* Asterisk 
* Docker
* Asterisk Docker image
* DejaVu
