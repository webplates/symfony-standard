var path          = require('path');
var environments  = require('gulp-environments');

module.exports = {
    src     : 'src/AppBundle/Resources/assets',
    dest    : 'src/AppBundle/Resources/public',
    dev     : environments.development,
    prod    : environments.production
};
