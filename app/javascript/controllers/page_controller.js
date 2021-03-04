import {Controller} from 'stimulus'

export default class extends Controller {
    connect() {

        const navMenuDiv = document.getElementById("nav-content");
        const navMenu = document.getElementById("nav-toggle");

        document.onclick = check;

        function check(e) {
            const target = (e && e.target) || (event && event.srcElement);

            if (!checkParent(target, navMenuDiv)) {
                if (checkParent(target, navMenu)) {
                    if (navMenuDiv.classList.contains("hidden")) {
                        navMenuDiv.classList.remove("hidden");
                    } else {
                        navMenuDiv.classList.add("hidden");
                    }
                } else {
                    navMenuDiv.classList.add("hidden");
                }
            }
        }

        function checkParent(t, elm) {
            while (t.parentNode) {
                if (t === elm) {
                    return true;
                }
                t = t.parentNode;
            }
            return false;
        }


        const links = document.querySelectorAll("#header ul a");
        for (const link of links) {
            link.addEventListener("click", clickHandler);
        }

        function clickHandler(e) {
            e.preventDefault();
            const href = this.getAttribute("href");
            const offsetTop = document.querySelector(href).offsetTop;

            scroll({
                top: offsetTop,
                behavior: "smooth"
            });
        }
    }
}