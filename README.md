# Customer Management App

A simple **Ruby on Rails 7 application** for managing customers, with full CRUD functionality, pagination, sorting, and validations.

---

## Features

- Create, read, update, and delete customers  
- Validations for presence, uniqueness (`first_name + last_name`), and `date_of_birth` not in the future  
- Paginated customer listing using [Kaminari](https://github.com/kaminari/kaminari)  
- Sortable columns (`first_name`, `last_name`, `phone_number`, `date_of_birth`)  
- Flash messages with Bootstrap 5 alerts  
- Responsive UI with Bootstrap 5  

---

## Requirements

- Ruby **3.1+**  
- Rails **7.0.8.7**  
- SQLite3 (used for this simple demo, see `database.yml`)

---

## Setup

1. **Clone the repository:**

```bash
git clone git@github.com:aldrienht/customer_management_app.git
cd customer_management_app
```

2. **Install Ruby gems:**
```
bundle install
```

3. **Set up the database:**
```
rails db:create
rails db:migrate
```

## Running the App

1. Start the Rails server:

`rails server`


2. Open your browser and navigate to:

`http://localhost:3000/`

## Testing

RSpec is used for testing models and controllers.

* Run all tests:

`bundle exec rspec`

* Run a specific spec file:

```
bundle exec rspec spec/models/customer_spec.rb
bundle exec rspec spec/controllers/customers_controller_spec.rb
```
