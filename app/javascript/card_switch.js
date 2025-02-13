document.addEventListener("turbo:load", initCardSwitch);
document.addEventListener("DOMContentLoaded", initCardSwitch);

function initCardSwitch() {
  const playButton = document.getElementById("play");
  const nextButton = document.getElementById("next");
  const prevButton = document.getElementById("prev");
  const shuffleButton = document.getElementById("shuffle");
  const practiceCard = document.getElementById("practice-card");
  const answerElement = document.getElementById("answer");

  let playInterval;
  let showAnswerTimeout;
  let switchCardTimeout;

  function updateCard(data) {
    document.getElementById("question").textContent = data.question;
    document.getElementById("answer").textContent = data.answer;
    answerElement.classList.add("hidden");
    document.getElementById("card-index").textContent = `${data.cardIndex} / ${data.totalCards}`;
  }

  function startPlayMode() {
    playButton.innerHTML = '<img src="/assets/icons/stop-play-cards.svg" alt="Stop">';
    playButton.style.width = "40px";

    playInterval = setInterval(() => {
      showAnswerTimeout = setTimeout(() => {
        answerElement.classList.remove("hidden");
      }, 3000);

      switchCardTimeout = setTimeout(() => {
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

  function fetchCard(url) {
    fetch(url, {
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
      .then(response => response.json())
      .then(data => {
        updateCard(data);
        nextButton.dataset.cardId = data.next_card_id;
        prevButton.dataset.cardId = data.prev_card_id;
      })
      .catch(error => console.error("Error:", error));
  }

  // Event Listeners
  if (playButton) {
    playButton.removeEventListener("click", togglePlayMode);
    playButton.addEventListener("click", togglePlayMode);
  }

  function togglePlayMode() {
    if (playInterval) {
      stopPlayMode();
    } else {
      startPlayMode();
    }
  }

  if (nextButton) {
    nextButton.removeEventListener("click", nextCard);
    nextButton.addEventListener("click", nextCard);
  }

  function nextCard() {
    const cardId = this.dataset.cardId;
    const collectionId = this.dataset.collectionId;
    fetchCard(`/card_collections/${collectionId}/next_card?card_id=${cardId}`);
  }

  if (prevButton) {
    prevButton.removeEventListener("click", prevCard);
    prevButton.addEventListener("click", prevCard);
  }

  function prevCard() {
    const cardId = this.dataset.cardId;
    const collectionId = this.dataset.collectionId;
    fetchCard(`/card_collections/${collectionId}/previous_card?card_id=${cardId}`);
  }

  if (shuffleButton) {
    shuffleButton.removeEventListener("click", shuffleCards);
    shuffleButton.addEventListener("click", shuffleCards);
  }

  function shuffleCards() {
    const collectionId = this.dataset.collectionId;
    fetchCard(`/card_collections/${collectionId}/shuffle_cards`);
  }

  if (practiceCard) {
    practiceCard.removeEventListener("click", toggleAnswer);
    practiceCard.addEventListener("click", toggleAnswer);
  }

  function toggleAnswer() {
    answerElement.classList.toggle("hidden");
  }
}
