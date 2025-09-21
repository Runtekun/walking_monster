document.addEventListener("turbo:load", () => {
  const initHamburger = () => {
    const button = document.getElementById("hamburgerButton");
    const menu = document.getElementById("hamburgerMenu");

    if (!button || !menu) return;

    const newButton = button.cloneNode(true);
    button.parentNode.replaceChild(newButton, button);

    newButton.addEventListener("click", (e) => {
      e.stopPropagation();
      menu.classList.toggle("hidden");
    });

    document.addEventListener("click", (e) => {
      if (!menu.contains(e.target) && !newButton.contains(e.target)) {
        menu.classList.add("hidden");
      }
    });
  };

  initHamburger();
  document.addEventListener("turbo:render", initHamburger);
});