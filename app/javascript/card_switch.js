document.addEventListener("turbo:load", function() {
  const cardDataElement = document.getElementById('card-data');
  let cards = JSON.parse(cardDataElement.getAttribute('data-cards'));
  let currentIndex = 0;

  const questionElement = document.getElementById('question');
  const answerElement = document.getElementById('answer');
  const practiceCard = document.getElementById('practice-card');
  
  function updateCard(index) {
    questionElement.textContent = cards[index].question;
    answerElement.textContent = cards[index].answer;
    answerElement.classList.add('hidden'); 
  }

  document.getElementById('next').addEventListener('click', function() {
    if (currentIndex < cards.length - 1) {
      currentIndex++;
      updateCard(currentIndex);
    }
  });

  document.getElementById('prev').addEventListener('click', function() {
    if (currentIndex > 0) {
      currentIndex--;
      updateCard(currentIndex);
    }
  });

  practiceCard.addEventListener('click', function() {
    answerElement.classList.toggle('hidden');
  });

  updateCard(currentIndex);
});
