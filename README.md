# [Monitoramento & Controle](http://alexmonteiro.github.com/Redmine-Monitoring-Controlling) (M&C) - Redmine Plugin

M&C is a Redmine Plugin used as a chart tool to monitoring issues' project 

## Features
	Master Version (0.2.1) (Redmine 4.0.4)

## How to install 

### Requirements

* Redmine >= 4.0.4 version

### Step-by-step

* Copy or clone the app on Redmine plugin folder with the same name like: /plugins/redmine_monitoring_controlling
* Run
 ```bash  
cd /{redmineInstalationDir}/plugins
git clone https://github.com/gnomex/Redmine-Monitoring-Controlling.git redmine_monitoring_controlling
cd redmine_monitoring_controlling
RAILS_ENV=production bundle exec rails redmine:plugins:migrate
```

* Restart your redmine application.
* Activate your M&C on projects modulues.

## License
 
Redmine Monitoring & Controlling Plugin is open source and released under the terms of the {GNU General Public License - GPL - v3}[https://github.com/alexmonteiro/Redmine-Monitoring-Controlling/blob/master/license.txt].
Check {GNU GPL v3 quick guide}[http://www.gnu.org/licenses/quick-guide-gplv3.html] for more information.

## Credits

* Highcharts[http://www.highcharts.com/]: interactive javascript charts for your web projects;
* Railscasts[http://railscasts.com/]: learn how to use highcharts on your rails app in #223[http://railscasts.com/episodes/223-charts] episode.
