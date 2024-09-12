document.addEventListener("turbo:load", function () {
  document.getElementById("next").addEventListener("click", function () {
    let cardId = this.dataset.cardId;

    fetch(
      `/card_collections/${this.dataset.collectionId}/next_card?card_id=${cardId}`,
      {
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
      }
    )
      .then((response) => response.json())
      .then((data) => {
        document.getElementById("question").textContent = data.question;
        document.getElementById("answer").textContent = data.answer;
        document.getElementById("answer").classList.add("hidden");

        this.dataset.cardId = data.next_card_id;

        document.getElementById("prev").dataset.cardId = data.prev_card_id;
      })
      .catch((error) => console.error("Error:", error));
  });

  document.getElementById("prev").addEventListener("click", function () {
    let cardId = this.dataset.cardId;

    fetch(
      `/card_collections/${this.dataset.collectionId}/previous_card?card_id=${cardId}`,
      {
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
      }
    )
      .then((response) => response.json())
      .then((data) => {
        document.getElementById("question").textContent = data.question;
        document.getElementById("answer").textContent = data.answer;
        document.getElementById("answer").classList.add("hidden");

        this.dataset.cardId = data.prev_card_id;

        document.getElementById("next").dataset.cardId = data.next_card_id;
      })
      .catch((error) => console.error("Error:", error));
  });

  document
    .getElementById("practice-card")
    .addEventListener("click", function () {
      const answerElement = document.getElementById("answer");

      if (answerElement.classList.contains("hidden")) {
        answerElement.classList.remove("hidden");
      } else {
        answerElement.classList.add("hidden");
      }
    });
});
