var gulp         = require('gulp');
var del          = require('del');
var imagemin     = require('gulp-imagemin');
var size         = require('gulp-size');
var config       = require('../config');
var pluginLoader = require('gulp-load-plugins');

var $i = pluginLoader({
    pattern: ['imagemin-*', 'imagemin.*'],
    replaceString: /^imagemin(-|\.)/
});

gulp.task('clean:images', function() {
    return del([config.dest + '/img/*']);
});

gulp.task('images', ['clean:images'], function() {
    return gulp.src(config.src + '/img/**/*.{png,svg,jpg,gif}')
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [
                $i.gifsicle(),
                $i.jpegtran(),
                $i.optipng(),
                $i.pngquant()
            ]
        }))
        .pipe(size({title: 'images'}))
        .pipe(gulp.dest(config.dest + '/img'));
});
