const { environment } = require('@rails/webpacker')

// 以下、BootStrapのため追記
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)
// ここまで、BootStrapのため追記


module.exports = environment
