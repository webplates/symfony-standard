var notify = require("gulp-notify");

module.exports = function swallowError (error) {
    notify(error);
    this.emit('end');
};
