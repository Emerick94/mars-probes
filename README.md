# MarsProbes

This project will help you navigate to a plateau on mars! or anywhere with viable conditions really, cool, right?

This can accept the instructions either on a file or text on the shell

## Usage

On the root of this project run:

`mix explore` to get the shell version.

`mix explore location/to/file` to run the instructions from a file.
You can find some examples on the `examples` directory.

## Features
- Completely case insensitive.  
We worried about that, so you don't have to :)
- Understanding of how you want to point the direction
All of this means N: "n", "NorTh", "0", "-4", "4".  
Substrings of the cardinal directions, like "no", will be considered a typo, so be mindful about that. Only the first letter or the full name are acceptable.
- Lets you do you.  
You can add a probe and in the next line add another, without moving the former.
You can also, continue to move the last probe in multiple lines.
You can only move the last added probe though. 
- Validates position on each move.  
Your drone wont leave the area. Should you give instructions that would make that happen, it won't move. You will receive an error message stating what condition is being violated.
Two drones can be on the same place though, they are good climbers. ;)


