<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://images.unsplash.com/photo-1499750310107-5fef28a66643?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80" alt="Laptop on desk with coffee and notepad in a cafe"></a>
</p>

<h3 align="center">JobMate</h3>

<div align="center">

  [![Status](https://img.shields.io/badge/status-inactive-inactive.svg)]()
  [![License](https://img.shields.io/github/license/kylejb/JobMate-on-Rails?style=plastic)](LICENSE)
</div>

---

<p align="center"> A better way to find and apply to jobs.
    <br>
</p>

## 📝 Table of Contents
- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Built Using](#built_using)
- [Contributing](./CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

This project is migrating to [JobMate](https://github.com/kylejb/JobMate).

## 🏁 Getting Started <a name = "getting_started"></a>
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby (version 2.7.2)
- SQLite3 ([download here](https://sqlite.org/download.html))
- Bundler (Bundler 2 or greater)

Before running the commands listed below, make sure you're shell is currently using the correct Ruby version (e.g., `which ruby` or `ruby --version` should point to "ruby-2.7.2").

If you have Bundler installed, run this command to make sure it's updated:
```
bundle update --bundler
```

If you do not have Bundler installed, run the following command to install it:
```
gem install bundler
```

### Installing

1. Clone the repo:

```
git clone https://github.com/kylejb/JobMate.git
```

2. `cd` into the project directory and run bundler to install required gems:

```
bundle install
```

3. Migrate Models to database and seed database*:

```
rails db:migrate
rails db:seed
```

*Note: feel free to modify the `db/seeds.rb` file with any test/sample data that you may need.

4. Fetch latest job postings *(this may take up to fifteen minutes)* from `indeed.com`:

```
rails app:indeed_scraper
```

5. Last, but not least... spin up server and navigate to `localhost:3000`:

```
rails s
```

## ⛏️ Built Using <a name = "built_using"></a>
- [SQLite3](https://sqlite.org) - Database
- [Ruby on Rails](https://rubyonrails.org/) - Server and Web Framework

## ✍️ Authors <a name = "authors"></a>
- [@kylejb](https://github.com/kylejb)
- [@Jeff-Adler](https://github.com/Jeff-Adler)

## 🎉 Acknowledgements <a name = "acknowledgement"></a>
- Special thanks to [@sylwiavargas](https://github.com/sylwiavargas) for her [article on web scraping](https://www.scrapingbee.com/blog/web-scraping-ruby/#kimurai-setup')
