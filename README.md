# Dockerfile for Hubot

## Building your own image
```
$ git clone https://github.com/liquidstate/docker-hubot.git
$ docker build -t hubot docker-hubot
```

## Basic example
Getting a basic hubot running is as simple as:
```
$ docker run -it hubot
```

You can then test it using some of the basic commands:
```
Hubot> hubot ping
PONG
Hubot> hubot help
Hubot adapter - Reply with the adapter
Hubot echo <text> - Reply back with <text>
Hubot help - Displays all of the help commands that Hubot knows about.
Hubot help <query> - Displays all help commands that match <query>.
Hubot ping - Reply with pong
Hubot time - Reply with current time
Hubot>
```

## Changing basic configuration
Hubot (and its plugins) are usually configured via environment variables.  For example:
- HUBOT_NAME Hubot
- HUBOT_ADAPTER shell
- HUBOT_PORT 8080

You can set these on the command line:
```
$ docker run -e 'HUBOT_NAME=marvin' -e 'HUBOT_PORT=80' -it hubot 

marvin> marvin echo hello
hello
marvin> marvin time
Server time is: Wed Mar 11 2015 00:05:53 GMT+0000 (UTC)
marvin>
```

### Adding more scripts
You can mount your own configuration directory as a volume:
```
$ docker run -e -v <localpath>:/opt/hubot/conf -it hubot 
```

There are a few ways of adding new scripts:
* You can list any scripts from the [hubot-scripts-catalog](http://hubot-script-catalog.herokuapp.com/) in a `hubot-scripts.json` file in your config directory.
* You can load scripts from npm packages by adding them to a `external-scripts.json` file in your config directory.
* You can include your own .coffee files in a `scripts` directory in your config directory.

You can get more information about scripts and how to load them at:
https://github.com/github/hubot/blob/master/docs/scripting.md

On start up, the container will install the desired scripts from the Internet and their dependencies before starting Hubot.
