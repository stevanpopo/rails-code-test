# Welcome to the Claimable Technical Challenge

This challenge is designed to reflect the kind of work we do day-to-day and is based on real world problems we've experienced when building our product. It's intended as an opportunity for:

* Us to see what it's like working with you, how you code and your approach to problem-solving.
* You to understand the kind of work you'd be doing on in the role, and how we operate our development process.

In particular we'll be looking out for:

* Coding style and organisation of commits
* Understanding of the problem and subject matter
* Ingenuity and creative thinking

The challenge consists of a simple [Rails 4](http://rubyonrails.org) application, using [Bootstrap 3](http://getbootstrap.com) and [MongoDB](http://www.mongodb.org) (with [Mongoid](http://mongoid.org) as the ORM). Some sample data is also included.

## Confidentiality

We deal with sensitive information on a daily basis. Please treat the challenge itself, and all data as __highly confidential__ material that should not be shared with anyone outside of yourself and Claimable.

## Time Limits & Deadline

This challenge is not timed, and there is no minimum time requirement. You should spend as long as you feel is appropriate. (If you don't complete all the tasks, please mention this in your pull request when you submit your code.)

However, we do require that you __submit your final code by Tuesday 11th September 2018 at 15:00__.

## Questions

No part of this challenge is intended to catch you out, so if any of the tasks do not make sense, or if you want further clarification, please __don't hesitate to ask__ by emailing [miles@claimable.com](mailto:miles@claimable.com). We'd rather you ask questions, than risk misinterpretation of the problem!

## Setup

To get the application running:

* Ensure you have [MongoDB](http://www.mongodb.org) installed on your machine. (If you haven't already, on a Mac, we recommend using a package manager like [Homebrew](http://brew.sh/), otherwise there are plenty of guides online including the official MongoDB documentation).
* You will also need `ruby 2.1.1` installed.
* Clone this repo and run `bundle install` to install the required gems. (If bundler is not installed, run `gem install bundler` to install it.)
* Run `rails s` and navigate to [http://localhost:3000](http://localhost:3000). You should see an empty table titled __Claims__.
* Run `bundle exec rake dump:seed_data`, which will pull some data from a hosted DB and build some sample claims for you to use in development.
* Reload the app and you should see 30 claims in the claims table.

_(If you are having problems with any of the above and can't get the app to run, just let us know.)_

Now that the app is running with some seed data, you can move on to the tasks below.

## Task 1 - Improve the Existing Claims UI/UX

1. For claims, rename the __Created Date__ attribute to __Created Date/Time__.
2. In the claims index, order the claims in reverse chronological order based on their __Created Date/Time__.
2. Format the __Created Date/Time__ column in a way that you think would be most helpful to users. Also, the __Created Date/Time__ label in the header when editing an individual claim, should be formatted in the same way.
3. In the claims index, add a search function to allow the user to search by _either_ the __Claimant Name__ or __Claim ID__.
4. Add pagination to:
    * The Claims index (20 items per page)
    * The Emails index, within a given claim (50 items per page)

## Task 2 - New Fields

1. Add the following two new fields to a `Claim`, and display them beneath the __Policy No.__ field in the `Claim` edit view:
    * __Settlement Amount__ (the amount of money the claim was settled for)
    * __Settlement Date__ (the date on which the claim was settled)
2. Display the new __Settlement Amount__ field as a column in the claims index.
3. Add another new field to a claim, called __Status__. This should be a `<select>` element and should include the values: _Open_, _Settled_ & _Cancelled_. It should be above the __Claim ID__ field on the `Claim` edit view.
4. Make sure all new claims default to status _Open_.
5. Add styling to the __Claim ID__ values in the claim index so they appear as a colour-coded label (i.e. their background is coloured) which denotes the status of the claim. The status colours should be light grey, green and red respectively.
6. Create code that automatically sets the __Settlement Date__ to today and makes both the __Settlement Date__ and __Settlement Amount__ inputs read-only, when the __Status__ changes to _Settled_. If it changes back to _Active_ or _Cancelled_ the inputs should become editable again.

## Task 3 - New Model and Association

Our users need to be able to add notes for each `Claim`. Often there is detailed claim-specific information that isn't suitable to store in the `Claim` attributes, so notes are a good solution to this problem.

Notes are essentially comments regarding a `Claim`.

1. Add a new model called `Note`. A `Note` should have the following properties:
    * `created_at` - A timestamp to store when it was created
    * `body` - The actual body of the note (free type text)
    * A `Note` should belong to a `Claim` which can have many notes.
2. Add a new sidebar link, beneath __Emails__, when editing a `Claim`, called __Notes__.
3. This view should display a `<textarea>` element and a submit button to add a new `Note`.
4. Beneath this, there should be a list of all notes for the `Claim` in reverse chronological order styled similarly to how you might expect to find comments on a blog post. You can decide the best way to present the list of notes.
5. Each note should have a small "Delete" button.

## Task 4 - Data Manipulation Via Rake Task

Emails are used extensively by our users to discuss details of claims. In your sample data, there are 75,984 emails none of which have `subject` values. However, the subject line is contained in most email bodies, which is important information that needs to be extracted.

* Create a new rake task called `emails:extract_subjects` to iterate through all `Email` objects and attempt to extract the subject from the `body`. If a subject can be determined, it should be set as the `subject` property, otherwise, use the first 50 characters of the `body`.

  For example, the body of `Email`  __58ba8f2facce343bdc000053__ contains the following text.

      From: accounts@koronaonline.co.uk [mailto:accounts@koronaonline.co.uk] 
      Sent: 02 March 2017 12:51 
      To: Adrian Starr 
      Subject: takings 20/08/16  


* Your rake task should identify the string following "Subject: ", which in the example is "takings 20/08/16". This should be set as the `subject`.
* Some `Email` bodies will contain multiple instances of "Subject: ". In these cases uses the first instance.
* Your rake task will probably take a while to run, so it should print some fairly verbose output logs so the user who is running your task can monitor its progress.
* As a check, after running the rake task, the command `Email.where(subject: nil).count` in the Rails console should return 0, because at the very least you've used the first 50 characters of the `body`.

## Task 5 - Improve the db/seed.rb Rake Task

The `db/seed.rb` task was run during setup by the `dump:seed_data` task, but it could do with some improvements.

1. Replace the code that sets the __Postcode__ of each new Claim to generate a random postcode for each, rather than pick from the pre-defined list. _Note: The generated postcodes don't need to be valid UK postcodes, but should loosely conform to the format "??# #??", where "?" is a letter and "#" is a number._
2. Add a forth section to the seed task to create a random number of notes (between 0 and 10) for each claim. You can use the following array as note body samples:

        SAMPLE_NOTE_BODIES = [
                               "I phoned the policyholder and arranged a time to visit.",
                               "They complained about bad customer service from the call centre.",
                               "After visiting the site I arranged a follow-up visit.",
                               "Tried calling the customer all day, but I did not get a response. Will try again next week.",
                               "The customer then told me to cancel the appointment because she is going on holiday.",
                               "I'm working on my report and will deliver it by the end of this week.",
                               "This claim should be cancelled because the customer can not be reached via phone or email.",
                               "There was a complaint about workmen walking through the PH's house with dirty boots.",
                               "I advised the customer that we are dealing with his claims as quickly as possible.",
                               "The customer also phoned in to amend her address details because she has moved house."
                              ]

## Submit your Code

Once you're satisfied with your code, please send a single GitHub pull request (with any relevant comments) for us to review, by __Tuesday 11th September 2018 at 15:00__.
