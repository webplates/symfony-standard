var gulp        = require('gulp');
var del         = require('del');
var size        = require('gulp-size');
var buffer      = require('vinyl-buffer');
var uglify      = require('gulp-uglify');
var source      = require('vinyl-source-stream');
var sourcemaps  = require('gulp-sourcemaps');
var config      = require('../config');
var browserify  = require('browserify');
var debowerify  = require('debowerify');

gulp.task('clean:scripts', function() {
    return del([config.dest + '/js/*']);
});

gulp.task('scripts', ['clean:scripts'], function () {
    var b = browserify({
        entries: config.src + '/js/app.js',
        debug: true,
        transform: [debowerify]
    });

    return b.bundle()
        .pipe(source('app.js'))
        .pipe(buffer())
        .pipe(config.dev(sourcemaps.init({loadMaps: true})))
        .pipe(config.prod(uglify()))
        .pipe(size({title: 'scripts'}))
        .pipe(config.dev(sourcemaps.write('./')))
        .pipe(gulp.dest(config.dest + '/js'));
});