# Quantified Self Back-end Rails

## Initial Setup

1. Clone this repository and rename the repository to `qs_rails` in one command

  ```shell
  https://shebesabrina.github.io/quantified-self-fe/index.html
  ```
2. Change directory into the `qs_rails` directory
  ```
  cd qs_rails
  ```

3. Install the dependencies

  ```shell
  bundle
  ```

3. Set up the database

  ```shell
  rake db:create
  rake db:migrate
  rake db:seed
  ```

4. Run test suite

  ```shell
    rspec
  ```

## Running the Server Locally

To see your code in action locally, you need to fire up a development server. Use the command:

```shell
rails s
```

Once the server is running, visit API endpoints in your browser:

* `http://localhost:3000/` to run your application. Enpoints are available in the * [Project Spec](http://backend.turing.io/module4/projects/quantified_self/quantified_self_rails)

## Deployed
* Back end is deployed here: https://qs-rails-mine.herokuapp.com/api/v1/foods

* To see the [front end] visit: (https://shebesabrina.github.io/quantified-self-fe/index.html)
