# Incubit ROR Assesment

|   |  |
| ------------- | ------------- |
| **Ruby Version**  | 2.6.0    |
| **Rails Version** | 5.2.3    |
| **Database**      | PostgreSQL |
| **Prerequisites** | RVM, nodejs (Javascript Runtime), Bundler |


## Installation

* Install ruby version

```
rvm install 2.6.0
```

* Connect to PostgreSQL database

```
sudo -u postgres psql
```

* Create user `incubit`

```
CREATE USER incubit WITH CREATEDB PASSWORD '1234';
```

* Clone this repository

```
git clone https://github.com/ashish-agrawal-metacube/IncubitAssessment.git
```

* Install dependencies

```
cd IncubitAssessment
bundle install
```

* Configure environment variables (This creates a commented config/application.yml file)

```
bundle exec figaro install
```

* Open `config/application.yml` and add following values in this file (make sure your DB credentials and localhost server url are correct in this file):

```
development:
  DATABASE_USERNAME: "incubit"
  DATABASE_PASSWORD: "1234"
  DATABASE_HOST: "localhost"

  HOST_URL: "localhost:3000"

test:
  DATABASE_USERNAME: "incubit"
  DATABASE_PASSWORD: "1234"
  DATABASE_HOST: "localhost"
```

* Create database and run migrations

```
rails db:setup
```

* Run development server

```
rails s
```

* Run tests

```
rspec spec/models
rspec spec/controllers
```
