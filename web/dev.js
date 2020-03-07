const ParcelProxyServer = require('parcel-proxy-server')

const PORT = 4001
const HMR_PORT = 4002

// configure the proxy server
const server = new ParcelProxyServer({
  entryPoint: 'src/index.html',
  parcelOptions: {
    hmrPort: HMR_PORT,
    autoInstall: false
  },
  proxies: {
    '/graphql': {
      target: 'http://app:4000/graphql'
    }
  }
})

// the underlying parcel bundler is exposed on the server
// and can be used if needed
server.bundler.on('buildEnd', () => {
  console.log('Build completed!');
})

// start up the server
server.listen(PORT, () => {
  console.log('Parcel proxy server has started');
})
