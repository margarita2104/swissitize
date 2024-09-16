document.addEventListener("turbo:load", function () {
  let playInterval;
  let showAnswerTimeout;
  let switchCardTimeout;
  const playButton = document.getElementById("play");
  const nextButton = document.getElementById("next");
  const answerElement = document.getElementById("answer");

  function updateCard(data) {
    document.getElementById("question").textContent = data.question;
    document.getElementById("answer").textContent = data.answer;
    answerElement.classList.add("hidden");
    document.getElementById(
      "card-index"
    ).textContent = `${data.cardIndex} / ${data.totalCards}`;
  }

  function startPlayMode() {
    playButton.innerHTML = '<img src="/assets/icons/stop-play-cards.svg" alt="Stop">';
    playInterval = setInterval(function () {
      showAnswerTimeout = setTimeout(() => {
        answerElement.classList.remove("hidden"); 
      }, 3000);

      switchCardTimeout = setTimeout(function () {
        nextButton.click();
      }, 6000);
    }, 6000); 
  }

  function stopPlayMode() {
    playButton.innerHTML = '<img src="/assets/icons/play-cards.svg" alt="Play">';
    clearInterval(playInterval);
    clearTimeout(showAnswerTimeout);
    clearTimeout(switchCardTimeout);
    playInterval = null;
  }

  playButton.addEventListener("click", function () {
    if (playInterval) {
      stopPlayMode(); 
    } else {
      startPlayMode(); 
    }
  });

  nextButton.addEventListener("click", function () {
    let cardId = this.dataset.cardId;
    fetch(`/card_collections/${this.dataset.collectionId}/next_card?card_id=${cardId}`, {
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
    .then((response) => response.json())
    .then((data) => {
      updateCard(data);
      this.dataset.cardId = data.next_card_id;
      document.getElementById("prev").dataset.cardId = data.prev_card_id;
    })
    .catch((error) => console.error("Error:", error));
  });

  document.getElementById("prev").addEventListener("click", function () {
    let cardId = this.dataset.cardId;
    fetch(`/card_collections/${this.dataset.collectionId}/previous_card?card_id=${cardId}`, {
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
    .then((response) => response.json())
    .then((data) => {
      updateCard(data);
      this.dataset.cardId = data.prev_card_id;
      document.getElementById("next").dataset.cardId = data.next_card_id;
    })
    .catch((error) => console.error("Error:", error));
  });

  document.getElementById("practice-card").addEventListener("click", function () {
    if (answerElement.classList.contains("hidden")) {
      answerElement.classList.remove("hidden");
    } else {
      answerElement.classList.add("hidden");
    }
  });

  document.getElementById("shuffle").addEventListener("click", function () {
    fetch(`/card_collections/${this.dataset.collectionId}/shuffle_cards`, {
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
    .then((response) => response.json())
    .then((data) => {
      updateCard(data);
      document.getElementById("next").dataset.cardId = data.next_card_id;
      document.getElementById("prev").dataset.cardId = data.prev_card_id;
    })
    .catch((error) => console.error("Error:", error));
  });
});
