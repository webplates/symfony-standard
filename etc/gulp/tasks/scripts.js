import del from 'del';
import size from 'gulp-size';
import buffer from 'vinyl-buffer';
import uglify from 'gulp-uglify';
import source from 'vinyl-source-stream';
import sourcemaps from 'gulp-sourcemaps';
import browserify from 'browserify';
import debowerify from 'debowerify';
import babelify from 'babelify';

export default class ScriptTask {
    static configure(gulp, config, env) {
        gulp.task('clean:scripts', () => {
            return del([config.dest + '/js/*']);
        });

        gulp.task('scripts', ['clean:scripts'], () => {
            var b = browserify({
                entries: config.src + '/js/app.js',
                debug: true
            }).transform(babelify, {presets: ['es2015']});

            return b.bundle()
                .pipe(source('app.js'))
                .pipe(buffer())
                .pipe(env.dev(sourcemaps.init({loadMaps: true})))
                .pipe(env.prod(uglify()))
                .pipe(size({title: 'scripts'}))
                .pipe(env.dev(sourcemaps.write('./')))
                .pipe(gulp.dest(config.dest + '/js'));
        });
    }
}
