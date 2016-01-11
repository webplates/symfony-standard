var gulp        = require('gulp');
var del         = require('del');
var size        = require('gulp-size');
var config      = require('../config');

gulp.task('clean:fonts', function() {
    return del([config.dest + '/fonts/*']);
});

gulp.task('fonts', ['clean:fonts'], function() {
    return gulp.src('bower_components/font-awesome/fonts/**/*.{ttf,woff,woff2,eof,svg}')
        .pipe(size({title: 'fonts'}))
        .pipe(gulp.dest(config.dest + '/fonts'));
});
