document.addEventListener("turbo:load", function () {
  document.querySelectorAll("textarea").forEach(function (textarea) {
    function autoResize() {
      textarea.style.height = "auto";
      textarea.style.height = textarea.scrollHeight + "px";
    }

    autoResize();

    textarea.addEventListener("input", autoResize);
  });
});
