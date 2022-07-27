### The Task
```


1. ruby_app

Write a ruby script that:

a. Receives a log as argument (webserver.log is provided)
  e.g.: ./parser.rb webserver.log

b. Returns the following:

  > list of webpages with most page views ordered from most pages views to less page views
     e.g.:
         /home 90 visits
         /index 80 visits
         etc...
  > list of webpages with most unique page views also ordered
     e.g.:
         /about/2   8 unique views
         /index     5 unique views
         etc...
```


## Running Script

Navigate to directory where the script is located
```
$ cd ~/path/to/sp-ruby_exercise-2015/ruby_app
```

Run the script by passing in the name of the server logs you would like to parse

```
$ ruby ./parser.rb webserver.log
```

## Running Tests
Navigate to directory where the script is located
```
$ cd ~/path/to/sp-ruby_exercise-2015/ruby_app
```

Ensure rspec is installed by running
```
$ bundle install
```

Run tests by running
```
$ rspec spec/lib/log_analyzer_spec.rb
```


## Notes & Explanations


**CODE:**
- My approach was to take the simplest approach that could then be extended and improved upon.
- The first step was to decouple the code that does the parsing (`lib/log_analyzer.rb`) from the
script that calls it (`parser.rb`). This allows the parser (`lib/log_analyzer.rb`) to be reusable and can even be turned in to a gem. I have also attempted to DRY-up my code where possible w

**TESTING:**
- Regarding testing, the idea was to simply "black box" the public methods and not test implementation. By feeding data into a method and only testing the output, rather than how we get to the output, it allows us to completely refactor our code without having to change our tests.

**SUGGESTIONS:**
- The approach used for keeping track of the IPs that visit each page is to simply push them into an array associated with each page address. In the event where most IP addresses are _not_ unique, this approach would become inefficient in terms of memory.
- A different approach would be to save the data like this:
```
{
  '/home' => [
    '123.123.123' => 2,
	'456.456.456' => 1
}
```
This approach keeps track of how many time each IP has visited a given page.
- It is worth noting that using this approach would mean we would need to compare and match string (IP addresses) to see if we have them on record. This would then make the code a lot more resource intensive in terms of processing power. In that case I would suggest a better tool for the job would be to use a language like Elixir or Erlang which where designed for this particular purpose, pattern matching.
