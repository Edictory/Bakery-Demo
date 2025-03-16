[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/ZPJYD86M)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18289378&assignment_repo_type=AssignmentRepo)
# 67-272: RDP Project - Phase 3

We will continue our project to develop a foundation for the Roi du Pain online bakery system in this phase. We will focus our efforts on building out the models for the remaining entities given to you in this phase's ERD in `docs/rdp_erd_p3.pdf` and adding all necessary business logic. In addition, you will have to write unit tests for all models and ensure that test coverage is complete.

We will also be doing some authentication and authorization for the system, using test-driven development.

**Grading**

This phase will constitute 18 percent of your final course grade and is broken down into the following components:

1. **Creation of Models**: Models for the entities listed in the ERD found in this project's `docs` directory need to be created. Also, in the `docs` directory, you are given a spec sheet on essential methods each model must have; those methods must be fully implemented. The project must be **using Rails 7.0.4 and Ruby 3.1.4**

2. **Unit Testing**: Unit tests for all methods in all models must be written and fully passing. We will check to ensure there is 100 percent code coverage for unit tests using the `simplecov` gem used in class and lab. Because `simplecov` suffers from some false positives (as mentioned in class), we may spot-check tests to ensure specific tests were included. Only the models and services in this phase need complete coverage. There are steep penalties for less than 100 percent coverage and no credit at all for less than 90 percent coverage.

3. **Additional Testing**: To expose you to more test-driven development, we are giving you the following testing challenges:

- For authorization, we've given you a working context and a set of tests that describe the authorizations of each role. Read through these materials and build an `app/models/ability.rb` file that will pass these tests.

- For services, we need to develop two service objects -- one that will assist with baking issues (namely, generating the daily baking lists) and another that will assist with shipping (focused for now on calculating shipping costs). For the baking service, we have given you both the code and the tests. For the shipping service, we have provided a set of tests provided; we are asking you to review these tests and create the service object that will pass these tests.

**Checkpoints**

Due to spring break, there are only two checkpoints, one before and one after spring break.

1. On **Thursday, February 27th**, all additional models are generated and relationships between models are set up and tested. In addition, a new migration (do **NOT** edit the existing customer migration) that adds the `user_id` to `Customer` must be generated. Furthermore, the order model should be changed so that rather than validating the date of the order, a callback is used to set the order date to the current date upon creation (do not run the callback for update actions, only create actions; do you recall from class why this requirement?). This new callback should be tested.

2. On **Sunday, March 16th**, in addition to the previous checkpoint working, all scopes for all models must be working and tested. In addition, an `app/models/ability.rb` is created and all tests related to authorization and abilities pass.

All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified. We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass. Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. Note that in the models we've given you, we use a series of helpers that allow us to not have to copy-paste certain methods, such as `make_inactive` and `is_active_in_system`, and keep our code cleaner. You are welcome to use these helpers yourself (and cut back on the copy-paste-modify routine) and can see the code for this in `lib/helpers` if you want to study it more for yourself. You are also free to continue copy-pasting code if you prefer and are comfortable with the risk of error.

2. Note that for this phase we have given you a working context, that when your models are generated and relationships between them established, the context should build without issue. This is the context we used to create and test the solution, so it should work fine for you. If you'd rather build your own context, feel free to scrap ours and redo it yourself. As you generate and connect your models, you can uncomment the appropriate lines in the `create_all` context method found in `test/contexts.rb` file and re-run the `rails db:contexts` command in the terminal.

    With regard to the contexts, you should note in the `customers` context, there is a set of customers without an associated user (to pass the initial tests) and a set with an associated user that is commented out for now.  When you have created the `User` model and established the relationship to `Customer`, you should comment out the old context and comment back in the updated context.  Likewise, you will have to adjust some of the customer tests once `User` is created and linked to `Customer`.

3. For the `Order` model to be complete, you will need the credit card model code you developed in Lab 8. Just as we gave you tests for credit cards in lab, so we are also giving you tests for the credit card model in the starter code.  You will need to add this code from lab before fully getting the `Order` model to work properly.

4. In the case of the Shipping service, we should note that in order to be competitive, Roi du Pain initially plans to greatly subsidize shipping costs. At this early stage, their plan is to have a base charge of just $2.00 shipping per order, and only add to that base charge after the weight goes over 5 pounds. (However, they also plan on truncating down the weight to the nearest integer, so effectively the allowed weight is just a shade under 6 pounds; see the tests for examples of this.) Even then, the initial plan is to only charge $0.25 per pound over the allowed weight. While we could hard-code these values into our Shipping service, since we know Roi du Pain wants to increase those charges in the future, we want to create this service so that allowed weight, the base shipping cost, and the incremental cost per pound can be easily adjusted down the line; the tests for this service should demonstrate how those adjustments would be handled.

5. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate model ...` in creating your models for this phase. Scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

6. If we have installed a gem in the `Gemfile`, then use the version we've specified. While you shouldn't need any additional gems this phase, you are welcome to add in additional gems that you find useful and compatible with the rest of the gems.

7. You will notice that we have refactored our tests for each model into smaller test files. This makes it easier to work with and debug tests, in addition to making it easier for the autograder to give you partial credit. You can continue this practice, or simply add all new tests to the appropriate model file (if it's not too confusing). While we encourage you to refactor and split up your tests in this same way, it is not a requirement of this phase.

8. As you write migrations to modify some previous models, you will note that the relationships will change. This requires not only changing the model file(s) but also the related test files.

9. Doing the checkpoints will keep you from getting too far behind, **but _only_ doing the minimum each week will pretty much ensure a miserable final week and/or a low project score.** The path of coding and testing relationships first, then scopes, then other methods is highly recommended, and the checkpoints lead you in that path. But the other methods become tricky and there are lots of dependencies, so waiting until the last week to do them all can lead to lots of stress in that last week. Additionally, if unfortunate life incidents pop up in the last week (or weekend) you risk losing major points because you weren't able to complete this on time. (No extensions will be given on this phase as the starter code for the next phase is released the next day.) Our advice is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 3**

This project should be turned in via your private repository on GitHub **before 11:59 pm (EST) on Sunday, March 23th, 2025**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. Again, the solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
