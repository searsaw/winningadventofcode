const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  target: 'web',
  devtool: 'inline-source-map',
  entry: path.resolve(__dirname, './src/app.js'),
  output: {
    filename: '[name].[hash].js',
    path: path.resolve(__dirname, './dist')
  },
  module: {
    loaders: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-hot-loader!elm-webpack-loader?debug'
    }]
  },
  plugins: [
    new webpack.NamedModulesPlugin(),
    new HtmlWebpackPlugin({
      template: './src/index.html',
      hash: false,
      inject: 'body'
    })
  ]
};
