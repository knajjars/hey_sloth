import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['profileOptions', 'profileButton']
    }

    static classes = ["hidden"]


    clickOutsideProfile(event) {
        if (this.profileButtonTarget === event.target || this.profileButtonTarget.contains(event.target)) return;
        if (!this.profileOptionsTarget.classList.contains(this.hiddenClass)) {
            this.profileOptionsTarget.classList.add(this.hiddenClass)
        }
    }

    openProfile() {
        this.profileOptionsTarget.classList.toggle(this.hiddenClass)
    }
}