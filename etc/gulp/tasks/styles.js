import del from 'del';
import size from 'gulp-size';
import sass from 'gulp-sass';
import sourcemaps from 'gulp-sourcemaps';
import postcss from 'gulp-postcss';
import pluginLoader from 'gulp-load-plugins';

export default class StyleTask {
    static configure(gulp, config, env) {
        gulp.task('clean:styles', () => {
            return del([config.dest + '/css/*']);
        });

        gulp.task('styles', ['clean:styles'], () => {
            // PostCSS plugins
            var postCSS = pluginLoader({
                pattern: ['postcss-*', 'postcss.*', 'autoprefixer', 'cssnano', 'stylelint'],
                replaceString: /^postcss(-|\.)/
            });

            var processors = [
                postCSS.bemLinter(),
                // postCSS.stylelint(),
                postCSS.autoprefixer(config.styles.browsers)
            ];

            if (env.prod) {
                processors.push(postCSS.cssnano());
            }

            processors.push(postCSS.reporter());

            return gulp.src(config.styles.src)
                .pipe(env.dev(sourcemaps.init({loadMaps: true})))
                .pipe(sass().on('error', sass.logError))
                .pipe(postcss(processors))
                .pipe(size({title: 'styles'}))
                .pipe(env.dev(sourcemaps.write('./')))
                .pipe(gulp.dest(config.dest + '/css'));
        });
    }
}
