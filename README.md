#### The Solution

I've implemented a solution that uses Ruby, Sequel (gem) and Sqlite3.

#### Setup

I recommend using RVM with gemsets (even though I had an issue with RVM/Bundler/something not using what it should have; generally it is pretty seamless to use).

Some systems may need to prefix `rake` and `bin` commands with `bundle exec`.

The project uses bundler so setup should be as simple as:

```
gem install bundler
bundle install
rake db:migrate
```

You can open up a console:

```
bin/console
```

and add a few products

```
(1..4).map do |num|
  Product.create title: "product #{num}", available_inventory: 10 * num, price: 20.02 * num
end
```

#### Usage

The main entry point for the api is `bin/api` and takes two command line parameters: the action and a json param string. Errors are printed to STDERR and response json is printed to STDOUT. A nonzero exit status code means the request has an error.

Here are the possible actions with required json keys and STDOUT responses:

 * add
   * requires: `user_id`, `product_id`, `quantity`
   * prints json of current cart
   * example: `bin/api add '{"user_id": 1, "product_id": 1, "quantity": 1}'`
 * remove
   * requires: `user_id`, `product_id`
   * prints json of current cart
   * example: `bin/api remove '{"user_id": 1, "product_id": 1}'`
 * cart
   * requires: `user_id`
   * prints json of current cart
   * example:  `bin/api cart '{"user_id": 1}'`
 * purchase
   * requires: `user_id`
   * nothing printed to STDOUT
   * example:  `bin/api purchase '{"user_id": 1}'`
 * history
   * requires: `user_id`
   * prints json hash of past purchases, keyed by date
   * example: ` bin/api history '{"user_id": 1}'` 

#### More

Developed with RVM and Ruby 2.4.1

Please let me know if you have any questions.
