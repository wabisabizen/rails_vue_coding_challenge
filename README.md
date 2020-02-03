# Rails Coding Challenge

## Getting Started

These instructions will get a copy of the project up and running on your local machine. [Forman](https://github.com/ddollar/foreman) is used to run both servers with one command, but you can run them individually if you prefer.

### Prerequisites
* Rails 5.2+
* Ruby 2.3.1+
* sqlite3 3.19.3
* yarn 1.19.1

### Installing & Serving

1. Install dependencies
```
bundle install
yarn install
```

2. Generate and seed the db
```
rails db:create
rails db:migrate
rails db:seed
```

3. Serve the app. If successful, the app will run at `http://localhost:3000/`
```
foreman start

# You can also run the front and back manually separately, if you prefer
```

## Challenges
This app uses Rails in the backend and Vue.js in the frontend.
When completing these challenges, add any files, comments, gems or libraries you need

### 1. Models & Associations
A user can have many projects.
A user can be a manager for any project.
A project can only have 1 manager.

1. Create a new table in the database, `:project_users`. The table will have the following attributes:
    * project_id (Integer)
    * user_id (Integer)
    * Add an index to :project_id, uniquely scoped to :user_id

2. Create 2 new models called: `Project` and `ProjectUser`. Using `:project_users` as a join table, set up all our models with the following associations and validations:
    * Project
        * `:project` has_many `:users`
        * `:project` belongs_to `:manager` (where the manager is a User)
        * `:manager` is optional
        * validates `:name` must be present
        * validates `:name` must be 2 characters or longer
    * ProjectUser
        * validates presence of `:user_id` and :project_id
        * validates uniqueness of :user_id, scoped to :project_id
    * User
        * `:user` has_many `:projects`
        * `:user` has_many `:managed_projects` (where the `:manager_id` is a user id)

### 2. Routes & Controllers
We will need to be able to list, create and add users to projects through our api

1. In `routes.rb`, add new routes for `user/projects`. We need 3 actions `#create`, `#index` and `#add`.
When you run `rake routes`, you should see:

```
VERB      URI_PATTERN                         CONTROLLER#ACTION
---------------------------------------------------------------
POST      /users/:user_id/projects            projects#create
GET       /users/:user_id/projects            projects#index
POST      /users/:user_id/projects/:id/add    projects#add
```

2. Create a new controller called `ProjectsController`. In `ProjectsController`, create a `:before_action` that retrieves the User with given `:user_id` and stores it as `@user`. If the user is not found, log an error message: "User #{ params[:user_id] not found}"

3. In `ProjectsController`, write a `#create` method that does the following:
    * It uses strong params. It requires a `:project` hash, and permits only `:name` attribute
    * If the params are invalid, it logs an error message
    * If params are valid, it sets the new project's manager = `@user`, and creates the new project
    * If the params are valid, returns the newly created project as a json object

4. In `ProjectsController`, write an `#index` method that does the following: 
    * It sets `@projects` to an array of projects for the given `@user`
        * `@projects` contains all projects that the user manages OR is associated with
        * `@projects` does not contain any projects that are not associated with the user
        * `@projects` should not contain duplicate projects
    * It accepts `params[:sort]` as a filter
        * If `params[:sort] = 'name'`, return the projects sorted by name (ascending order)
        * Otherwise, return the projects by date created (newest first)
    * It returns the results as json array

### 5. Rspec Unit tests
Using rspec, write tests for some of our backend code.

1. For our `Project` model, write specs that ensure the following:
    * We validate the presence of `:name`
    * We validate that `:name must be 2 characters or longer`
    * That a project has many `:users`
    * That a project belongs to a `:manager`

2. For our `ProjectsController`, write specs that ensure the following:
    * ProjectsController#create assigns `@user` variable, and that `@user` == the User with the given `:user_id`
    * ProjectsController#index returns an array of project objects for the given user
    * In ProjectsController#index action, if `params[:sort] = 'name'`, the results are returned ordered by name (ascending)

### 4. UI & Vue components
We need to display all our users in the front end. For this example, we are pretending that our users have already been fetched from the api and are stored in our Vuex store.

Add all styles for your component to the component file itself.

Use [BEM Methodology](http://getbem.com/) in your template, if possible

1. Create a vue component in `app/javascript/packs/components` called `UserCard.vue`. Build the component to look like the card in the given mockup: `app/assets/images/mockup_user_card.png`.
    * Style spefications:
        * Card
            * dimensions: 270x350px(width x height)
            * border-radius: 4px
            * on hover: box-shadow (4px 4px 12px #DBDBDB)
        * Gradient colours: #56CCF2 and #6C56F2
        * Font: Arial, 30px, bold
        * Avatar border width: 3px
    * The card should accept `:user` as a prop
    * The name on the card should = `user.name`
    * The avatar on the card should be `user.avatar_url`

3. In our Vuex store, we have an array called `user/_list`. In `UsersIndex.vue`, reference the `user/_list` array from our store and render each user as a `UserCard` component. The user cards should be rendered inside the `.cards-container` div. The result should look similar to this mockup: `app/assets/images/mockup_users_index.png`

