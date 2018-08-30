# NHL

## Steps to start this application:

**Database creation and filling**

Download project

```
git@github.com:lHydra/nhl.git
```

Start bundle install

```
bundle install
```

Start rake tasks.

```
rake db:create
rake db:migrate
rake parse:nhlnumbers
```

If your provider deny access to nhlnumbers, then put proxy to rake task

```
rake 'parse:nhlnumbers[http://ip:port]'
```


**Start the application**

```
rails server
```

Open link in your browser: `http://localhost:3000`

Congratulations!
