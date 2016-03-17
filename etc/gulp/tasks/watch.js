export default class WatchTask {
    static configure(gulp, config, env) {
        gulp.task('watch', () => {
            gulp.watch(config.src + '/scss/**/*.scss', ['styles']);
            gulp.watch(config.src + '/js/**/*.js', ['scripts']);
        });
    }
}
