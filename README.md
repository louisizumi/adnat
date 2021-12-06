# Adnat
A Tanda web app clone built using Ruby on Rails.

## Local Installation

Make sure you are using Ruby v2.7.3:

``` 
$ rbenv local 2.7.3-p183
```
Then execute in your local repository:

```
$ bundle install
$ yarn install
$ rails db:create db:migrate db:seed
$ rails s
```
You can then find a local server running at: http://localhost:3000

## Features

The app meets the minimum spec as outlined in the readme for https://github.com/TandaHQ/work-samples/tree/master/adnat%20(backend), except where overridden by attempts at the optional challenges, as listed below.

1. Users details (COMPLETE)
Allow users to change their own name, email address, or password.

2. Modifying/Deleting shifts (COMPLETE)
Allow users to modify or delete existing shifts.

3. Departed Employee Shift Storage (COMPLETE W/ BONUS)
Create a way for shifts of a departed employee to be stored. Create a link on the "View Shifts" route that would direct a user to a table of prior employees shifts. You may need to make schema changes for this exercise. Bonus: If a departed employee re-joins the organisation, have a way for their past shifts to be re-added to current shifts.

4. Filtering shifts (ATTEMPTED - users can filter OR search by employee)
Allow users to filter which shifts are visible based on employee or a date range or both.

5. Overnight shifts (COMPLETE)
When creating a shift, if the finish time of a shift is earlier than the start time, the shift should be considered overnight. For example, if the start time is 7:30pm and the finish time is 1:30am, then it is an overnight shift that goes for 6 hours.

6. Penalty rates on Sundays (COMPLETE)
The hourly rate should be doubled for shifts worked on a Sunday. If you do exercise (4) then you will need to account for overnight shifts in the following manner: The 2x should only apply to the hours worked on Sunday. 

7. Multiple breaks (DID NOT ATTEMPT)
People often take more than one break when they work. For this exercise, instead of a shift having a single break length, it could have multiple. The sum of all these should be taken into account when calculating hours worked and shift cost.

8. Multiple organisations (COMPLETE)
Some people have 2+ jobs. Extend organisation functionality to allow users to belong to more than one organisation. You will need to rethink the shifts model. Shifts currently belong to a user (who belongs to a single organisation). If there are multiple organisations involved, this falls apart, because you don't know which organisation the user worked the shift at.

9. Functional or Unit tests (DID NOT ATTEMPT)
Adding tests is a good idea. We don't mandate that you write any for this challenge, but feel free to go ahead and write some tests for your code.

10. JavaScript enhancements (ATTEMPTED - Majority of forms use Ajax; Shifts are sortable by column in both ASC/DESC order; Form fields use date and time pickers as appropriate)
It is possible to build a solution to this challenge without writing a line of JS. However, a solution that used some would be more exciting. Here are some ideas:

- A datepicker for the shift date field
- Using Ajax to create shifts
- Sorting by column
- Making the whole thing an SPA in React

11. Your own idea
Feel free to add a feature of your own devising. You're more than welcome to sign up for a trial Tanda account to look for inspiration.
