// registration.js

document.addEventListener("DOMContentLoaded", function () {

    // ==============================
    // Password Show / Hide
    // ==============================

    const toggle = document.getElementById("toggle");
    const password = document.getElementById("pwd");

    if (toggle && password) {

        toggle.addEventListener("click", function () {

            if (password.type === "password") {
                password.type = "text";
                toggle.textContent = "🙈";
            } else {
                password.type = "password";
                toggle.textContent = "👁";
            }

        });

    }


    // ==============================
    // Form Submit Loading Animation
    // ==============================

    const form = document.querySelector("form");
    const button = document.querySelector("button");

    if (form && button) {

        form.addEventListener("submit", function () {

            button.disabled = true;
            button.innerHTML = "⏳ Creating Account...";

        });

    }


    // ==============================
    // Button Ripple Effect
    // ==============================

    const btn = document.querySelector("button");

    if (btn) {

        btn.addEventListener("click", function (e) {

            const ripple = document.createElement("span");

            const diameter = Math.max(btn.clientWidth, btn.clientHeight);
            const radius = diameter / 2;

            ripple.style.width = ripple.style.height = diameter + "px";

            ripple.style.left =
                e.clientX - btn.getBoundingClientRect().left - radius + "px";

            ripple.style.top =
                e.clientY - btn.getBoundingClientRect().top - radius + "px";

            ripple.classList.add("ripple");

            const oldRipple = btn.getElementsByClassName("ripple")[0];

            if (oldRipple) {
                oldRipple.remove();
            }

            btn.appendChild(ripple);

        });

    }


    // ==============================
    // Floating Card Animation
    // ==============================

    const card = document.querySelector(".glass-card");

    if (card) {

        let angle = 0;

        setInterval(function () {

            angle += 0.02;

            card.style.transform =
                "translateY(" +
                Math.sin(angle) * 6 +
                "px)";

        }, 20);

    }


    // ==============================
    // Input Glow Effect
    // ==============================

    const inputs = document.querySelectorAll(
        "input, textarea, select"
    );

    inputs.forEach(function (input) {

        input.addEventListener("focus", function () {

            input.style.boxShadow =
                "0 0 15px rgba(217, 83, 51, 0.2)";

        });

        input.addEventListener("blur", function () {

            input.style.boxShadow = "none";

        });

    });


    // ==============================
    // Smooth Fade-in Animation
    // ==============================

    const elements = document.querySelectorAll(
        ".left-panel, .glass-card"
    );

    elements.forEach(function (el, index) {

        el.style.opacity = "0";
        el.style.transform = "translateY(40px)";

        setTimeout(function () {

            el.style.transition = "0.8s ease";

            el.style.opacity = "1";
            el.style.transform = "translateY(0px)";

        }, index * 250);

    });

});