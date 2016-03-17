import del from 'del';

export default class CleanTask {
    static configure(gulp, config, env) {
        gulp.task('clean', () => {
            return del([config.dest + '/*']);
        });
    }
}
