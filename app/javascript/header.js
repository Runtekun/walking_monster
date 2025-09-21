const initHamburger = () => {
  const button = document.getElementById("hamburgerButton");
  const menu = document.getElementById("hamburgerMenu");

  if (!button || !menu) return;

  if (button.dataset.init) return;
  button.dataset.init = "true";

  button.addEventListener("click", (e) => {
    e.stopPropagation();
    menu.classList.toggle("hidden");
  });

  document.addEventListener("click", (e) => {
    if (!menu.contains(e.target) && !button.contains(e.target)) {
      menu.classList.add("hidden");
    }
  });
};

document.addEventListener("turbo:load", initHamburger);
document.addEventListener("turbo:render", initHamburger);