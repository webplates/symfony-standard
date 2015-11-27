var gulp = require('gulp');
var pluginLoader = require('gulp-load-plugins');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var del = require('del');

var $g = pluginLoader();

var $p = pluginLoader({
    pattern: ['postcss-*', 'postcss.*', 'autoprefixer', 'cssnano'],
    replaceString: /^postcss(-|\.)/
});

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
    return del([dest + '/scss/*']);
});

gulp.task('clean:fonts', function() {
    return del([dest + '/fonts/*']);
});

gulp.task('clean:scripts', function() {
    return del([dest + '/js/*']);
});

gulp.task('styles', ['clean:styles'], function () {
    var processors = [
        $p.autoprefixer(AUTOPREFIXER_BROWSERS)
    ];

    if (prod()) {
        processors.push($p.cssnano());
    }

    return gulp.src(src + '/scss/style.scss')
        .pipe(dev($g.sourcemaps.init({loadMaps: true})))
        .pipe($g.sass().on('error', $g.sass.logError))
        .pipe($g.postcss(processors))
        .pipe($g.size({title: 'styles'}))
        .pipe(dev($g.sourcemaps.write('./')))
        .pipe(gulp.dest(dest + '/css'));
});


gulp.task('fonts', ['clean:fonts'], function() {
    return gulp.src('bower_components/font-awesome/fonts/**/*.{ttf,woff,eof,svg}')
        .pipe(gulp.dest(dest + '/fonts'));
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

gulp.task('watch', function() {
    gulp.watch(src + '/scss/**/*.scss', ['styles']);
    gulp.watch(src + '/js/**/*.js', ['scripts']);
});

gulp.task('build', ['styles', 'fonts', 'scripts']);
gulp.task('default', ['build']);
