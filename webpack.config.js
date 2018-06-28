const env = process.env.NODE_ENV

var path = require("path"),
    StatsPlugin = require("stats-webpack-plugin");

var devServerPort = process.env.WEBPACK_DEV_SERVER_PORT,
    devServerHost = process.env.WEBPACK_DEV_SERVER_HOST,
    publicPath = process.env.WEBPACK_PUBLIC_PATH;

var config = {
	mode: env || 'development',
  entry: './apps/web/assets/javascripts/index.js',
  output: {
    path: path.resolve(__dirname, "apps/web/assets/javascripts"),
    filename: "index_bundle.js"
  },
   module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        use: 'babel-loader'
      }
    ]
  },
  plugins: [
    new StatsPlugin("webpack_manifest.json")
  ]
};

if (process.env.INBUILT_WEBPACK_DEV_SERVER) {
  config.devServer = {
    port: devServerPort,
    headers: { "Access-Control-Allow-Origin": "*" },

  };
  config.output.publicPath = "//" + devServerHost + ":" + devServerPort + "/";
}

module.exports = config;
