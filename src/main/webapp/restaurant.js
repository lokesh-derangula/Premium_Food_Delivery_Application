// ================================
// Navbar Styling on Scroll
// ================================

const navbar = document.getElementById("navbar");

window.addEventListener("scroll", function () {
    if (!navbar) return;

    if (window.scrollY > 50) {
        navbar.classList.add("scrolled");
    } else {
        navbar.classList.remove("scrolled");
    }
});


// ================================
// Search Section Toggle
// ================================

const navSearchBtn = document.getElementById("nav-search-btn");
const searchSection = document.getElementById("search-section");
const searchInput = document.getElementById("search");

if (navSearchBtn && searchSection && searchInput) {
    navSearchBtn.addEventListener("click", function (e) {
        e.preventDefault();
        
        if (searchSection.style.display === "none") {
            searchSection.style.display = "flex";
            searchSection.scrollIntoView({ behavior: "smooth", block: "center" });
            setTimeout(() => searchInput.focus(), 500);
        } else {
            searchSection.style.display = "none";
        }
    });
}


// ================================
// Restaurant Search Filter
// ================================

if (searchInput) {
    searchInput.addEventListener("input", function () {
        const keyword = searchInput.value.toLowerCase().trim();
        const cards = document.querySelectorAll(".restaurant-card");

        cards.forEach(card => {
            const name = card.querySelector("h3").innerText.toLowerCase();
            const cuisine = card.innerText.toLowerCase();

            if (name.includes(keyword) || cuisine.includes(keyword)) {
                card.parentElement.style.display = "block";
            } else {
                card.parentElement.style.display = "none";
            }
        });
    });
}


// ================================
// Mouse tracking for floating nutrition cards
// ================================

const hero = document.querySelector(".hero");
const statsCards = document.querySelectorAll(".nutrition-card");
const addBtn = document.querySelector(".circular-add-btn");

if (hero) {
    hero.addEventListener("mousemove", function (e) {
        const x = (e.clientX - window.innerWidth / 2) / (window.innerWidth / 2);
        const y = (e.clientY - window.innerHeight / 2) / (window.innerHeight / 2);

        // Move stats cards slightly in opposite depth directions
        statsCards.forEach((card, index) => {
            const speed = (index + 1) * -8;
            card.style.transform = `translate(${x * speed}px, ${y * speed}px)`;
        });

        // Move circular button
        if (addBtn) {
            addBtn.style.transform = `translate(${x * 10}px, ${y * 10}px)`;
        }
    });
}


// ================================
// Smooth Anchor Scrolling
// ================================

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener("click", function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute("href"));

        if (target) {
            target.scrollIntoView({
                behavior: "smooth"
            });
        }
    });
});