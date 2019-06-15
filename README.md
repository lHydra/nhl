# NHL

## Description

Тестовое задание.

## Steps to start this application:

**Download project**

```
git@github.com:lHydra/nhl.git
```

**Start bundle install**

```
bundle install
```

**Create Database**

```
rake db:create
rake db:migrate
```

**Start rake task to parse nhlnumbers**

```
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
