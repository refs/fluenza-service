var debug = process.env.NODE_ENV !== "production";
var webpack = require('webpack');

module.exports = {
  entry: "./app/assets/javascripts/index.js",
  output: {
    path: __dirname + "/app/assets/javascripts",
    filename: "bundle.js"
  }
};