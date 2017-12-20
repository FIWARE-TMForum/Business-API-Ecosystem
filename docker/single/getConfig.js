const config = require('./etc/config.js');

const availableConf = {
    mongohost: config.mongoDb.server,
    mongoport: config.mongoDb.port,
    glasshost: config.endpoints.inventory.host,
    glassport: config.endpoints.inventory.port,
    glassprot: config.endpoints.inventory.appSsl ? 'https' : 'http',
    glasspath: config.endpoints.inventory.path
};

console.log(availableConf[process.argv[2]]);

