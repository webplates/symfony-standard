var gulp     = require('gulp');
var config   = require('../config');
var del      = require('del');
var size     = require('gulp-size');
var favicons = require('gulp-favicons');

gulp.task('clean:favicons', function() {
    return del([
        'web/android-chrome-*.png',
        'web/apple-touch-*.png',
        'web/browserconfig.xml',
        'web/coast-*.png',
        'web/favicon.ico',
        'web/favicon-*.png',
        'web/firefox_app_*.png',
        'web/manifest.json',
        'web/manifest.webapp',
        'web/mstile-*.png',
        'web/open-graph.png',
        'web/twitter.png',
        'web/yandex-*.png',
        'web/yandex-browser-manifest.json'
    ]);
});

gulp.task('favicons', ['clean:favicons'], function () {
    return gulp.src(config.src + '/img/symfony_logo.png')
        .pipe(favicons({
            appName: 'Symfony',
            appDescription: 'This is my application',
            background: '#ffffff',
            path: '/',
            url: '/',
            display: 'standalone',
            orientation: 'portrait',
            version: 1.0,
            logging: false,
            online: false,
            html: 'app/Resources/views/favicons.html.twig'
        }))
        .pipe(size({title: 'favicons'}))
        .pipe(gulp.dest('web/'));
});