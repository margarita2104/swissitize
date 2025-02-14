document.addEventListener("turbo:load", initSidebar);
document.addEventListener("DOMContentLoaded", initSidebar);

function initSidebar() {
  const sideMenu = document.getElementById("side-menu");
  const sideBar = document.getElementById("side-bar");
  const eyeIcon = document.getElementById("eye-icon");
  const sideList = document.getElementById("side-list");
  const toggleButton = document.getElementById("toggle-visibility");
  
  if (sideMenu && sideBar && eyeIcon && sideList && toggleButton) {
    if (localStorage.getItem("sideMenuCollapsed") === "true") {
      collapseSidebar();
    }
    toggleButton.removeEventListener("click", toggleSidebar);
    toggleButton.addEventListener("click", toggleSidebar);
  }
}

function toggleSidebar() {
  const sideMenu = document.getElementById("side-menu");
  const sideBar = document.getElementById("side-bar");
  const eyeIcon = document.getElementById("eye-icon");
  const sideList = document.getElementById("side-list");
  const isCollapsed = sideMenu.classList.toggle("hide-text");
  
  sideBar.classList.toggle("w-[22%]");
  sideList.classList.toggle("items-center");
  eyeIcon.src = isCollapsed ? 
    eyeIcon.dataset.closedIcon : 
    eyeIcon.dataset.openIcon;
  
  localStorage.setItem("sideMenuCollapsed", isCollapsed.toString());
}

function collapseSidebar() {
  document.getElementById("side-menu").classList.add("hide-text");
  document.getElementById("side-bar").classList.remove("w-[22%]");
  document.getElementById("side-list").classList.add("items-center");
  const eyeIcon = document.getElementById("eye-icon");
  eyeIcon.src = eyeIcon.dataset.closedIcon;
}