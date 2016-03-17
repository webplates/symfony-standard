import $ from 'jquery';

window.$ = window.jQuery = $;

class App {
    constructor ($) {
        this.$ = $;
    }

    init () {
        console.log('Loaded');
    }
}

const app = new App($);

$(document).ready(() => {
    app.init();
});
