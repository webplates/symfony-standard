var fs          = require('fs');
var onlyScripts = require('./util/scriptFilter');
var tasks       = fs.readdirSync('./etc/gulp/tasks/').filter(onlyScripts);

tasks.forEach(function(task) {
    require('./tasks/' + task);
});
