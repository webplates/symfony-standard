import * as environment from 'gulp-environments';

export const config = {
    src: 'src/AppBundle/Resources/assets',
    dest: 'src/AppBundle/Resources/public',
    favicons: {
        src: '/img/symfony_logo.png',
        config: {
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
        }
    },
    fonts: 'bower_components/font-awesome/fonts/**/*.{ttf,woff,woff2,eof,svg}',
    styles: {
        browsers: [
            'ie >= 10',
            'ie_mob >= 10',
            'ff >= 30',
            'chrome >= 34',
            'safari >= 7',
            'opera >= 23',
            'ios >= 7',
            'android >= 4.4',
            'bb >= 10'
        ]
    }
};

export const env = {
    dev: environment.development,
    prod: environment.production
};

export const defaultTask = 'build';
