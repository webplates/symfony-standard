var gulp = require('gulp');
var pluginLoader = require('gulp-load-plugins');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var del = require('del');

// Gulp plugins
var $g = pluginLoader();

// PostCSS plugins
var $p = pluginLoader({
    pattern: ['postcss-*', 'postcss.*', 'autoprefixer', 'cssnano', 'stylelint'],
    replaceString: /^postcss(-|\.)/
});

// Imagemin plugins
var $i = pluginLoader({
    pattern: ['imagemin-*', 'imagemin.*'],
    replaceString: /^imagemin(-|\.)/
});

// Environmant
var dev = $g.environments.development;
var prod = $g.environments.production;

var browserify = require('browserify');
var debowerify = require('debowerify');

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

var src = 'src/AppBundle/Resources/assets';
var dest = 'src/AppBundle/Resources/public';


gulp.task('clean', function() {
    return del([dest + '/*']);
});

gulp.task('clean:styles', function() {
    return del([dest + '/css/*']);
});

gulp.task('clean:scripts', function() {
    return del([dest + '/js/*']);
});

gulp.task('clean:fonts', function() {
    return del([dest + '/fonts/*']);
});

gulp.task('clean:images', function() {
    return del([dest + '/img/*']);
});

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

gulp.task('styles', ['clean:styles'], function () {
    var processors = [
        $p.bemLinter(),
        $p.stylelint(),
        $p.autoprefixer(AUTOPREFIXER_BROWSERS)
    ];

    if (prod()) {
        processors.push($p.cssnano());
    }

    processors.push($p.reporter());

    return gulp.src(src + '/scss/style.scss')
        .pipe(dev($g.sourcemaps.init({loadMaps: true})))
        .pipe($g.sass().on('error', $g.sass.logError))
        .pipe($g.postcss(processors))
        .pipe($g.size({title: 'styles'}))
        .pipe(dev($g.sourcemaps.write('./')))
        .pipe(gulp.dest(dest + '/css'));
});

gulp.task('scripts', ['clean:scripts'], function () {
    var b = browserify({
        entries: src + '/js/app.js',
        debug: true,
        transform: [debowerify]
    });

    return b.bundle()
        .pipe(source('app.js'))
        .pipe(buffer())
        .pipe(dev($g.sourcemaps.init({loadMaps: true})))
        .pipe(prod($g.uglify()))
        .pipe($g.size({title: 'scripts'}))
        .pipe(dev($g.sourcemaps.write('./')))
        .pipe(gulp.dest(dest + '/js'));
});

gulp.task('fonts', ['clean:fonts'], function() {
    return gulp.src('bower_components/font-awesome/fonts/**/*.{ttf,woff,woff2,eof,svg}')
        .pipe($g.size({title: 'fonts'}))
        .pipe(gulp.dest(dest + '/fonts'));
});

gulp.task('images', ['clean:images'], function() {
    return gulp.src(src + '/img/**/*.{png,svg,jpg,gif}')
        .pipe($g.imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [
                $i.gifsicle(),
                $i.jpegtran(),
                $i.optipng(),
                $i.pngquant()
            ]
        }))
        .pipe($g.size({title: 'images'}))
        .pipe(gulp.dest(dest + '/img'));
});

gulp.task('favicons', ['clean:favicons'], function() {
    return gulp.src(src + '/img/symfony_logo.png')
        .pipe($g.favicons({
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
        .pipe($g.size({title: 'favicons'}))
        .pipe(gulp.dest('web/'));
});

gulp.task('watch', function() {
    gulp.watch(src + '/scss/**/*.scss', ['styles']);
    gulp.watch(src + '/js/**/*.js', ['scripts']);
});

gulp.task('build', ['styles', 'scripts', 'fonts', 'images', 'favicons']);
gulp.task('default', ['build']);
