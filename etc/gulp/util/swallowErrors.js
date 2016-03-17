import * as notify from "gulp-notify";

export default function swallowError(error) {
    notify(error);
    this.emit('end');
}
