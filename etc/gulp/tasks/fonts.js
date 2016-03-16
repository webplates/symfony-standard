import del from 'del';
import size from 'gulp-size';

export default class FontTask {
    static configure(gulp, config, env) {
        gulp.task('clean:fonts', () => {
            return del([config.dest + '/fonts/*']);
        });

        gulp.task('fonts', ['clean:fonts'], () => {
            return gulp.src(config.fonts)
                .pipe(size({title: 'fonts'}))
                .pipe(gulp.dest(config.dest + '/fonts'));
        });

    }
}
