# Recipe Vault

## Description

Recipe Vault is a CLI platform that allows users to create, save and share recipes with other users. Recipe Vault also serves as a recipe-search engine, giving users the option to search for a recipe based on the recipe name or their ingredients.

## Install Instructions

1. Clone or Fork this repository
2. Run 'bundle install' on command line
3. Run 'ruby bin/run.rb' to start

## Deliverables
### User
* User will be able to create a login account
* User will be able to create multiple recipes
* User will be able to store multiple recipes to a personal list
* User will be able to search recipes through the app
  * should be able to see the recipe name
  * Should be able to see the recipe description 
  * Should be able to see the recipe ingridients
* User will be able to select a recipe and store it to a personal list
### Recipe
* Recipe will be stored in a database
  * Recipe will contain a name
  * Recipe will contain a description
  * Recipe will contain multiple ingridients
* Recipe will have a many to many relationship with Ingridient
### Ingridient
* Ingridient will be stored in a database
  * Ingridient will contain a name
* Ingridient will have a many to many relationship with Ingridient

