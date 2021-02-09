import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['profileOptions', 'profileButton', 'mobileMenu', 'menuOpenIcon', 'menuCloseIcon', 'collectButton', 'collectOptions']
    }

    static classes = ["hidden"]


    clickOutsideProfile(event) {
        if (this.profileButtonTarget === event.target || this.profileButtonTarget.contains(event.target)) return;
        if (!this.profileOptionsTarget.classList.contains(this.hiddenClass)) {
            this.profileOptionsTarget.classList.add(this.hiddenClass)
        }
    }

    toggleProfile() {
        this.profileOptionsTarget.classList.toggle(this.hiddenClass)
    }

    toggleMobileMenu() {
        this.mobileMenuTarget.classList.toggle(this.hiddenClass)
        this.menuOpenIconTarget.classList.toggle(this.hiddenClass)
        this.menuCloseIconTarget.classList.toggle(this.hiddenClass)
    }

    clickOutsideCollect(event) {
        if (this.collectButtonTarget === event.target || this.collectButtonTarget.contains(event.target)) return;
        if (!this.collectOptionsTarget.classList.contains(this.hiddenClass)) {
            this.collectOptionsTarget.classList.add(this.hiddenClass)
        }
    }

    toggleCollect() {
        this.collectOptionsTarget.classList.toggle(this.hiddenClass)
    }

}