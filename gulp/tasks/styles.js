var gulp         = require('gulp');
var del          = require('del');
var size         = require('gulp-size');
var sass         = require('gulp-sass');
var sourcemaps   = require('gulp-sourcemaps');
var postcss      = require('gulp-postcss');
var config       = require('../config');
var pluginLoader = require('gulp-load-plugins');

gulp.task('clean:styles', function() {
    return del([config.dest + '/css/*']);
});

gulp.task('styles', ['clean:styles'], function () {
    // PostCSS plugins
    var postCSS = pluginLoader({
        pattern: ['postcss-*', 'postcss.*', 'autoprefixer', 'cssnano', 'stylelint'],
        replaceString: /^postcss(-|\.)/
    });

    var AUTOPREFIXER_BROWSERS = [
        'ie >= 10',
        'ie_mob >= 10',
        'ff >= 30',
        'chrome >= 34',
        'safari >= 7',
        'opera >= 23',
        'ios >= 7',
        'android >= 4.4',
        'bb >= 10'
    ];

    var processors = [
        postCSS.bemLinter(),
        // config.postCSS.stylelint(),
        postCSS.autoprefixer(AUTOPREFIXER_BROWSERS)
    ];

    if (config.prod) {
        processors.push(postCSS.cssnano());
    }

    processors.push(postCSS.reporter());

    return gulp.src(config.src + '/scss/style.scss')
        .pipe(config.dev(sourcemaps.init({loadMaps: true})))
        .pipe(sass().on('error', sass.logError))
        .pipe(postcss(processors))
        .pipe(size({title: 'styles'}))
        .pipe(config.dev(sourcemaps.write('./')))
        .pipe(gulp.dest(config.dest + '/css'));
});
