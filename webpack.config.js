const path = require('path');

var config = {
  entry: './apps/web/assets/javascripts/main.js',
  output: {
    path: path.resolve(__dirname, 'apps/web/assets/javascripts'),
    filename: "bundle.js"
  },
   module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        use: 'babel-loader'
      }
    ]
  }
};

module.exports = config;
