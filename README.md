# How to start the Service in Development

### Dependencies 📦

- [`yarn`](https://github.com/yarnpkg/yarn#installing-yarn)

### Starting 🚀

1. Go to your fluenza-service path
2. `yarn install`
3. `yart start`

## TODOs 📝

`webpack-dev-server` serve files from memory, meaning files won't be recompiled, to do so once you start playing around in development make sure you build again by runing `webpack`. Alternatively you can open a new console session and run `webpack --watch` to have all files up to date. To prevent this, this has to be done:

- [Enable Hot Module Replacement [HMR]](https://survivejs.com/webpack/developing/webpack-dev-server/)

## Hot to get things up and runing 🎢

For this you would need 2 console sessions (or alternatively a Docker process with the backend running *[TODO]*). Assuming you're in the root level:

- `rails s` (loads the compiled assets into the Rails Assets Pipeline)
- `yarn start`

# Notes on Architecture 🏗

To streamline the development experience isolate frontend and API. Things that need to be done:

- Remove all the views from the API
- Remove the index page from the API
- `Bai Bai Heroku` 👋, we deploy to google cloud with containers
- Isolate the Manager from the service and include it via [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
- Containerize the backend (let's call it *API*) 🐳
- Containerize the frontend (let's call it *Manager*) 🐳
- Containerize the database 🐳


# Conventions

- [Block-Element-Modifier css convention](http://getbem.com/naming/)
- [Ruby styleguide](https://github.com/bbatsov/ruby-style-guide)
