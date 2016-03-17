export default class BuildTask {
    static configure(gulp, config, env) {
        gulp.task('build', ['styles', 'scripts', 'fonts', 'images', 'favicons']);
    }
}
