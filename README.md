# Baseball statistics - task #

## Overview: ##
For this scenario, we have been asked to write an application that will be used to provide information about baseball player statistics.  Approach this problem as if it is an application going to production.  We don't expect it to be perfect (no production code is), but we also don't want you to hack together a throw-away script.  This should be representative of something that you would be comfortable releasing to a production environment.  Also, spend whatever amount of time you think is reasonable.  If you don't get all the requirements completed, that's ok.  Just do the best you can with the time that you have available.  You may use whatever gems, frameworks and tools that you think are appropriate, just provide any special setup instructions when you submit your solution.

### Assumptions: ###   
All requests currently are based on data in the hitting file.  Future requests of the system will require data from a pitching file as well.  Consider this in the design.

### Requirements: ###  
When the application is run, use the provided data and calculate the following results and write them to STDOUT.

1) Most improved batting average( hits / at-bats) from 2009 to 2010.  Only include players with at least 200 at-bats.
2) Slugging percentage for all players on the Oakland A's (teamID = OAK) in 2007. 
3) Who was the AL and NL triple crown winner for 2011 and 2012.  If no one won the crown, output "(No winner)"

### Formulas: ###
Batting average = hits / at-bats
Slugging percentage = ((Hits – doubles – triples – home runs) + (2 * doubles) + (3 * triples) + (4 * home runs)) / at-bats
Triple crown winner – The player that had the highest batting average AND the most home runs AND the most RBI in their league. It's unusual for someone to win this, but there was a winner in 2012. “Officially” the batting title (highest league batting average) is based on a minimum of 502 plate appearances. The provided dataset does not include plate appearances. It also does not include walks so plate appearances cannot be calculated. Instead, use a constraint of a minimum of 400 at-bats to determine those eligible for the league batting title.


### Data: ### 
All the necessary data is available in the two csv files attached:

Batting-07-12.csv – Contains all the batting statistics from 2007-2012.  
Column header key:
AB – at-bats
H – hits
2B – doubles
3B – triples
HR – home runs
RBI – runs batted in

Master-small.csv – Contains the demographic data for all baseball players in history through 2012.

Please note: We are looking for you to demonstrate you knowledge related to common software practices to include reusability, portability, and encapsulation – to name a few. Work submitted should be in project form and implemented as you were implementing any production solution.



# Baseball statistics - solution #

## Installation guide ##
To run this application, just copy the source code to computer where you have Ruby installed.


### Install gems ###
```
bundle
```


### Run application ###
```
bundle exec baseball_stats
```

The application is written as Ruby gem. It is not using Rails framework, because it would not be suitable for this specific task. We don't need routing, we are not storing data into the database and we are not dealing with layouts and views and we don't need any predefined helpers etc.


## Goal ##
The main goal of this application is to calculate the following statistics:

1. Most improved batting average( hits / at-bats) from 2009 to 2010. Only include players with at least 200 at-bats.
2. Slugging percentage for all players on the Oakland A's (teamID = OAK) in 2007.
3. Who was the AL and NL triple crown winner for 2011 and 2012. If no one won the crown, output "(No winner)"

All these tasks are performed in the script
```
bin/baseball_stats
```

### Examples of functions and parameters ###
You can change the parameters in the source code to see different results. The application is resistant against passing incorrect values as parameters.


#### Slugging percentage for all players in specified team ####
```
BaseballStats::BattingStats.team_slugging_percentage('OAK', 2007)
```

This will return list of players in the specified team with their slugging percentage statistics. If the player does not have at bats value given the slugging_percentage will be nil.

#### Most improved batting average ####
```
BaseballStats::BattingStats.best_batting_avg_improvement(2009)
``` 

This will show the name of player with the best batting average improvement where the improvement occured between 2009 and the following year.

#### Tripple Crown Winner ####
``` 
BaseballStats::BattingStats.tripple_crown_winner('AL', 2012)
BaseballStats::BattingStats.tripple_crown_winner('NL', 2012)
``` 

## Input data ##
Input CSV files are stored in "csv" directory.

* batting.csv - contains batting statistics
* players.csv - containts information about players (id, birth year, first name, last name)

In this version of the application you cannot change the file names, but I was considering that I would allow users to specify path to input CSV files as parameters in the command line. Paths to input CSV files are defined in "lib/baseball_stats.rb"

I am using CSV gem to parse the input files, There is a rescue block in case the CSV file would have incorrect format.


## Source code ##

The code is written in a way so it would be self-explanatory. I am using longer name for methods so it would be clear from their name what they do rather than using short names and adding comments.


### Pitching stats ###

Adding processing of pitching data should be pretty straightforward.

There is a method called "import_pitching_data" declared in "lib/baseball_stats.rb". This method should be completed. After that "lib/baseball_stats/pitching_stats.rb" script should be created. This script will have similar structure as "lib/baseball_stats/batting_stats.rb" but the module will have diffent name. This script will be responsible for processing pitching data.
