import confetti from "canvas-confetti";

document.addEventListener("DOMContentLoaded", () => {
  const success = document.querySelector("#goal-success");
  if (success) {
    confetti({
      particleCount: 100,
      spread: 100,
      origin: { y: 0.6 },
    });
  }
});