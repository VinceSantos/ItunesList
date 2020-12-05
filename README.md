# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* A Coding Test for Appetiser Apps.
* 0.1

### Structure and Architecture Design ###
* Used VIPER Design Architecture for maintainability and reusability because of its modular feature. Using VIPER Design Architecture makes the app modular and all of its components can be reused by just changing it's API, Database, and Design.
* Used only URLSession for API management, I did not use pods for API because less dependencies = easy maintainability for future proofing. 
* Used CoreData for the same reason, less dependecies = easy maintainability for future proofing.
* Only used one POD for this, which is SwiftyJSON. Its not a heavy dependency because it's just being used to handle JSONData. 

### How do I get set up? ###

* Pull from Master Branch
* Pod Install to install pods (Only used one pod for this App - SwityJSON)
* Database used: CoreData

### Who do I talk to? ###

* vincecarlofsantos@gmail.com