document.addEventListener("turbo:load", function () {
  const sideMenu = document.getElementById("side-menu");
  const sideBar = document.getElementById("side-bar");
  const eyeIcon = document.getElementById("eye-icon");
  const sideList = document.getElementById("side-list");

  if (localStorage.getItem("sideMenuCollapsed") === "true") {
    sideMenu.classList.add("hide-text");
    sideBar.classList.remove("w-[22%]");
    sideList.classList.add("items-center");
    eyeIcon.src = "/assets/icons/eye-closed.svg";
  }

  document
    .getElementById("toggle-visibility")
    .addEventListener("click", function () {
      const isCollapsed = sideMenu.classList.toggle("hide-text");
      sideBar.classList.toggle("w-[22%]");
      sideList.classList.toggle("items-center");

      if (isCollapsed) {
        eyeIcon.src = "/assets/icons/eye-closed.svg";
        localStorage.setItem("sideMenuCollapsed", "true");
      } else {
        eyeIcon.src = "/assets/icons/eye-open.svg";
        localStorage.setItem("sideMenuCollapsed", "false");
      }
    });
});
