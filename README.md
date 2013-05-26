![Mobile Detect](http://demo.mobiledetect.net/logo-github.png) Ruby Gem

[![Build Status](https://travis-ci.org/dsample/Mobile-Detect.png?branch=master)](https://travis-ci.org/dsample/Mobile-Detect) [![Coverage Status](https://coveralls.io/repos/dsample/Mobile-Detect/badge.png?branch=master)](https://coveralls.io/r/dsample/Mobile-Detect?branch=master) [![Code Climate](https://codeclimate.com/github/dsample/Mobile-Detect.png)](https://codeclimate.com/github/dsample/Mobile-Detect)

### A versatile mobile device detection gem

> A Ruby port of a lightweight PHP class for detecting mobile devices. It uses the User-Agent string combined with specific HTTP headers to detect the mobile environment.

### History of the PHP library

The first version of the script was developed by Victor Stanciu in 2010.
In December 2011, [Serban Ghita](http://twitter.com/serbanghita) updated the first version and fixed all the bugs, then launched the 2.0 version which marks a new mindset and also featuring tablet detection.

Throughout 2012, the script has been updated constantly and we have received tons of feedback and requests. In July 2012 we moved from [Google Code](http://code.google.com/p/php-mobile-detect/) to GitHub.com in order to quickly accommodate the frequent updates and to involve more people.

### How reliable is this script? How frequent do you update it? How?

The script is as reliable as server-side detection can be. This is not a replacement for RWD (media queries) or other forms of client-side detection. Read W3C's Mobile Web Application Best Practices [Prefer Server-Side Detection Where Possible](http://www.w3.org/TR/mwabp/#bp-devcap-detection) section.

In order to detect phones and tablets (new ones and legacy) we're testing the library against HTTP headers and User-Agents that we find on the internet and through the demo.php file (See: http://is.gd/mobiletest). Sometimes is hard to distinguish between a phone and a tablet, this is why we're constantly researching a lot of mobile vendors sites, checking product codes and new releases. You can see some of our 'tests' by checking the [test](https://github.com/serbanghita/Mobile-Detect/tree/master/tests) folder.

We are working on a database and API that will automate this process in the near future.

### Roadmap and future development. Contribute!

[PHP library roadmap](https://github.com/serbanghita/Mobile-Detect/wiki/Roadmap)

### Usage

Require the gem in your Gemfile:
```ruby
gem 'Mobile_Detect'
```

Create an instance where you need it. It reads in a reasonably large JSON file, so it's probably best to put this in an initialiser if you're using Rails:
```ruby
detect = Mobile_Detect::Detect.new
```
Use it to 
```ruby
ua = request.env["HTTP_USER_AGENT"]
isTablet = detect.isTablet?(ua)
isMobile = detect.isMobile?(ua)
```

If you want to get more specific details about a particular user agent:
```
device = detect.device_type(ua)
puts device["type"]     # mobile,tablet,desktop
puts device["categories"] # more granular grouping, eg. tablet:iPad, mobile:iPhone, mobile:LG, mobile:iPhone:Chrome
```
The category can be a comma-separated list of categories. **Note: The categories groupings and names are not guaranteed to be the same in future versions and are intended as a guide, although for common devices such as iPhone and iPad it is expected to remain the consistent.**

#### Using the library in analytics

As a helper for visitor data analytics there is a script which can process CSV file data and add additional columns with device detection data.

This may become a more abstracted class in future versions

```
$ check_csv --help
Usage: check_csv [options]

Options:
    -i, --input [file]               Input CSV file (default: usage_data.csv)
    -c, --column [column]            Useragent column (zero-based) (default: 1)
    -o, --output [file]              Output CSV file (default: processed_usage_data.csv)
    -f, --overwrite                  Force overwriting of output file if it exists

    -v, --verbose                    Print verbose output
    -h, --help                       Display this screen
```
